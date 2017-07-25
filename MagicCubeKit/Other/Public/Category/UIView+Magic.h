//
//  UIView+Magic.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Magic)

// 获取
- (UIViewController *)magicGetViewController;                                                       //获取所处的视图控制器

// 样式
- (void)magicCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;         //圆角、背景(不触发离屏渲染)
- (void)magicRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;                 //任意角圆角
- (void)magicShapeLineColor:(UIColor *)lineColor;                                                   //边框虚线

// 转换
- (UIImage *)magicToUIImage;                                                                        //转为UIImage
- (void)magicSaveToPDFWithfileName:(NSString *)fileName;                                            //转PDF并保存到沙盒

// 移除
- (void)magicRemoveAllSubviews;                                                                     //移除所有子视图
- (void)magicRemoveAllAnimations;                                                                   //移除所有动画
- (void)magicRemoveFromSupervieWithAnimationDuration:(NSTimeInterval)duration;                      //移除自身动画

@end
