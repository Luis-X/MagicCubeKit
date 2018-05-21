//
//  UINavigationController+NavigationBarTransition.m
//  qmui
//
//  Created by QMUI Team on 16/2/22.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "UINavigationController+NavigationBarTransition.h"
#import "QMUINavigationController.h"
#import "QMUICore.h"
#import "UINavigationController+QMUI.h"
#import "UIImage+QMUI.h"
#import "UIViewController+QMUI.h"
#import "UINavigationBar+Transition.h"
#import "QMUICommonViewController.h"
#import "QMUINavigationTitleView.h"

@interface _QMUITransitionNavigationBar : UINavigationBar

@end

@implementation _QMUITransitionNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    if (@available(iOS 11, *)) {
        // iOS 11 以前，自己 init 的 navigationBar，它的 backgroundView 默认会一直保持与 navigationBar 的高度相等，但 iOS 11 Beta 1-5 里，自己 init 的 navigationBar.backgroundView.height 默认一直是 44，所以才加上这个兼容
        UIView *backgroundView = [self valueForKey:@"backgroundView"];
        backgroundView.frame = self.bounds;
    }
}

@end

/**
 *  为了响应<b>NavigationBarTransition</b>分类的功能，UIViewController需要做一些相应的支持。
 *  @see UINavigationController+NavigationBarTransition.h
 */
@interface UIViewController (NavigationBarTransition)

/// 用来模仿真的navBar的，在转场过程中存在的一条假navBar
@property(nonatomic, strong) _QMUITransitionNavigationBar *transitionNavigationBar;

/// 是否要把真的navBar隐藏
@property(nonatomic, assign) BOOL prefersNavigationBarBackgroundViewHidden;

/// 原始的clipsToBounds
@property(nonatomic, assign) BOOL originClipsToBounds;

/// 原始containerView的背景色
@property(nonatomic, strong) UIColor *originContainerViewBackgroundColor;

/// 添加假的navBar
- (void)addTransitionNavigationBarIfNeeded;

/// .m文件里自己赋值和使用。因为有些特殊情况下viewDidAppear之后，有可能还会调用到viewWillLayoutSubviews，导致原始的navBar隐藏，所以用这个属性做个保护。
@property(nonatomic, assign) BOOL lockTransitionNavigationBar;

@end


@implementation UIViewController (NavigationBarTransition)

#pragma mark - 主流程

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        ExchangeImplementations(cls, @selector(viewWillLayoutSubviews), @selector(NavigationBarTransition_viewWillLayoutSubviews));
        ExchangeImplementations(cls, @selector(viewWillAppear:), @selector(NavigationBarTransition_viewWillAppear:));
        ExchangeImplementations(cls, @selector(viewDidAppear:), @selector(NavigationBarTransition_viewDidAppear:));
        ExchangeImplementations(cls, @selector(viewDidDisappear:), @selector(NavigationBarTransition_viewDidDisappear:));
    });
}

- (void)NavigationBarTransition_viewWillAppear:(BOOL)animated {
    // 放在最前面，留一个时机给业务可以覆盖
    [self renderNavigationStyleInViewController:self animated:animated];
    [self NavigationBarTransition_viewWillAppear:animated];
}

- (void)NavigationBarTransition_viewDidAppear:(BOOL)animated {
    if (self.transitionNavigationBar) {
        [UIViewController replaceStyleForNavigationBar:self.transitionNavigationBar withNavigationBar:self.navigationController.navigationBar];
        [self removeTransitionNavigationBar];
        self.lockTransitionNavigationBar = YES;
        
        id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.transitionCoordinator;
        [transitionCoordinator containerView].backgroundColor = self.originContainerViewBackgroundColor;
        self.view.clipsToBounds = self.originClipsToBounds;
    }
    self.prefersNavigationBarBackgroundViewHidden = NO;
    [self NavigationBarTransition_viewDidAppear:animated];
}

- (void)NavigationBarTransition_viewDidDisappear:(BOOL)animated {
    if (self.transitionNavigationBar) {
        [self removeTransitionNavigationBar];
        self.lockTransitionNavigationBar = NO;
        
        self.view.clipsToBounds = self.originClipsToBounds;
    }
    [self NavigationBarTransition_viewDidDisappear:animated];
}

