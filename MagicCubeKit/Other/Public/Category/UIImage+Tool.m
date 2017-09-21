//
//  UIImage+Tool.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

#pragma mark - 获取
/**
 根据NSData获取UIImage类型
 */
- (NSString *)imageType{
    NSData *data = UIImagePNGRepresentation(self);
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c){
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]){
                return @"webp";
            }
            return nil;
    }
    return nil;
}

/**
 获取图片某一点颜色
 */
- (UIColor *)imagePointColor:(CGPoint)point{
    if (point.x < 0 || point.y < 0) return nil;
    
    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    if (point.x >= width || point.y >= height) return nil;
    
    unsigned char *rawData = malloc(height * width * 4);
    if (!rawData) return nil;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast
                                                 | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        return nil;
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    
    UIColor *result = nil;
    result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    free(rawData);
    return result;
}

#pragma mark - 样式
/**
 圆角
 */
- (UIImage *)imageToCircleImage{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 方形变圆形
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 拉伸
 */
- (UIImage *)imageResizableWithCapInsets:(UIEdgeInsets)insets{
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
    UIImage *result = [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * insets.top, imageW * insets.left, imageH * insets.bottom, imageW * insets.right) resizingMode:UIImageResizingModeStretch];
    return result;
}

#pragma mark - 判断
/**
 两张图是否相同
 */
- (BOOL)isEqualToImage:(UIImage *)image{
    NSData *data1 = UIImagePNGRepresentation(self);
    NSData *data2 = UIImagePNGRepresentation(image);
    return [data1 isEqual:data2];
}

#pragma mark - 功能
/**
 UIImage转Base64
 */
- (NSString *)imageToBase64EncodedString{
    NSString *result = [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return result;
}

/**
 压缩图片
 
 @param maxSize 最大尺寸
 @param quality 质量
 */
- (UIImage *)imageResizeWithMaxSize:(CGSize)maxSize quality:(CGFloat)quality{
    
    float actualHeight = self.size.height;
    float actualWidth = self.size.width;
    float maxHeight = maxSize.height;
    float maxWidth = maxSize.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = quality;
    //quality percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    UIImage *result = [UIImage imageWithData:imageData];
    return result;
    
}

/**
 保存到沙盒
 
 @param fileName 文件名
 */
- (void)imageSaveToSandBoxWithFileName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", fileName]];
    [UIImagePNGRepresentation(self) writeToFile:filePath atomically:YES];
}

/**
 合成两张图片
 */
- (UIImage *)imageToComposeImage:(UIImage *)first image:(UIImage *)second{
    
    CGImageRef firstImageRef = first.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = second.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [first drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [second drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
