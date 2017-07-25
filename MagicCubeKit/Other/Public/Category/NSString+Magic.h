//
//  NSString+Magic.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Magic)

// 判断
- (BOOL)magicIsEqualToNil;                                              //空
- (BOOL)magicIsContainSpace;                                            //包含空格
- (BOOL)magicIsNumber;                                                  //数字
- (BOOL)magicIsIdentityCard;                                            //身份证号

// 转换
- (NSDictionary *)magicParseJSONStringToNSDictionary;                   //JSON转NSDictionary
- (NSString *)magicRemoveSpaceAndNewline;                               //移除空格和换行
- (UIImage *)magicBase64EncodedStringToUIImage;                         //base64转UIImage
- (NSString *)magicGetAllNumberString;                                  //获取其中所有数字
@end
