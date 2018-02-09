//
//  NetworkManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
// 域名
+ (NSString *)domainName;
// 校验URL
+ (NSString *)httpsSchemeHandler:(NSString *)url;
// 请求参数 (URL.query)
+ (NSDictionary<NSString *, id> *)dictionaryFromQuery:(NSString *)query;
// Data转JSON
+ (NSString *)prettyJSONStringFromData:(NSData *)data;
// 校验JSON
+ (BOOL)isValidJSONData:(NSData *)data;
// 状态码
+ (NSString *)statusCodeStringFromURLResponse:(NSURLResponse *)response;
// 接口异常
+ (BOOL)isErrorStatusCodeFromURLResponse:(NSURLResponse *)response;
@end
