//
//  UIImage+Magic.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Magic)

// 获取
- (NSString *)magicGetImageType;                                                        //获取类型
- (UIColor *)magicGetColorWithPoint:(CGPoint)point;                                     //获取某点颜色

// 样式
- (UIImage *)magicToCircleImage;                                                        //圆角
- (UIImage *)magicResizableImageWithCapInsets:(UIEdgeInsets)insets;                     //拉伸

// 判断
- (BOOL)magicIsEqualToImage:(UIImage *)image;                                           //图片是否相同

// 功能
- (NSString *)magicToBase64EncodedString;                                               //转为Base64
- (UIImage *)magicResizeWithMaxSize:(CGSize)maxSize quality:(CGFloat)quality;           //压缩
- (void)magicSaveToSandBoxWithFileName:(NSString *)fileName;                            //保存到沙盒
- (UIImage *)magicToComposeImage:(UIImage *)first image:(UIImage *)second;              //图片合成
@end
