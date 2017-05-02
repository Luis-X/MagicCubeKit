//
//  QuicklyUI.m
//  
//
//  Created by LuisX on 2017/3/16.
//
//

#import "QuicklyUI.h"

@implementation QuicklyUI

#pragma mark - UIView
+ (UIView *)quicklyUIViewAddTo:(UIView *)view{
    
     UIView *baseView = [UIView new];
     //baseView.backgroundColor = [UIColor brownColor];
     [view addSubview:baseView];
     return baseView;
    
}

+ (UIView *)quicklyUIViewAddTo:(UIView *)view backgroundColor:(UIColor *)backgroundColor{
    
    UIView *baseView = [self quicklyUIViewAddTo:view];
    baseView.backgroundColor = backgroundColor;
    return baseView;
    
}

#pragma mark - UILabel
+ (UILabel *)quicklyUILabelAddTo:(UIView *)view{
    
    UILabel *label = [UILabel new];
    //label.backgroundColor = [UIColor brownColor];
    [view addSubview:label];
    return label;

}

+ (UILabel *)quicklyUILabelAddTo:(UIView *)view font:(UIFont *)font{
    
    UILabel *label = [self quicklyUILabelAddTo:view];
    label.font = font;
    return label;
    
}

+ (UILabel *)quicklyUILabelAddTo:(UIView *)view font:(UIFont *)font textColor:(UIColor *)textColor{
    
    UILabel *label = [self quicklyUILabelAddTo:view font:font];
    label.textColor = textColor;
    return label;
    
}

#pragma mark - UIButton
+ (UIButton *)quicklyUIButtonAddTo:(UIView *)view{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor brownColor];
    [view addSubview:button];
    return button;
    
}

+ (UIButton *)quicklyUIButtonAddTo:(UIView *)view backgroundColor:(UIColor *)backgroundColor{
    
    UIButton *button = [self quicklyUIButtonAddTo:view];
    button.backgroundColor = backgroundColor;
    return button;
    
}

+ (UIButton *)quicklyUIButtonAddTo:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)radius{
    
    UIButton *button = [self quicklyUIButtonAddTo:view backgroundColor:backgroundColor];
    button.layer.cornerRadius = radius;
    return button;
    
}

#pragma mark - UIImageView
+ (UIImageView *)quicklyUIImageViewAddTo:(UIView *)view{

    UIImageView *imageView = [UIImageView new];
    //imageView.backgroundColor = [UIColor brownColor];
    [view addSubview:imageView];
    return imageView;
    
}


+ (UIImageView *)quicklyUIImageViewAddTo:(UIView *)view cornerRadius:(CGFloat)radius{
    
    UIImageView *imageView = [self quicklyUIImageViewAddTo:view];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = radius;
    return imageView;
    
}

+ (UIImageView *)quicklyUIImageViewAddTo:(UIView *)view cornerRadius:(CGFloat)radius clipsToBounds:(BOOL)clips contentMode:(UIViewContentMode)mode{
    
    UIImageView *imageView = [self quicklyUIImageViewAddTo:view cornerRadius:radius];
    imageView.clipsToBounds = clips;
    imageView.contentMode = mode;
    return imageView;
    
}

#pragma mark - UITextField
+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view{
    
    UITextField *textField = [UITextField new];
    //textField.backgroundColor = [UIColor brownColor];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;        //关闭首字母大写
    textField.autocorrectionType = UITextAutocorrectionTypeNo;                  //关闭自动更正
    [view addSubview:textField];
    return textField;
    
}

+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view secureTextEntry:(BOOL)secure clearButtonMode:(UITextFieldViewMode)mode{
    
    UITextField *textField = [self quicklyUITextFieldAddTo:view];
    textField.secureTextEntry = secure;
    textField.clearButtonMode = mode;
    return textField;
    
}

+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view font:(UIFont *)font{
    
    UITextField *textField = [self quicklyUITextFieldAddTo:view];
    textField.font = font;
    return textField;
    
}

+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view font:(UIFont *)font textColor:(UIColor *)textColor{
    
    UITextField *textField = [self quicklyUITextFieldAddTo:view font:font];
    textField.textColor = textColor;
    return textField;
    
}

+ (UITextField *)quicklyUITextFieldAddTo:(UIView *)view font:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder{
    
    UITextField *textField = [self quicklyUITextFieldAddTo:view font:font textColor:textColor];
    textField.placeholder = placeholder;
    return textField;
    
}
@end
