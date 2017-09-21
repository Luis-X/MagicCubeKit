//
//  UIView+Tool.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "UIView+Tool.h"

@implementation UIView (Tool)
#pragma mark - 获取
/**
 获取UIView所处的控制器
 */
- (UIViewController *)viewGetViewController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 样式
/**
 不触发离屏渲染圆角
 */
- (void)viewCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

/**
 某角添加圆角
 
 @param corners     某角
 @param cornerRadii 角度
 */
- (void)viewRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 UIView虚线边框
 */
- (void)viewShapeLineColor:(UIColor *)lineColor{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    border.lineDashPattern = @[@4, @2];
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    [self.layer addSublayer:border];
}

#pragma mark - 转换
/**
 转化成UIImage
 */
- (UIImage *)viewToUIImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

/**
 UIView转PDF保存
 
 @param fileName 文件名
 */
- (void)viewSaveToPDFWithfileName:(NSString *)fileName{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:pdfContext];
    UIGraphicsEndPDFContext();
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:fileName];
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"PDF保存到: %@",documentDirectoryFilename);
}

#pragma mark - 移除
/**
 移除所有子视图
 */
- (void)viewRemoveAllSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/**
 移除所有动画
 */
- (void)magicRemoveAllAnimations{
    [self.layer removeAllAnimations];
}


/**
 UIView从父视图移除
 
 @param duration 动画时长
 */
- (void)viewRemoveFromSupervieWithAnimationDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}
@end
