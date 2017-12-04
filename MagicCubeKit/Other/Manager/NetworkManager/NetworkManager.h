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
@end
