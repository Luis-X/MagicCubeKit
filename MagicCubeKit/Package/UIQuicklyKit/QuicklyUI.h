//
//  QuicklyUI.h
//  
//
//  Created by LuisX on 2017/3/16.
//
//

#import <Foundation/Foundation.h>
#import "UIQuicklyKit.h"

@interface QuicklyUI : NSObject
/*
 *
 * UIKit组件
 *
 */
// UIView
+ (UIView *)quicklyUIViewAddTo:(UIView *)view;
+ (UIView *)quicklyUIViewAddTo:(UIView *)view backgroundColor:(UIColor *)backgroundColor;

// UILabel
+ (UILabel *)quicklyUILabelAddTo:(UIView *)view;
+ (UILabel *)quicklyUILabelAddTo:(UIView *)view font:(UIFont *)font;
+ (UILabel *)quicklyUILabelAddTo:(UIView *)view font:(UIFont *)font textColor:(UIColor *)textColor;

// UIButton
+ (UIButton *)quicklyUIButtonAddTo:(UIView *)view;
+ (UIButton *)quicklyUIButtonAddTo:(UIView *)view backgroundColor:(UIColor *)backgroundColor;
+ (UIButton *)quicklyUIButtonAddTo:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)radius;

// UIImageView
+ (UIImageView *)quicklyUIImageViewAddTo:(UIView *)view;
+ (UIImageView *)quicklyUIImageViewAddTo:(UIView *)view cornerRadius:(CGFloat)radius;
+ (UIImageView *)quicklyUIImageViewAddTo:(UIView *)view cornerRadius:(CGFloat)radius clipsToBounds:(BOOL)clips contentMode:(UIViewContentMode)mode;

// UITextField
+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view;
+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view secureTextEntry:(BOOL)secure clearButtonMode:(UITextFieldViewMode)mode;
+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view font:(UIFont *)font;
+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view font:(UIFont *)font textColor:(UIColor *)textColor;
+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view font:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder;

@end
