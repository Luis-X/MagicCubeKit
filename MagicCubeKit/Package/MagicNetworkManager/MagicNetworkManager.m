//
//  MagicNetworkManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicNetworkManager.h"
#import "AFNetworking.h"

@implementation MagicNetworkManager

/**
 单例
 */
+ (MagicNetworkManager *)shareManager{
    
    static MagicNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MagicNetworkManager new];
    });
    return manager;
    
}


/**
 GET请求

 @param url         接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
- (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(NetworkBlockSuccess)success Failure:(NetworkBlockFailure)failure{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //响应序列化
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:
                                         @"text/plain",
                                         @"application/json",
                                         @"text/html", nil];
    manager.responseSerializer = serializer;
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            //NSLog(@"GET错误: %@", error);
            failure(response, error);
        } else {
            //NSLog(@"GET请求成功%@ %@", response, responseObject);
            success(response, responseObject);
        }
    }];
    [dataTask resume];
}



/**
 POST请求

 @param url         接口
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
- (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters Success:(NetworkBlockSuccess)success Failure:(NetworkBlockFailure)failure{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //响应序列化
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:
                                         @"text/plain",
                                         @"application/json",
                                         @"text/html", nil];
    manager.responseSerializer = serializer;
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            //NSLog(@"POST错误: %@", error);
            failure(response, error);
        } else {
            //NSLog(@"POST请求成功%@ %@", response, responseObject);
            success(response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
