//
//  NSString+Tool.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)
#pragma mark - 判断
/**
 是否为空
 */
- (BOOL)isEqualToNil{
    return self.length <= 0 || [self isEqualToString:@""] || !self;
}

/**
 是否包含空格
 */
- (BOOL)isContainSpace{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

/**
 是否为数字
 */
- (BOOL)isNumber{
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([self rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        return YES;
    }
    return NO;
}

/**
 验证身份证号
 */
- (BOOL)isIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

#pragma mark - 转换
/**
 JSON字符串转NSDictionary
 */
- (NSDictionary *)JSONStringToNSDictionary{
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 移除空格和换行
 */
- (NSString *)removeSpaceAndNewline{
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

/**
 Base64转UIImage
 */
- (UIImage *)base64EncodedStringToUIImage{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *result = [UIImage imageWithData:data];
    return result;
}

/**
 获取字符串中所有数字
 */
- (NSString *)allNumberString{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}
@end
