//
//  MagicNetworkManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkBlockSuccess)(NSURLResponse *response, id responseObject);  //成功Block
typedef void (^NetworkBlockFailure)(NSURLResponse *response, id error);           //失败Block

@interface MagicNetworkManager : NSObject

+ (MagicNetworkManager *)shareManager;

// GET请求
- (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(NetworkBlockSuccess)success Failure:(NetworkBlockFailure)failure;
// POST请求
- (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters Success:(NetworkBlockSuccess)success Failure:(NetworkBlockFailure)failure;
@end
