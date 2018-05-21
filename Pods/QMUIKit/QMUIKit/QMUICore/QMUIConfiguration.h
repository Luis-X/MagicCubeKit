//
//  QMUIConfiguration.h
//  qmui
//
//  Created by QMUI Team on 15/3/29.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 所有配置表都应该实现的 protocol
@protocol QMUIConfigurationTemplateProtocol <NSObject>

@required
/// 应用配置表的设置
- (void)applyConfigurationTemplate;

@optional
/// 当返回 YES 时，启动 App 的时候 QMUIConfiguration 会自动应用这份配置表。但启动 App 时自动应用的配置表最多只允许一份，如果有多份则其他的会被忽略，需要在某些时机手动应用
- (BOOL)shouldApplyTemplateAutomatically;

@end

/**
 *  维护项目全局 UI 配置的单例，通过业务项目自己的 QMUIConfigurationTemplate 来为这个单例赋值，而业务代码里则通过 QMUIConfigurationMacros.h 文件里的宏来使用这些值。
 */
@interface QMUIConfiguration : NSObject

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Global Color

@property(nonatomic, strong) UIColor            *clearColor;
@property(nonatomic, strong) UIColor            *whiteColor;
@property(nonatomic, strong) UIColor            *blackColor;
@property(nonatomic, strong) UIColor            *grayColor;
@property(nonatomic, strong) UIColor            *grayDarkenColor;
@property(nonatomic, strong) UIColor            *grayLightenColor;
@property(nonatomic, strong) UIColor            *redColor;
@property(nonatomic, strong) UIColor            *greenColor;
@property(nonatomic, strong) UIColor            *blueColor;
@property(nonatomic, strong) UIColor            *yellowColor;

@property(nonatomic, strong) UIColor            *linkColor;
@property(nonatomic, strong) UIColor            *disabledColor;
@property(nonatomic, strong, nullable) UIColor  *backgroundColor;
@property(nonatomic, strong) UIColor            *maskDarkColor;
@property(nonatomic, strong) UIColor            *maskLightColor;
@property(nonatomic, strong) UIColor            *separatorColor;
@property(nonatomic, strong) UIColor            *separatorDashedColor;
@property(nonatomic, strong) UIColor            *placeholderColor;

@property(nonatomic, strong) UIColor            *testColorRed;
@property(nonatomic, strong) UIColor            *testColorGreen;
@property(nonatomic, strong) UIColor            *testColorBlue;

#pragma mark - UIControl

@property(nonatomic, assign) CGFloat            controlHighlightedAlpha;
@property(nonatomic, assign) CGFloat            controlDisabledAlpha;

#pragma mark - UIButton

@property(nonatomic, assign) CGFloat            buttonHighlightedAlpha;
@property(nonatomic, assign) CGFloat            buttonDisabledAlpha;
@property(nonatomic, strong, nullable)  UIColor *buttonTintColor;
@property(nonatomic, strong) UIColor            *ghostButtonColorBlue;
@property(nonatomic, strong) UIColor            *ghostButtonColorRed;
@property(nonatomic, strong) UIColor            *ghostButtonColorGreen;
@property(nonatomic, strong) UIColor            *ghostButtonColorGray;
@property(nonatomic, strong) UIColor            *ghostButtonColorWhite;
@property(nonatomic, strong) UIColor            *fillButtonColorBlue;
@property(nonatomic, strong) UIColor            *fillButtonColorRed;
@property(nonatomic, strong) UIColor            *fillButtonColorGreen;
@property(nonatomic, strong) UIColor            *fillButtonColorGray;
@property(nonatomic, strong) UIColor            *fillButtonColorWhite;

#pragma mark - UITextField & UITextView

@property(nonatomic, strong, nullable) UIColor  *textFieldTintColor;
@property(nonatomic, assign) UIEdgeInsets       textFieldTextInsets;

#pragma mark - NavigationBar