- (void)NavigationBarTransition_viewWillLayoutSubviews {
    
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.transitionCoordinator;
    UIViewController *fromViewController = [transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL isCurrentToViewController = (self == self.navigationController.viewControllers.lastObject && self == toViewController);
    BOOL isPushingViewContrller = [self.navigationController.viewControllers containsObject:fromViewController];
    
    if (isCurrentToViewController && !self.lockTransitionNavigationBar) {
        
        BOOL shouldCustomNavigationBarTransition = NO;
        
        if (!self.transitionNavigationBar) {
            
            if (isPushingViewContrller) {
                if ([toViewController canCustomNavigationBarTransitionWhenPushAppearing] ||
                    [fromViewController canCustomNavigationBarTransitionWhenPushDisappearing]) {
                    shouldCustomNavigationBarTransition = YES;
                }
            } else {
                if ([toViewController canCustomNavigationBarTransitionWhenPopAppearing] ||
                    [fromViewController canCustomNavigationBarTransitionWhenPopDisappearing]) {
                    shouldCustomNavigationBarTransition = YES;
                }
            }
            
            if (shouldCustomNavigationBarTransition) {
                if (self.navigationController.navigationBar.translucent) {
                    // 如果原生bar是半透明的，需要给containerView加个背景色，否则有可能会看到下面的默认黑色背景色
                    toViewController.originContainerViewBackgroundColor = [transitionCoordinator containerView].backgroundColor;
                    [transitionCoordinator containerView].backgroundColor = [self containerViewBackgroundColor];
                }
                fromViewController.originClipsToBounds = fromViewController.view.clipsToBounds;
                toViewController.originClipsToBounds = toViewController.view.clipsToBounds;
                fromViewController.view.clipsToBounds = NO;
                toViewController.view.clipsToBounds = NO;
                [self addTransitionNavigationBarIfNeeded];
                [self resizeTransitionNavigationBarFrame];
                self.navigationController.navigationBar.transitionNavigationBar = self.transitionNavigationBar;
                self.prefersNavigationBarBackgroundViewHidden = YES;
            }
        }
    }
    
    [self NavigationBarTransition_viewWillLayoutSubviews];
}

- (void)addTransitionNavigationBarIfNeeded {
    
    if (!self.view.window || !self.navigationController.navigationBar) {
        return;
    }
    
    UINavigationBar *originBar = self.navigationController.navigationBar;
    _QMUITransitionNavigationBar *customBar = [[_QMUITransitionNavigationBar alloc] init];
    
    if (customBar.barStyle != originBar.barStyle) {
        customBar.barStyle = originBar.barStyle;
    }
    if (customBar.translucent != originBar.translucent) {
        customBar.translucent = originBar.translucent;
    }
    if (![customBar.barTintColor isEqual:originBar.barTintColor]) {
        customBar.barTintColor = originBar.barTintColor;
    }
    UIImage *backgroundImage = [originBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    if (backgroundImage && CGSizeEqualToSize(backgroundImage.size, CGSizeZero)) {
        // 假设这里的图片时通过`[UIImage new]`这种形式创建的，那么会navBar会奇怪地显示为系统默认navBar的样式。不知道为什么 navController 设置自己的 navBar 为 [UIImage new] 却没事，所以这里做个保护。
        backgroundImage = [UIImage qmui_imageWithColor:UIColorClear];
    }
    [customBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [customBar setShadowImage:originBar.shadowImage];
    
    self.transitionNavigationBar = customBar;
    [self resizeTransitionNavigationBarFrame];
    
    if (!self.navigationController.navigationBarHidden) {
        [self.view addSubview:self.transitionNavigationBar];
    }
}

- (void)removeTransitionNavigationBar {
    if (!self.transitionNavigationBar) {
        return;
    }
    [self.transitionNavigationBar removeFromSuperview];
    self.transitionNavigationBar = nil;
}

- (void)resizeTransitionNavigationBarFrame {
    if (!self.view.window) {
        return;
    }
    UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"backgroundView"];
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    self.transitionNavigationBar.frame = rect;
}

#pragma mark - 工具方法

// 根据当前的viewController，统一处理导航栏底部的分隔线、状态栏的颜色
- (void)renderNavigationStyleInViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 针对一个 container view controller 里面包含了若干个 view controller，这总情况里面的 view controller 也会相应这个 render 方法，这样就会覆盖 container view controller 的设置，所以应该规避这种情况。
    if (viewController != viewController.navigationController.topViewController) {
        return;
    }
    
    // 以下用于控制 vc 的外观样式，如果某个方法有实现则用方法的返回值，否则再看配置表对应的值是否有配置，有配置就使用配置表，没配置则什么都不做，维持系统原生样式
    if ([viewController conformsToProtocol:@protocol(QMUINavigationControllerAppearanceDelegate)]) {
        UIViewController<QMUINavigationControllerAppearanceDelegate> *vc = (UIViewController<QMUINavigationControllerAppearanceDelegate> *)viewController;
        
        // 控制界面的状态栏颜色
        if ([vc respondsToSelector:@selector(shouldSetStatusBarStyleLight)] && [vc shouldSetStatusBarStyleLight]) {
            if ([[UIApplication sharedApplication] statusBarStyle] < UIStatusBarStyleLightContent) {
                [QMUIHelper renderStatusBarStyleLight];
            }
        } else {
            if ([[UIApplication sharedApplication] statusBarStyle] >= UIStatusBarStyleLightContent) {
                [QMUIHelper renderStatusBarStyleDark];
            }
        }
        
        // 显示/隐藏 导航栏
        if ([vc canCustomNavigationBarTransitionIfBarHiddenable]) {
            if ([vc hideNavigationBarWhenTransitioning]) {
                if (!viewController.navigationController.isNavigationBarHidden) {
                    [viewController.navigationController setNavigationBarHidden:YES animated:animated];
                }
            } else {
                if (viewController.navigationController.isNavigationBarHidden) {
                    [viewController.navigationController setNavigationBarHidden:NO animated:animated];
                }
            }
        }
        
        // 导航栏的背景
        if ([vc respondsToSelector:@selector(navigationBarBackgroundImage)]) {
            UIImage *backgroundImage = [vc navigationBarBackgroundImage];
            [viewController.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        } else {
            UIImage *backgroundImage = NavBarBackgroundImage;
            if (backgroundImage) {
                [viewController.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
            }
        }
        
        // 导航栏底部的分隔线
        if ([vc respondsToSelector:@selector(navigationBarShadowImage)]) {
            UIImage *shadowImage = [vc navigationBarShadowImage];
            [viewController.navigationController.navigationBar setShadowImage:shadowImage];
        } else {
            UIImage *shadowImage = NavBarShadowImage;
            if (shadowImage) {
                [viewController.navigationController.navigationBar setShadowImage:shadowImage];
            }
        }
        
        // 导航栏上控件的主题色
        if ([vc respondsToSelector:@selector(navigationBarTintColor)]) {
            UIColor *tintColor = [vc navigationBarTintColor];
            viewController.navigationController.navigationBar.tintColor = tintColor;
        } else {
            UIColor *tintColor = NavBarTintColor;
            if (tintColor) {
                viewController.navigationController.navigationBar.tintColor = tintColor;
            }
        }
        
        // 导航栏title的颜色
        if ([vc respondsToSelector:@selector(titleViewTintColor)]) {
            UIColor *tintColor = [vc titleViewTintColor];
            if ([vc isKindOfClass:[QMUICommonViewController class]]) {
                ((QMUICommonViewController *)vc).titleView.tintColor = tintColor;
            } else {
                // TODO: molice 对 UIViewController 也支持修改 title 颜色
            }
        } else {
            UIColor *tintColor = NavBarTitleColor;
            if (tintColor) {
                if ([vc isKindOfClass:[QMUICommonViewController class]]) {
                    ((QMUICommonViewController *)vc).titleView.tintColor = tintColor;
                } else {
                    // TODO: molice 对 UIViewController 也支持修改 title 颜色
                }
            }
        }
    }
}

+ (void)replaceStyleForNavigationBar:(UINavigationBar *)navbarA withNavigationBar:(UINavigationBar *)navbarB {
    navbarB.barStyle = navbarA.barStyle;
    navbarB.barTintColor = navbarA.barTintColor;
    [navbarB setBackgroundImage:[navbarA backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    [navbarB setShadowImage:navbarA.shadowImage];
}

// 该 viewController 是否实现自定义 navBar 动画的协议

- (BOOL)respondCustomNavigationBarTransitionWhenPushAppearing {
    BOOL respondPushAppearing = NO;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(shouldCustomNavigationBarTransitionWhenPushAppearing)]) {
            respondPushAppearing = YES;
        }
    }
    return respondPushAppearing;
}

- (BOOL)respondCustomNavigationBarTransitionWhenPushDisappearing {
    BOOL respondPushDisappearing = NO;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(shouldCustomNavigationBarTransitionWhenPushDisappearing)]) {
            respondPushDisappearing = YES;
        }
    }
    return respondPushDisappearing;
}

