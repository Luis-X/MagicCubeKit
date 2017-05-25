//
//  QuicklyHUD.h
//  UIQuicklyKit
//
//  Created by LuisX on 2017/3/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIQuicklyKit.h"

@interface QuicklyHUD : NSObject
/*
 *
 * MBProgressHUD
 *
 */
+ (void)hiddenMBProgressHUDForView:(UIView *)view;                                      //隐藏HUD

+ (void)showWindowsProgressHUDText:(NSString *)text;                                    //窗口图文HUD

+ (void)showWindowsOnlyTextHUDText:(NSString *)text;                                    //窗口纯文本HUD

+ (void)showCustomHUDAddedTo:(UIView *)view
                  customView:(UIView *)customView
               animationType:(MBProgressHUDAnimation)animationType
       bezelViewCornerRadius:(CGFloat)bezelViewCornerRadius
                      margin:(CGFloat)margin
                      offset:(CGPoint)offset
              bezelViewColor:(UIColor *)bezelViewColor
         backgroundViewColor:(UIColor *)backgroundViewColor;
@end