@property(nonatomic, assign) CGFloat            navBarHighlightedAlpha;
@property(nonatomic, assign) CGFloat            navBarDisabledAlpha;
@property(nonatomic, strong, nullable) UIFont   *navBarButtonFont;
@property(nonatomic, strong, nullable) UIFont   *navBarButtonFontBold;
@property(nonatomic, strong, nullable) UIImage  *navBarBackgroundImage;
@property(nonatomic, strong, nullable) UIImage  *navBarShadowImage;
@property(nonatomic, strong, nullable) UIColor  *navBarBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *navBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *navBarTitleColor;
@property(nonatomic, strong, nullable) UIFont   *navBarTitleFont;
@property(nonatomic, strong, nullable) UIColor  *navBarLargeTitleColor;
@property(nonatomic, strong, nullable) UIFont   *navBarLargeTitleFont;
@property(nonatomic, assign) UIOffset           navBarBackButtonTitlePositionAdjustment;
@property(nonatomic, assign) BOOL               sizeNavBarBackIndicatorImageAutomatically;
@property(nonatomic, strong, nullable) UIImage  *navBarBackIndicatorImage;
@property(nonatomic, strong) UIImage            *navBarCloseButtonImage;

@property(nonatomic, assign) CGFloat            navBarLoadingMarginRight;
@property(nonatomic, assign) CGFloat            navBarAccessoryViewMarginLeft;
@property(nonatomic, assign) UIActivityIndicatorViewStyle navBarActivityIndicatorViewStyle;
@property(nonatomic, strong) UIImage            *navBarAccessoryViewTypeDisclosureIndicatorImage;

#pragma mark - TabBar

@property(nonatomic, strong, nullable) UIImage  *tabBarBackgroundImage;
@property(nonatomic, strong, nullable) UIColor  *tabBarBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *tabBarShadowImageColor;
@property(nonatomic, strong, nullable) UIColor  *tabBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *tabBarItemTitleColor;
@property(nonatomic, strong, nullable) UIColor  *tabBarItemTitleColorSelected;
@property(nonatomic, strong, nullable) UIFont   *tabBarItemTitleFont;

#pragma mark - Toolbar

@property(nonatomic, assign) CGFloat            toolBarHighlightedAlpha;
@property(nonatomic, assign) CGFloat            toolBarDisabledAlpha;
@property(nonatomic, strong, nullable) UIColor  *toolBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *toolBarTintColorHighlighted;
@property(nonatomic, strong, nullable) UIColor  *toolBarTintColorDisabled;
@property(nonatomic, strong, nullable) UIImage  *toolBarBackgroundImage;
@property(nonatomic, strong, nullable) UIColor  *toolBarBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *toolBarShadowImageColor;
@property(nonatomic, strong, nullable) UIFont   *toolBarButtonFont;

#pragma mark - SearchBar

@property(nonatomic, strong, nullable) UIColor  *searchBarTextFieldBackground;
@property(nonatomic, strong, nullable) UIColor  *searchBarTextFieldBorderColor;
@property(nonatomic, strong, nullable) UIColor  *searchBarBottomBorderColor;
@property(nonatomic, strong, nullable) UIColor  *searchBarBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *searchBarTintColor;
@property(nonatomic, strong, nullable) UIColor  *searchBarTextColor;
@property(nonatomic, strong, nullable) UIColor  *searchBarPlaceholderColor;
@property(nonatomic, strong, nullable) UIFont   *searchBarFont;
/// 搜索框放大镜icon的图片，大小必须为13x13pt，否则会失真（系统的限制）
@property(nonatomic, strong, nullable) UIImage  *searchBarSearchIconImage;
@property(nonatomic, strong, nullable) UIImage  *searchBarClearIconImage;
@property(nonatomic, assign) CGFloat            searchBarTextFieldCornerRadius;

#pragma mark - TableView / TableViewCell

@property(nonatomic, assign) BOOL               tableViewEstimatedHeightEnabled;

@property(nonatomic, strong, nullable) UIColor  *tableViewBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewGroupedBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableSectionIndexColor;
@property(nonatomic, strong, nullable) UIColor  *tableSectionIndexBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableSectionIndexTrackingBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewSeparatorColor;

