//
//  NSString+Tool.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tool)
// 判断
- (BOOL)isEqualToNil;                                              //空
- (BOOL)isContainSpace;                                            //包含空格
- (BOOL)isNumber;                                                  //数字
- (BOOL)isIdentityCard;                                            //身份证号

// 转换
- (NSDictionary *)JSONStringToNSDictionary;                        //JSON转NSDictionary
- (NSString *)removeSpaceAndNewline;                               //移除空格和换行
- (UIImage *)base64EncodedStringToUIImage;                         //base64转UIImage
- (NSString *)allNumberString;                                     //获取其中所有数字
@end
