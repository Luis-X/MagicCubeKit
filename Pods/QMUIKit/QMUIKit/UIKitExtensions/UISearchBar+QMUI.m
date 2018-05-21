//
//  UISearchBar+QMUI.m
//  qmui
//
//  Created by MoLice on 16/5/26.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "UISearchBar+QMUI.h"
#import "QMUICore.h"
#import "UIImage+QMUI.h"
#import "UIView+QMUI.h"

@implementation UISearchBar (QMUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(setPlaceholder:), @selector(qmui_setPlaceholder:));
        ExchangeImplementations([self class], @selector(layoutSubviews), @selector(qmui_layoutSubviews));
        ExchangeImplementations([self class], @selector(setFrame:), @selector(qmui_setFrame:));
    });
}

static char kAssociatedObjectKey_usedAsTableHeaderView;
- (void)setQmui_usedAsTableHeaderView:(BOOL)qmui_usedAsTableHeaderView {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_usedAsTableHeaderView, @(qmui_usedAsTableHeaderView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)qmui_usedAsTableHeaderView {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_usedAsTableHeaderView)) boolValue];
}

- (void)qmui_setPlaceholder:(NSString *)placeholder {
    [self qmui_setPlaceholder:placeholder];
    if (self.qmui_placeholderColor || self.qmui_font) {
        NSMutableDictionary<NSString *, id> *attributes = [[NSMutableDictionary alloc] init];
        if (self.qmui_placeholderColor) {
            attributes[NSForegroundColorAttributeName] = self.qmui_placeholderColor;
        }
        if (self.qmui_font) {
            attributes[NSFontAttributeName] = self.qmui_font;
        }
        self.qmui_textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    }
}

static char kAssociatedObjectKey_PlaceholderColor;
- (void)setQmui_placeholderColor:(UIColor *)qmui_placeholderColor {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_PlaceholderColor, qmui_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.placeholder) {
        // 触发 setPlaceholder 里更新 placeholder 样式的逻辑
        self.placeholder = self.placeholder;
    }
}

- (UIColor *)qmui_placeholderColor {
    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_PlaceholderColor);
}

static char kAssociatedObjectKey_TextColor;
- (void)setQmui_textColor:(UIColor *)qmui_textColor {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_TextColor, qmui_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.qmui_textField.textColor = qmui_textColor;
}

- (UIColor *)qmui_textColor {
    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_TextColor);
}

static char kAssociatedObjectKey_font;
- (void)setQmui_font:(UIFont *)qmui_font {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_font, qmui_font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.placeholder) {
        // 触发 setPlaceholder 里更新 placeholder 样式的逻辑
        self.placeholder = self.placeholder;
    }
    
    // 更新输入框的文字样式
    self.qmui_textField.font = qmui_font;
}

- (UIFont *)qmui_font {
    return (UIFont *)objc_getAssociatedObject(self, &kAssociatedObjectKey_font);
}

- (UITextField *)qmui_textField {
    UITextField *textField = [self valueForKey:@"searchField"];
    return textField;
}

static char kAssociatedObjectKey_textFieldMargins;
- (void)setQmui_textFieldMargins:(UIEdgeInsets)qmui_textFieldMargins {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_textFieldMargins, [NSValue valueWithUIEdgeInsets:qmui_textFieldMargins], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)qmui_textFieldMargins {
    return [((NSValue *)objc_getAssociatedObject(self, &kAssociatedObjectKey_textFieldMargins)) UIEdgeInsetsValue];
}

- (UIButton *)qmui_cancelButton {
    UIButton *cancelButton = [self valueForKey:@"cancelButton"];
    return cancelButton;
}

- (UISegmentedControl *)qmui_segmentedControl {
    // 注意，segmentedControl 只是整条 scopeBar 里的一部分，虽然它的 key 叫做“scopeBar”
    UISegmentedControl *segmentedControl = [self valueForKey:@"scopeBar"];
    return segmentedControl;
}

- (BOOL)qmui_isActive {
    // 某些情况下 scopeBar 是显示在搜索框右边的，所以要区分判断
    CGFloat scopeBarHeight = self.qmui_segmentedControl && self.qmui_segmentedControl.superview.qmui_top < self.qmui_textField.qmui_bottom ? 0 : self.qmui_segmentedControl.superview.qmui_height;
    BOOL result = self.qmui_height - scopeBarHeight == 50;
    return result;
}

- (void)qmui_layoutSubviews {
    [self qmui_layoutSubviews];
    
    [self fixLandscapeStyle];
    [self fixSafeAreaInsetsStyle];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.qmui_textFieldMargins, UIEdgeInsetsZero)) {
        self.qmui_textField.frame = CGRectInsetEdges(self.qmui_textField.frame, self.qmui_textFieldMargins);
    }
    
    [self fix58InchScreenStyle];
}

