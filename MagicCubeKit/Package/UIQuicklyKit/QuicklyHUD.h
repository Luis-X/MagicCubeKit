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

+ (void)showCustomHUDAddedTo:(UIView *)view CustomView:(UIView *)customView AnimationType:(MBProgressHUDAnimation)animationType CornerRadius:(CGFloat)cornerRadius Margin:(CGFloat)margin YOffset:(CGFloat)yoffset bezelViewColor:(UIColor *)bezelViewColor BackgroundColor:(UIColor *)backgroundColor;
@end
