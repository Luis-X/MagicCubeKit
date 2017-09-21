//
//  UIImage+Tool.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)
// 获取
- (NSString *)imageType;                                                        //获取类型
- (UIColor *)imagePointColor:(CGPoint)point;                                    //获取某点颜色

// 样式
- (UIImage *)imageToCircleImage;                                                //圆角
- (UIImage *)imageResizableWithCapInsets:(UIEdgeInsets)insets;                  //拉伸

// 判断
- (BOOL)isEqualToImage:(UIImage *)image;                                        //图片是否相同

// 功能
- (NSString *)imageToBase64EncodedString;                                               //转为Base64
- (UIImage *)imageResizeWithMaxSize:(CGSize)maxSize quality:(CGFloat)quality;           //压缩
- (void)imageSaveToSandBoxWithFileName:(NSString *)fileName;                            //保存到沙盒
- (UIImage *)imageToComposeImage:(UIImage *)first image:(UIImage *)second;              //图片合成
@end