- (void)fixLandscapeStyle {
    if (self.qmui_usedAsTableHeaderView) {
        if (@available(iOS 11, *)) {
            if ([self qmui_isActive] && IS_LANDSCAPE) {
                // 11.0 及以上的版本，横屏时，searchBar 内部的内容布局会偏上，所以这里强制居中一下
                self.qmui_textField.frame = CGRectSetY(self.qmui_textField.frame, self.qmui_textField.qmui_topWhenCenterInSuperview);
                self.qmui_cancelButton.frame = CGRectSetY(self.qmui_cancelButton.frame, self.qmui_cancelButton.qmui_topWhenCenterInSuperview);
                if (self.qmui_segmentedControl.superview.qmui_top < self.qmui_textField.qmui_bottom) {
                    // scopeBar 显示在搜索框右边
                    self.qmui_segmentedControl.superview.qmui_top = self.qmui_segmentedControl.superview.qmui_topWhenCenterInSuperview;
                }
            }
        }
    }
}

- (void)fixSafeAreaInsetsStyle {
    if (self.qmui_usedAsTableHeaderView) {
        if (@available(iOS 11, *)) {
            // [11.0, 11.1) 这个范围内的 iOS 版本在以 tableHeaderView 的方式使用 searchBar 时，不会根据 safeAreaInsets 自动调整输入框的布局，所以手动处理一下
            if (IOS_VERSION >= 11.1) return;
            
            self.qmui_cancelButton.qmui_right = self.qmui_cancelButton.qmui_right - self.safeAreaInsets.right;
            
            BOOL isScopeBarShowingAtRightOfTextField = IS_LANDSCAPE && [self qmui_isActive] && self.showsScopeBar && (self.qmui_segmentedControl.superview.qmui_top < self.qmui_textField.qmui_bottom);
            
            self.qmui_textField.qmui_extendToLeft = self.qmui_textField.qmui_left + self.safeAreaInsets.left;
            if (isScopeBarShowingAtRightOfTextField) {
                // 如果 scopeBar 显示在搜索框右边，则搜索框右边不用调整
                CGFloat scopeBarHorizontalMargin = 16;
                self.qmui_segmentedControl.superview.qmui_extendToLeft = fmax(self.qmui_textField.qmui_right + scopeBarHorizontalMargin, self.qmui_segmentedControl.superview.qmui_left);
                self.qmui_segmentedControl.superview.qmui_extendToRight = fmin(self.qmui_cancelButton.qmui_left - scopeBarHorizontalMargin, self.qmui_segmentedControl.superview.qmui_right);
            } else {
                // 如果 scopeBar 显示在搜索框下方，则搜索框右边要调整到不与 safeAreaInsets 重叠
                self.qmui_textField.qmui_extendToRight = self.qmui_textField.qmui_right - self.safeAreaInsets.right;
            }
                
                
                
            // 如果是没进入搜索状态就已经显示了 scopeBar，则此时的 scopeBar 一定是在搜索框下方的
            if (![self qmui_isActive] && self.showsScopeBar) {
                self.qmui_segmentedControl.qmui_extendToLeft = self.qmui_segmentedControl.qmui_left + self.safeAreaInsets.left;
                self.qmui_segmentedControl.qmui_extendToRight = self.qmui_segmentedControl.qmui_right - self.safeAreaInsets.right;
            }
        }
    }
}

- (void)fix58InchScreenStyle {
    if (self.qmui_usedAsTableHeaderView) {
        if (@available(iOS 11, *)) {
            if (IOS_VERSION >= 11.1) return;// [11.0, 11.1) 范围内的 iOS 版本才会有问题 https://github.com/QMUI/QMUI_iOS/issues/233
            if (!IS_58INCH_SCREEN) return;
            
            UIView *backgroundView = self.qmui_backgroundView;
            if (!backgroundView) return;
            
            BOOL isActive = !backgroundView.superview.clipsToBounds;
            BOOL isFrameError = backgroundView.safeAreaInsets.top > 0 && CGRectGetMinY(backgroundView.frame) == 0;
            if (isActive && isFrameError) {
                
                // 修改 backgroundView.frame 会导致 searchBar 在进入搜索状态后背景色变成系统默认的（不知道为什么），所以先取出背景图存起来再设置回去
                CGImageRef originImage = (__bridge CGImageRef)backgroundView.layer.contents;
                backgroundView.qmui_extendToTop = -backgroundView.safeAreaInsets.top;
                backgroundView.layer.contents = (__bridge id)originImage;
            }
        }
    }
}

- (UIView *)qmui_backgroundView {
    UIView *backgroundView = [self valueForKey:@"background"];
    return backgroundView;
}

