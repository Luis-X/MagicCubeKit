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
    
    [self startAFNetworkReachabilityManager];
    [self networkActivityIndicatorVisible:YES];
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
        
        [self networkActivityIndicatorVisible:NO];
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
    
    [self startAFNetworkReachabilityManager];
    [self networkActivityIndicatorVisible:YES];
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
        
        [self networkActivityIndicatorVisible:NO];
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

/*
 *监听网络状态
 */
- (void)startAFNetworkReachabilityManager{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                [QuicklyHUD showWindowsOnlyTextHUDText:@"当前设备无网络"];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [QuicklyHUD showWindowsOnlyTextHUDText:@"当前Wi-Fi网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [QuicklyHUD showWindowsOnlyTextHUDText:@"当前蜂窝移动网络"];
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
    
}


/**
 状态栏菊花
 */
- (void)networkActivityIndicatorVisible:(BOOL)open{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = open;
}



#pragma mark -多网络请求示例
/*
- (void)exampleMoreNetwork{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t serialQueue = dispatch_queue_create("magic_gcd_group", DISPATCH_QUEUE_SERIAL);
    
    // 网络请求1
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        [[MagicNetworkManager shareManager] GET:@"网络请求1" Parameters:nil Success:^(NSURLResponse *response, id responseObject) {
            dispatch_group_leave(group);
        } Failure:^(NSURLResponse *response, id error) {
            dispatch_group_leave(group);
        }];
    });
    
    // 网络请求2
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        [[MagicNetworkManager shareManager] GET:@"网络请求2" Parameters:nil Success:^(NSURLResponse *response, id responseObject) {
            dispatch_group_leave(group);
        } Failure:^(NSURLResponse *response, id error) {
            dispatch_group_leave(group);
        }];
    });
    
    // 所有网络请求结束
    dispatch_group_notify(group, serialQueue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 主线程刷新UI
            });
        });
    });
    
}
 */
@end