@property(nonatomic, assign) CGFloat            tableViewCellNormalHeight;
@property(nonatomic, strong, nullable) UIColor  *tableViewCellTitleLabelColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewCellDetailLabelColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewCellBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewCellSelectedBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewCellWarningBackgroundColor;
@property(nonatomic, strong, nullable) UIImage  *tableViewCellDisclosureIndicatorImage;
@property(nonatomic, strong, nullable) UIImage  *tableViewCellCheckmarkImage;
@property(nonatomic, strong, nullable) UIImage  *tableViewCellDetailButtonImage;
@property(nonatomic, assign) CGFloat tableViewCellSpacingBetweenDetailButtonAndDisclosureIndicator;

@property(nonatomic, strong, nullable) UIColor  *tableViewSectionHeaderBackgroundColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewSectionFooterBackgroundColor;
@property(nonatomic, strong, nullable) UIFont   *tableViewSectionHeaderFont;
@property(nonatomic, strong, nullable) UIFont   *tableViewSectionFooterFont;
@property(nonatomic, strong, nullable) UIColor  *tableViewSectionHeaderTextColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewSectionFooterTextColor;
@property(nonatomic, assign) UIEdgeInsets       tableViewSectionHeaderAccessoryMargins;
@property(nonatomic, assign) UIEdgeInsets       tableViewSectionFooterAccessoryMargins;
@property(nonatomic, assign) UIEdgeInsets       tableViewSectionHeaderContentInset;
@property(nonatomic, assign) UIEdgeInsets       tableViewSectionFooterContentInset;

@property(nonatomic, strong, nullable) UIFont   *tableViewGroupedSectionHeaderFont;
@property(nonatomic, strong, nullable) UIFont   *tableViewGroupedSectionFooterFont;
@property(nonatomic, strong, nullable) UIColor  *tableViewGroupedSectionHeaderTextColor;
@property(nonatomic, strong, nullable) UIColor  *tableViewGroupedSectionFooterTextColor;
@property(nonatomic, assign) UIEdgeInsets       tableViewGroupedSectionHeaderAccessoryMargins;
@property(nonatomic, assign) UIEdgeInsets       tableViewGroupedSectionFooterAccessoryMargins;
@property(nonatomic, assign) CGFloat            tableViewGroupedSectionHeaderDefaultHeight;
@property(nonatomic, assign) CGFloat            tableViewGroupedSectionFooterDefaultHeight;
@property(nonatomic, assign) UIEdgeInsets       tableViewGroupedSectionHeaderContentInset;
@property(nonatomic, assign) UIEdgeInsets       tableViewGroupedSectionFooterContentInset;

#pragma mark - UIWindowLevel

@property(nonatomic, assign) CGFloat            windowLevelQMUIAlertView;
@property(nonatomic, assign) CGFloat            windowLevelQMUIImagePreviewView;

#pragma mark - QMUILog

@property(nonatomic, assign) BOOL               shouldPrintDefaultLog;
@property(nonatomic, assign) BOOL               shouldPrintInfoLog;
@property(nonatomic, assign) BOOL               shouldPrintWarnLog;

#pragma mark - Others

@property(nonatomic, assign) UIInterfaceOrientationMask supportedOrientationMask;
@property(nonatomic, assign) BOOL               automaticallyRotateDeviceOrientation;
@property(nonatomic, assign) BOOL               statusbarStyleLightInitially;
@property(nonatomic, assign) BOOL               needsBackBarButtonItemTitle;
@property(nonatomic, assign) BOOL               hidesBottomBarWhenPushedInitially;
@property(nonatomic, assign) BOOL               preventConcurrentNavigationControllerTransitions;
@property(nonatomic, assign) BOOL               navigationBarHiddenInitially;
@property(nonatomic, assign) BOOL               shouldFixTabBarTransitionBugInIPhoneX;

NS_ASSUME_NONNULL_END

/// 单例对象
+ (instancetype _Nullable )sharedInstance;
- (void)applyInitialTemplate;

@end
