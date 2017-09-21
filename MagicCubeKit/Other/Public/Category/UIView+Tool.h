//
//  UIView+Tool.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tool)
// 获取
- (UIViewController *)viewGetViewController;                                                       //获取所处的视图控制器

// 样式
- (void)viewCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;         //圆角、背景(不触发离屏渲染)
- (void)viewRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;                 //任意角圆角
- (void)viewShapeLineColor:(UIColor *)lineColor;                                                   //边框虚线

// 转换
- (UIImage *)viewToUIImage;                                                                        //转为UIImage
- (void)viewSaveToPDFWithfileName:(NSString *)fileName;                                            //转PDF并保存到沙盒

// 移除
- (void)viewRemoveAllSubviews;                                                                     //移除所有子视图
- (void)viewRemoveAllAnimations;                                                                   //移除所有动画
- (void)viewRemoveFromSupervieWithAnimationDuration:(NSTimeInterval)duration;                      //移除自身动画
@end