- (BOOL)respondCustomNavigationBarTransitionWhenPopAppearing {
    BOOL respondPopAppearing = NO;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(shouldCustomNavigationBarTransitionWhenPopAppearing)]) {
            respondPopAppearing = YES;
        }
    }
    return respondPopAppearing;
}

- (BOOL)respondCustomNavigationBarTransitionWhenPopDisappearing {
    BOOL respondPopDisappearing = NO;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(shouldCustomNavigationBarTransitionWhenPopDisappearing)]) {
            respondPopDisappearing = YES;
        }
    }
    return respondPopDisappearing;
}

- (BOOL)respondCustomNavigationBarTransitionIfBarHiddenable {
    BOOL respondIfBarHiddenable = NO;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(shouldCustomizeNavigationBarTransitionIfHideable)]) {
            respondIfBarHiddenable = YES;
        }
    }
    return respondIfBarHiddenable;
}

- (BOOL)respondCustomNavigationBarTransitionWithBarHiddenState {
    BOOL respondWithBarHidden = NO;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(preferredNavigationBarHidden)]) {
            respondWithBarHidden = YES;
        }
    }
    return respondWithBarHidden;
}

// 该 viewController 实现自定义 navBar 动画的协议的返回值

- (BOOL)canCustomNavigationBarTransitionWhenPushAppearing {
    if ([self respondCustomNavigationBarTransitionWhenPushAppearing]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        return [vc shouldCustomNavigationBarTransitionWhenPushAppearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionWhenPushDisappearing {
    if ([self respondCustomNavigationBarTransitionWhenPushDisappearing]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        return [vc shouldCustomNavigationBarTransitionWhenPushDisappearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionWhenPopAppearing {
    if ([self respondCustomNavigationBarTransitionWhenPopAppearing]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        return [vc shouldCustomNavigationBarTransitionWhenPopAppearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionWhenPopDisappearing {
    if ([self respondCustomNavigationBarTransitionWhenPopDisappearing]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        return [vc shouldCustomNavigationBarTransitionWhenPopDisappearing];
    }
    return NO;
}

- (BOOL)canCustomNavigationBarTransitionIfBarHiddenable {
    if ([self respondCustomNavigationBarTransitionIfBarHiddenable]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        return [vc shouldCustomizeNavigationBarTransitionIfHideable];
    }
    return NO;
}

- (BOOL)hideNavigationBarWhenTransitioning {
    if ([self respondCustomNavigationBarTransitionWithBarHiddenState]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        BOOL hidden = [vc preferredNavigationBarHidden];
        return hidden;
    }
    return NO;
}

- (UIColor *)containerViewBackgroundColor {
    UIColor *backgroundColor = UIColorWhite;
    if ([self conformsToProtocol:@protocol(QMUICustomNavigationBarTransitionDelegate)]) {
        UIViewController<QMUICustomNavigationBarTransitionDelegate> *vc = (UIViewController<QMUICustomNavigationBarTransitionDelegate> *)self;
        if ([vc respondsToSelector:@selector(containerViewBackgroundColorWhenTransitioning)]) {
            backgroundColor = [vc containerViewBackgroundColorWhenTransitioning];
        }
    }
    return backgroundColor;
}

#pragma mark - Setter / Getter

- (BOOL)lockTransitionNavigationBar {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLockTransitionNavigationBar:(BOOL)lockTransitionNavigationBar {
    objc_setAssociatedObject(self, @selector(lockTransitionNavigationBar), [[NSNumber alloc] initWithBool:lockTransitionNavigationBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationBar *)transitionNavigationBar {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTransitionNavigationBar:(UINavigationBar *)transitionNavigationBar {
    objc_setAssociatedObject(self, @selector(transitionNavigationBar), transitionNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)prefersNavigationBarBackgroundViewHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPrefersNavigationBarBackgroundViewHidden:(BOOL)prefersNavigationBarBackgroundViewHidden {
    [[self.navigationController.navigationBar valueForKey:@"backgroundView"] setHidden:prefersNavigationBarBackgroundViewHidden];
    objc_setAssociatedObject(self, @selector(prefersNavigationBarBackgroundViewHidden), [[NSNumber alloc] initWithBool:prefersNavigationBarBackgroundViewHidden], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)originClipsToBounds {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setOriginClipsToBounds:(BOOL)originClipsToBounds {
    objc_setAssociatedObject(self, @selector(originClipsToBounds), [[NSNumber alloc] initWithBool:originClipsToBounds], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)originContainerViewBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOriginContainerViewBackgroundColor:(UIColor *)originContainerViewBackgroundColor {
    objc_setAssociatedObject(self, @selector(originContainerViewBackgroundColor), originContainerViewBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UINavigationController (NavigationBarTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        ExchangeImplementations(cls, @selector(pushViewController:animated:), @selector(NavigationBarTransition_pushViewController:animated:));
        ExchangeImplementations(cls, @selector(popViewControllerAnimated:), @selector(NavigationBarTransition_popViewControllerAnimated:));
        ExchangeImplementations(cls, @selector(popToViewController:animated:), @selector(NavigationBarTransition_popToViewController:animated:));
        ExchangeImplementations(cls, @selector(popToRootViewControllerAnimated:), @selector(NavigationBarTransition_popToRootViewControllerAnimated:));
    });
}

- (void)NavigationBarTransition_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (!disappearingViewController) {
        return [self NavigationBarTransition_pushViewController:viewController animated:animated];
    }
    
    BOOL shouldCustomNavigationBarTransition = NO;
    if ([disappearingViewController canCustomNavigationBarTransitionWhenPushDisappearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (!shouldCustomNavigationBarTransition && [viewController canCustomNavigationBarTransitionWhenPushAppearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (shouldCustomNavigationBarTransition) {
        [disappearingViewController addTransitionNavigationBarIfNeeded];
        disappearingViewController.prefersNavigationBarBackgroundViewHidden = YES;
    }

    return [self NavigationBarTransition_pushViewController:viewController animated:animated];
}

- (UIViewController *)NavigationBarTransition_popViewControllerAnimated:(BOOL)animated {
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    UIViewController *appearingViewController = self.viewControllers.count >= 2 ? self.viewControllers[self.viewControllers.count - 2] : nil;
    if (disappearingViewController && appearingViewController) {
        [self handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
    }
    return [self NavigationBarTransition_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)NavigationBarTransition_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    UIViewController *appearingViewController = viewController;
    NSArray<UIViewController *> *poppedViewControllers = [self NavigationBarTransition_popToViewController:viewController animated:animated];
    if (poppedViewControllers) {
        [self handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
    }
    return poppedViewControllers;
}

- (NSArray<UIViewController *> *)NavigationBarTransition_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray<UIViewController *> *poppedViewControllers = [self NavigationBarTransition_popToRootViewControllerAnimated:animated];
    if (self.viewControllers.count > 1) {
        UIViewController *disappearingViewController = self.viewControllers.lastObject;
        UIViewController *appearingViewController = self.viewControllers.firstObject;
        if (poppedViewControllers) {
            [self handlePopViewControllerNavigationBarTransitionWithDisappearViewController:disappearingViewController appearViewController:appearingViewController];
        }
    }
    return poppedViewControllers;
}

- (void)handlePopViewControllerNavigationBarTransitionWithDisappearViewController:(UIViewController *)disappearViewController appearViewController:(UIViewController *)appearViewController {
    BOOL shouldCustomNavigationBarTransition = NO;
    if ([disappearViewController canCustomNavigationBarTransitionWhenPopDisappearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (appearViewController && !shouldCustomNavigationBarTransition && [appearViewController canCustomNavigationBarTransitionWhenPopAppearing]) {
        shouldCustomNavigationBarTransition = YES;
    }
    if (shouldCustomNavigationBarTransition) {
        [disappearViewController addTransitionNavigationBarIfNeeded];
        if (appearViewController.transitionNavigationBar) {
            // 假设从A→B→C，其中A设置了bar的样式，B跟随A所以B里没有设置bar样式的代码，C又把样式改为另一种，此时从C返回B时，由于B没有设置bar的样式的代码，所以bar的样式依然会保留C的，这就错了，所以每次都要手动改回来才保险
            [UIViewController replaceStyleForNavigationBar:appearViewController.transitionNavigationBar withNavigationBar:self.navigationBar];
        }
        disappearViewController.prefersNavigationBarBackgroundViewHidden = YES;
    }
}

@end
