//
//  NetworkManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (NSString *)domainName{
    return @"https://www.baidu.com";
}

+ (NSString *)verifyURLStringHandler:(NSString *)url{
    
    NSString *result = url;
    // 双斜杠
    if ([result hasPrefix:@"//"]) {
        result = [NSString stringWithFormat:@"https:%@", result];
        return result;
    }
    
    // 绝对路径
    if ([result containsString:@"http://"]) {
        result = [result stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        return result;
    }
    // 相对路径
    if (![result containsString:@"://"]) {
        if ([[result substringToIndex:1] isEqualToString:@"/"]) {
            result = [result substringFromIndex:1];
        }
        result = [NSString stringWithFormat:@"%@%@", [self domainName], result];
    }
    return result;
    
}

@end
