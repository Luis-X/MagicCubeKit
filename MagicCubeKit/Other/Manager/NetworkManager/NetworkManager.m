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

+ (NSString *)httpsSchemeHandler:(NSString *)url{
    
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

+ (NSDictionary<NSString *, id> *)dictionaryFromQuery:(NSString *)query
{
    NSMutableDictionary<NSString *, id> *queryDictionary = [NSMutableDictionary dictionary];
    
    // [a=1, b=2, c=3]
    NSArray<NSString *> *queryComponents = [query componentsSeparatedByString:@"&"];
    for (NSString *keyValueString in queryComponents) {
        // [a, 1]
        NSArray<NSString *> *components = [keyValueString componentsSeparatedByString:@"="];
        if ([components count] == 2) {
            NSString *key = [[components firstObject] stringByRemovingPercentEncoding];
            id value = [[components lastObject] stringByRemovingPercentEncoding];
            
            // Handle multiple entries under the same key as an array
            id existingEntry = queryDictionary[key];
            if (existingEntry) {
                if ([existingEntry isKindOfClass:[NSArray class]]) {
                    value = [existingEntry arrayByAddingObject:value];
                } else {
                    value = @[existingEntry, value];
                }
            }
            
            [queryDictionary setObject:value forKey:key];
        }
    }
    
    return queryDictionary;
}

+ (NSString *)prettyJSONStringFromData:(NSData *)data
{
    NSString *prettyString = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if ([NSJSONSerialization isValidJSONObject:jsonObject]) {
        prettyString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding];
        // NSJSONSerialization escapes forward slashes. We want pretty json, so run through and unescape the slashes.
        prettyString = [prettyString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    } else {
        prettyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return prettyString;
}

+ (BOOL)isValidJSONData:(NSData *)data
{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] ? YES : NO;
}

+ (NSString *)statusCodeStringFromURLResponse:(NSURLResponse *)response
{
    NSString *httpResponseString = nil;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSString *statusCodeDescription = nil;
        if (httpResponse.statusCode == 200) {
            // Prefer OK to the default "no error"
            statusCodeDescription = @"OK";
        } else {
            statusCodeDescription = [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode];
        }
        httpResponseString = [NSString stringWithFormat:@"%ld %@", (long)httpResponse.statusCode, statusCodeDescription];
    }
    return httpResponseString;
}

+ (BOOL)isErrorStatusCodeFromURLResponse:(NSURLResponse *)response
{
    NSIndexSet *errorStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(400, 200)];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        return [errorStatusCodes containsIndex:httpResponse.statusCode];
    }
    
    return NO;
}
@end
