//
//  SJUIKit.h
//  DaRenShop
//
//  Created by LuisX on 2016/11/8.
//  Copyright © 2016年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
@interface SJUIKit : NSObject
//常用控件
+ (UIView *)viewAddView:(UIView *)addView BackgroundColor:(UIColor *)backgroundColor;
+ (UILabel *)labelAddView:(UIView *)addView TextColor:(UIColor *)textColor Font:(UIFont *)font;
+ (UIButton *)buttonAddView:(UIView *)addView Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font CornerRadius:(CGFloat)cornerRadius BackgroundColor:(UIColor *)backgroundColor;
+ (UIImageView *)imageViewAddView:(UIView *)addView ClipsToBounds:(BOOL)clipsToBounds ContentMode:(UIViewContentMode)contentMode;
+ (UITextField *)textfieldAddView:(UIView *)addView Placeholder:(NSString *)placeholder TextColor:(UIColor *)textColor Font:(UIFont *)font;

//HUD
+ (void)hiddenMBProgressHUDForView:(UIView *)view;                                      //隐藏HUD
+ (void)showWindowsProgressHUDText:(NSString *)text;                                    //窗口图文HUD
+ (void)showWindowsOnlyTextHUDText:(NSString *)text;                                    //窗口纯文本HUD
+ (void)showCustomHUDAddedTo:(UIView *)view CustomView:(UIView *)customView AnimationType:(MBProgressHUDAnimation)animationType CornerRadius:(CGFloat)cornerRadius Margin:(CGFloat)margin YOffset:(CGFloat)yoffset bezelViewColor:(UIColor *)bezelViewColor BackgroundColor:(UIColor *)backgroundColor;                                                                     //自定义弹框HUD

+ (double)getItemSizeCollectionWidth:(CGFloat)collectionWidth Num:(NSInteger)num Space:(CGFloat)space;
@end
