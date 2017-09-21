//
//  NSDictionary+Tool.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "NSDictionary+Tool.h"

@implementation NSDictionary (Tool)
/**
 NSDictionary转JSON字符串
 */
- (NSString *)dictionaryToJSONString{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
