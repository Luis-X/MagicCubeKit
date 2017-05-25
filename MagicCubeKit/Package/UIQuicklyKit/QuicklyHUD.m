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

 @param view                        添加View
 @param mode                        显示样式
 @param contentColor                内容颜色
 @param animationType               动画类型
 @param offset                      center偏移量
 @param margin                      边距
 @param minSize                     最小尺寸
 @param bezelViewColor              面板颜色
 @param bezelViewStyle              面板样式
 @param bezelViewCornerRadius       面板圆角
 @param backgroundViewColor         背景颜色
 @param backgroundViewStyle         背景样式
 @param labelText                   单行文本
 @param labelFont                   单行字体
 @param detailsLabelText            多行文本
 @param detailsLabelFont            多行字体
 */

+ (MBProgressHUD *)addCommonHUDAddedTo:(UIView *)view
                                  mode:(MBProgressHUDMode)mode
                          contentColor:(UIColor *)contentColor
                         animationType:(MBProgressHUDAnimation)animationType
                                offset:(CGPoint)offset
                                margin:(CGFloat)margin
                               minSize:(CGSize)minSize
                        bezelViewColor:(UIColor *)bezelViewColor
                        bezelViewStyle:(MBProgressHUDBackgroundStyle)bezelViewStyle
                 bezelViewCornerRadius:(CGFloat)bezelViewCornerRadius
                   backgroundViewColor:(UIColor *)backgroundViewColor
                   backgroundViewStyle:(MBProgressHUDBackgroundStyle)backgroundViewStyle
                             labelText:(NSString *)labelText
                             labelFont:(UIFont *)labelFont
                      detailsLabelText:(NSString *)detailsLabelText
                      detailsLabelFont:(UIFont *)detailsLabelFont{

    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //(显示样式)
    if (mode) {
        HUD.mode = mode;                                                        //枚举: MBProgressHUDMode
    }
    //(统一内容颜色)
    if (contentColor) {
        HUD.contentColor = contentColor;                                        //默认: 内容颜色
    }
    //(动画类型)
    if (animationType) {
        HUD.animationType = animationType;                                      //枚举: MBProgressHUDAnimation
    }
    //(center偏移量)
    HUD.offset = offset;                                                        //默认: CGPointZero
    
    //(边距)
    if (margin) {
        HUD.margin = margin;                                                    //默认: 20
    }
    //(最小尺寸)
    HUD.minSize = minSize;                                                      //默认: CGSizeZero
    //(面板)
    if (bezelViewColor) {
        HUD.bezelView.color = bezelViewColor;
    }
    if (bezelViewStyle) {
        HUD.bezelView.style = bezelViewStyle;                                   //枚举: MBProgressHUDBackgroundStyle
    }
    if (bezelViewCornerRadius) {
        HUD.bezelView.layer.cornerRadius = bezelViewCornerRadius;
    }
    //(背景)
    if (backgroundViewColor) {
        HUD.backgroundView.color = backgroundViewColor;
    }
    if (backgroundViewStyle) {
        HUD.backgroundView.style = backgroundViewStyle;                         //枚举: MBProgressHUDBackgroundStyle
    }
    //(单行文本)
    HUD.label.text = labelText;
    HUD.label.font = labelFont;
    //(多行文本)
    HUD.detailsLabel.text = detailsLabelText;
    HUD.detailsLabel.font = detailsLabelFont;
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
    [self addCommonHUDAddedTo:[UIApplication sharedApplication].keyWindow
                         mode:MBProgressHUDModeIndeterminate
                 contentColor:[UIColor whiteColor]
                animationType:MBProgressHUDAnimationFade
                       offset:CGPointZero
                       margin:15
                      minSize:CGSizeZero
               bezelViewColor:[UIColor colorWithWhite:0.00 alpha:0.80]
               bezelViewStyle:MBProgressHUDBackgroundStyleSolidColor
        bezelViewCornerRadius:3
          backgroundViewColor:nil
          backgroundViewStyle:MBProgressHUDBackgroundStyleSolidColor
                    labelText:text
                    labelFont:[UIFont systemFontOfSize:14]
             detailsLabelText:nil
             detailsLabelFont:nil];

}
/**
 窗口(纯文本)

 @param text 文本
 */
+ (void)showWindowsOnlyTextHUDText:(NSString *)text{

    [self hiddenMBProgressHUDForView:[UIApplication sharedApplication].keyWindow];
    MBProgressHUD *HUD = [self addCommonHUDAddedTo:[UIApplication sharedApplication].keyWindow
                         mode:MBProgressHUDModeText
                 contentColor:[UIColor whiteColor]
                animationType:MBProgressHUDAnimationFade
                       offset:CGPointZero
                       margin:15
                      minSize:CGSizeZero
               bezelViewColor:[UIColor colorWithWhite:0.00 alpha:1.00]
               bezelViewStyle:MBProgressHUDBackgroundStyleSolidColor
        bezelViewCornerRadius:3
          backgroundViewColor:nil
          backgroundViewStyle:MBProgressHUDBackgroundStyleSolidColor
                    labelText:text
                    labelFont:[UIFont systemFontOfSize:14]
             detailsLabelText:nil
             detailsLabelFont:nil];
    [HUD hideAnimated:YES afterDelay:1.5];
    [HUD removeFromSuperViewOnHide];

}

/**
 自定义(HUD)

 @param view                    添加view
 @param customView              自定义view
 @param animationType           动画类型
 @param bezelViewCornerRadius   圆角
 @param margin                  面板边距
 @param offset                  偏移center
 @param bezelViewColor          面板颜色
 @param backgroundViewColor     背景颜色
 */
+ (void)showCustomHUDAddedTo:(UIView *)view
                  customView:(UIView *)customView
               animationType:(MBProgressHUDAnimation)animationType
                bezelViewCornerRadius:(CGFloat)bezelViewCornerRadius
                      margin:(CGFloat)margin
                      offset:(CGPoint)offset
              bezelViewColor:(UIColor *)bezelViewColor
             backgroundViewColor:(UIColor *)backgroundViewColor{
    
    MBProgressHUD *HUD = [self addCommonHUDAddedTo:view
                                              mode:MBProgressHUDModeCustomView
                                      contentColor:nil
                                     animationType:animationType
                                            offset:offset
                                            margin:margin
                                           minSize:CGSizeZero
                                    bezelViewColor:bezelViewColor
                                    bezelViewStyle:MBProgressHUDBackgroundStyleSolidColor
                             bezelViewCornerRadius:bezelViewCornerRadius
                               backgroundViewColor:backgroundViewColor
                               backgroundViewStyle:MBProgressHUDBackgroundStyleSolidColor
                                         labelText:nil
                                         labelFont:nil
                                  detailsLabelText:nil
                                  detailsLabelFont:nil];

    HUD.customView = customView;

}


@end
