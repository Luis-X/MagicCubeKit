//
//  NSObject+MultipleDelegates.m
//  QMUIKit
//
//  Created by MoLice on 2018/3/27.
//  Copyright © 2018年 QMUI Team. All rights reserved.
//

#import "NSObject+QMUIMultipleDelegates.h"
#import "QMUIMultipleDelegates.h"
#import "QMUICore.h"
#import <objc/runtime.h>

@interface NSObject ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, QMUIMultipleDelegates *> *qmuimd_delegates;
@end

@implementation NSObject (QMUIMultipleDelegates)

static NSMutableSet<NSString *> *qmui_methodsReplacedClasses;

static char kAssociatedObjectKey_qmuiMultipleDelegatesEnabled;
- (void)setQmui_multipleDelegatesEnabled:(BOOL)qmui_multipleDelegatesEnabled {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_qmuiMultipleDelegatesEnabled, @(qmui_multipleDelegatesEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (qmui_multipleDelegatesEnabled) {
        if (!self.qmuimd_delegates) {
            self.qmuimd_delegates = [NSMutableDictionary dictionary];
        }
        [self qmui_registerDelegateSelector:@selector(delegate)];
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) {
            [self qmui_registerDelegateSelector:@selector(dataSource)];
        }
    }
}

- (BOOL)qmui_multipleDelegatesEnabled {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_qmuiMultipleDelegatesEnabled)) boolValue];
}

static char kAssociatedObjectKey_qmuiDelegates;
- (void)setQmuimd_delegates:(NSMutableDictionary<NSString *,QMUIMultipleDelegates *> *)qmuimd_delegates {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_qmuiDelegates, qmuimd_delegates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,QMUIMultipleDelegates *> *)qmuimd_delegates {
    return (NSMutableDictionary<NSString *,QMUIMultipleDelegates *> *)objc_getAssociatedObject(self, &kAssociatedObjectKey_qmuiDelegates);
}

- (void)qmui_registerDelegateSelector:(SEL)getter {
    if (!self.qmui_multipleDelegatesEnabled) {
        return;
    }
    
    Class targetClass = [self class];
    SEL originDelegateSetter = [self originSetterWithGetter:getter];
    SEL newDelegateSetter = [self newSetterWithGetter:getter];
    Method originMethod = class_getInstanceMethod(targetClass, originDelegateSetter);
    if (!originMethod) {
        return;
    }
    
    // 为这个 selector 创建一个 QMUIMultipleDelegates 容器
    NSString *delegateGetterKey = NSStringFromSelector(getter);
    if (!self.qmuimd_delegates[delegateGetterKey]) {
        self.qmuimd_delegates[delegateGetterKey] = [[QMUIMultipleDelegates alloc] init];
    }
    
    // 避免为某个 class 重复替换同一个方法的实现
    if (!qmui_methodsReplacedClasses) {
        qmui_methodsReplacedClasses = [NSMutableSet set];
    }
    NSString *classAndMethodIdentifier = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(targetClass), delegateGetterKey];
    if ([qmui_methodsReplacedClasses containsObject:classAndMethodIdentifier]) {
        return;
    }
    [qmui_methodsReplacedClasses addObject:classAndMethodIdentifier];
    
    IMP originIMP = method_getImplementation(originMethod);
    void (*originSelectorIMP)(id, SEL, id);
    originSelectorIMP = (void (*)(id, SEL, id))originIMP;
    
    BOOL isAddedMethod = class_addMethod(targetClass, newDelegateSetter, imp_implementationWithBlock(^(NSObject *selfObject, id aDelegate){
        
        // 这一段保护的原因请查看 https://github.com/QMUI/QMUI_iOS/issues/292
        if (!selfObject.qmui_multipleDelegatesEnabled || selfObject.class != targetClass) {
            originSelectorIMP(selfObject, originDelegateSetter, aDelegate);
            return;
        }
        
        if (!aDelegate) {
            // 对应 setDelegate:nil，表示清理所有的 delegate
            [selfObject.qmuimd_delegates[delegateGetterKey] removeAllDelegates];
            
            // 只要 qmui_multipleDelegatesEnabled 开启，就会保证 delegate 一直是 delegates，所以不去调用系统默认的 set nil
//            originSelectorIMP(selfObject, originDelegateSetter, nil);
            return;
        }
        
        QMUIMultipleDelegates *delegates = selfObject.qmuimd_delegates[delegateGetterKey];
        if (aDelegate != delegates) {// 过滤掉容器自身，避免把 delegates 传进去 delegates 里，导致死循环
            [delegates addDelegate:aDelegate];
        }
        originSelectorIMP(selfObject, originDelegateSetter, nil);// 先置为 nil 再设置 delegates，从而避免这个问题 https://github.com/QMUI/QMUI_iOS/issues/305
        originSelectorIMP(selfObject, originDelegateSetter, delegates);// 不管外面将什么 object 传给 setDelegate:，最终实际上传进去的都是 QMUIMultipleDelegates 容器
        
    }), method_getTypeEncoding(originMethod));
    if (isAddedMethod) {
        Method newMethod = class_getInstanceMethod(targetClass, newDelegateSetter);
        method_exchangeImplementations(originMethod, newMethod);
    }
}

- (void)qmui_removeDelegate:(id)delegate {
    if (!self.qmui_multipleDelegatesEnabled) {
        return;
    }
    NSMutableArray<NSString *> *delegateGetters = [[NSMutableArray alloc] init];
    [self.qmuimd_delegates enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, QMUIMultipleDelegates * _Nonnull obj, BOOL * _Nonnull stop) {
        BOOL removeSucceed = [obj removeDelegate:delegate];
        if (removeSucceed) {
            [delegateGetters addObject:key];
        }
    }];
    if (delegateGetters.count > 0) {
        for (NSString *getterString in delegateGetters) {
            [self refreshDelegateWithGetter:NSSelectorFromString(getterString)];
        }
    }
}

- (void)refreshDelegateWithGetter:(SEL)getter {
    SEL originSetterSEL = [self newSetterWithGetter:getter];
    BeginIgnorePerformSelectorLeaksWarning
    id originDelegate = [self performSelector:getter];
    [self performSelector:originSetterSEL withObject:nil];// 先置为 nil 再设置 delegates，从而避免这个问题 https://github.com/QMUI/QMUI_iOS/issues/305
    [self performSelector:originSetterSEL withObject:originDelegate];
    EndIgnorePerformSelectorLeaksWarning
}

// 根据 delegate property 的 getter，得到它对应的 setter
- (SEL)originSetterWithGetter:(SEL)getter {
    NSString *getterString = NSStringFromSelector(getter);
    NSMutableString *setterString = [[NSMutableString alloc] initWithString:@"set"];
    [setterString appendString:[getterString substringToIndex:1].uppercaseString];
    [setterString appendString:[getterString substringFromIndex:1]];
    [setterString appendString:@":"];
    SEL setter = NSSelectorFromString(setterString);
    return setter;
}

// 根据 delegate property 的 getter，得到 QMUIMultipleDelegates 为它的 setter 创建的新 setter 方法，最终交换原方法，因此利用这个方法返回的 SEL，可以调用到原来的 delegate property setter 的实现
- (SEL)newSetterWithGetter:(SEL)getter {
    return NSSelectorFromString([NSString stringWithFormat:@"qmuimd_%@", NSStringFromSelector([self originSetterWithGetter:getter])]);
}

@end
