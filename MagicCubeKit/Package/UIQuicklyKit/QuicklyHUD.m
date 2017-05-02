//
//  QuicklyHUD.m
//  UIQuicklyKit
//
//  Created by LuisX on 2017/3/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "QuicklyHUD.h"

@implementation QuicklyHUD
#pragma mark - MBProgressHUD
//----------------------------------------------------------------------------------------------------------------------------------
/**
 通用MBProgressHUD

 @param view             添加view
 @param mode             显示样式
 @param animationType    动画类型
 @param cornerRadius     圆角
 @param minSize          最小尺寸
 @param labelText        文本(1行)
 @param labelFont        文本字体
 @param detailsLabelText 详情(n行)
 @param detailsLabelFont 详情字体
 @param margin           边距
 @param yoffset           偏移量(居添加View的Center/不会超出屏幕)
 @param bezelViewColor   面板颜色
 @param backgroundColor  背景颜色
 */
+ (MBProgressHUD *)addCommonHUDAddedTo:(UIView *)view Mode:(MBProgressHUDMode)mode AnimationType:(MBProgressHUDAnimation)animationType CornerRadius:(CGFloat)cornerRadius MinSize:(CGSize)minSize LabelText:(NSString *)labelText LabelFont:(UIFont *)labelFont DetailsLabelText:(NSString *)detailsLabelText DetailsLabelFont:(UIFont *)detailsLabelFont Margin:(CGFloat)margin YOffset:(CGFloat)yoffset BezelViewColor:(UIColor *)bezelViewColor BackgroundColor:(UIColor *)backgroundColor{

    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = mode;                                                        //显示样式           默认:MBProgressHUDModeIndeterminate
    HUD.animationType = animationType;                                      //动画类型           默认:MBProgressHUDAnimationFade
    HUD.cornerRadius = cornerRadius;                                        //圆角              默认:5
    HUD.minSize = minSize;                                                  //最小尺寸           默认:CGSizeZero
    HUD.labelText = labelText;                                              //说明(单行)         默认:nil
    HUD.labelFont = labelFont;                                              //说明字体(单行)      默认:17
    HUD.detailsLabelText = detailsLabelText;                                //详细说明(多行)      默认:nil
    HUD.detailsLabelFont = detailsLabelFont;                                //详细说明字体(多行)   默认:17
    HUD.margin = margin;                                                    //边距               默认:20
    HUD.yOffset = yoffset;                                                  //center偏移量       默认:0,0
    HUD.color = bezelViewColor;                                             //面板颜色
    HUD.backgroundColor = backgroundColor;                                  //背景颜色            默认:nil
    return HUD;
}
/**
 隐藏MBProgressHUD

 @param view 从该view上
 */
+ (void)hiddenMBProgressHUDForView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
//----------------------------------------------------------------------------------------------------------------------------------

/**
 窗口(菊花文本)

 @param text 文本
 */
+ (void)showWindowsProgressHUDText:(NSString *)text{

    [self hiddenMBProgressHUDForView:[UIApplication sharedApplication].keyWindow];
    [self addCommonHUDAddedTo:[UIApplication sharedApplication].keyWindow Mode:MBProgressHUDModeIndeterminate AnimationType:MBProgressHUDAnimationFade CornerRadius:3 MinSize:CGSizeMake(120, 80) LabelText:text LabelFont:[UIFont systemFontOfSize:14] DetailsLabelText:nil DetailsLabelFont:nil Margin:15 YOffset:0 BezelViewColor:[UIColor colorWithWhite:0.00 alpha:0.80] BackgroundColor:nil];

}
/**
 窗口(纯文本)

 @param text 文本
 */
+ (void)showWindowsOnlyTextHUDText:(NSString *)text{

    [self hiddenMBProgressHUDForView:[UIApplication sharedApplication].keyWindow];
    MBProgressHUD *HUD = [self addCommonHUDAddedTo:[UIApplication sharedApplication].keyWindow Mode:MBProgressHUDModeText AnimationType:MBProgressHUDAnimationFade CornerRadius:3 MinSize:CGSizeZero LabelText:nil LabelFont:nil DetailsLabelText:text DetailsLabelFont:[UIFont systemFontOfSize:14] Margin:15 YOffset:0 BezelViewColor:[UIColor colorWithWhite:0.00 alpha:0.80] BackgroundColor:nil];
    [HUD hide:YES afterDelay:1.5];
    [HUD removeFromSuperViewOnHide];

}

/**
 自定义(HUD)

 @param view            添加view
 @param customView      自定义view
 @param animationType   动画类型
 @param cornerRadius    圆角
 @param margin          面板边距
 @param yoffset         偏移center
 @param bezelViewColor  面板颜色
 @param backgroundColor 背景颜色
 */
+ (void)showCustomHUDAddedTo:(UIView *)view CustomView:(UIView *)customView AnimationType:(MBProgressHUDAnimation)animationType CornerRadius:(CGFloat)cornerRadius Margin:(CGFloat)margin YOffset:(CGFloat)yoffset bezelViewColor:(UIColor *)bezelViewColor BackgroundColor:(UIColor *)backgroundColor{

    MBProgressHUD *HUD = [self addCommonHUDAddedTo:view Mode:MBProgressHUDModeCustomView AnimationType:animationType CornerRadius:cornerRadius MinSize:CGSizeZero LabelText:nil LabelFont:nil DetailsLabelText:nil DetailsLabelFont:nil Margin:margin YOffset:yoffset BezelViewColor:bezelViewColor BackgroundColor:backgroundColor];
    HUD.customView = customView;

}


@end