- (void)qmui_setFrame:(CGRect)frame {
    
    if (!self.qmui_usedAsTableHeaderView) {
        [self qmui_setFrame:frame];
        return;
    }
    
    // 重写 setFrame: 是为了这个 issue：https://github.com/QMUI/QMUI_iOS/issues/233
    
    if (@available(iOS 11, *)) {
        // iOS 11 下用 tableHeaderView 的方式使用 searchBar 的话，进入搜索状态时 y 偏上了，导致间距错乱
        
        if (![self qmui_isActive]) {
            [self qmui_setFrame:frame];
            return;
        }
        
        if (IS_58INCH_SCREEN) {
            // 竖屏
            if (CGRectGetMinY(frame) == 38) {
                // searching
                frame = CGRectSetY(frame, 44);
            }
            
            // 横屏
            if (CGRectGetMinY(frame) == -6) {
                frame = CGRectSetY(frame, 0);
            }
        } else {
            
            // 竖屏
            if (CGRectGetMinY(frame) == 14) {
                frame = CGRectSetY(frame, 20);
            }
            
            // 横屏
            if (CGRectGetMinY(frame) == -6) {
                frame = CGRectSetY(frame, 0);
            }
        }
        
        if (self.layer.animationKeys) {
            // 这一段是为了修复进入/退出搜索状态时的抖动
            if (CGRectGetHeight(self.superview.frame) == (CGRectGetHeight(frame) + StatusBarHeight) && !self.showsScopeBar) {
                frame = CGRectSetHeight(frame, 56);
            }
        }
    }
    
    [self qmui_setFrame:frame];
}

- (void)qmui_styledAsQMUISearchBar {
    // 搜索框的字号及 placeholder 的字号
    UIFont *font = SearchBarFont;
    if (font) {
        self.qmui_font = font;
    }

    // 搜索框的文字颜色
    UIColor *textColor = SearchBarTextColor;
    if (textColor) {
        self.qmui_textColor = SearchBarTextColor;
    }

    // placeholder 的文字颜色
    UIColor *placeholderColor = SearchBarPlaceholderColor;
    if (placeholderColor) {
        self.qmui_placeholderColor = SearchBarPlaceholderColor;
    }

    self.placeholder = @"搜索";
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchTextPositionAdjustment = UIOffsetMake(5, 0);

    // 设置搜索icon
    UIImage *searchIconImage = SearchBarSearchIconImage;
    if (searchIconImage) {
        if (!CGSizeEqualToSize(searchIconImage.size, CGSizeMake(13, 13))) {
            NSLog(@"搜索框放大镜图片（SearchBarSearchIconImage）的大小最好为 (13, 13)，否则会失真，目前的大小为 %@", NSStringFromCGSize(searchIconImage.size));
        }
        [self setImage:searchIconImage forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }

    // 设置搜索右边的清除按钮的icon
    UIImage *clearIconImage = SearchBarClearIconImage;
    if (clearIconImage) {
        [self setImage:clearIconImage forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    }

    // 设置SearchBar上的按钮颜色
    self.tintColor = SearchBarTintColor;

    // 输入框背景图
    UIColor *textFieldBackgroundColor = SearchBarTextFieldBackground;
    if (textFieldBackgroundColor) {
        [self setSearchFieldBackgroundImage:[[[UIImage qmui_imageWithColor:textFieldBackgroundColor size:CGSizeMake(60, 28) cornerRadius:SearchBarTextFieldCornerRadius] qmui_imageWithBorderColor:SearchBarTextFieldBorderColor borderWidth:PixelOne cornerRadius:SearchBarTextFieldCornerRadius] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)] forState:UIControlStateNormal];
    }
    
    // 整条bar的背景
    // 为了让 searchBar 底部的边框颜色支持修改，背景色不使用 barTintColor 的方式去改，而是用 backgroundImage
    UIImage *backgroundImage = nil;
    
    UIColor *barTintColor = SearchBarBarTintColor;
    if (barTintColor) {
        backgroundImage = [UIImage qmui_imageWithColor:barTintColor size:CGSizeMake(10, 10) cornerRadius:0];
    }
    
    UIColor *bottomBorderColor = SearchBarBottomBorderColor;
    if (bottomBorderColor) {
        if (!backgroundImage) {
            backgroundImage = [UIImage qmui_imageWithColor:UIColorWhite size:CGSizeMake(10, 10) cornerRadius:0];
        }
        backgroundImage = [backgroundImage qmui_imageWithBorderColor:bottomBorderColor borderWidth:PixelOne borderPosition:QMUIImageBorderPositionBottom];
    }
    
    if (backgroundImage) {
        backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        [self setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    }
}

@end
