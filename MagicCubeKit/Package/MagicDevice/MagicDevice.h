//
//  MagicDevice.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/10/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicDevice : NSObject
+ (NSDictionary *)infoDictionary;
+ (NSString *)appName;
+ (NSString *)appVersion;
+ (NSString *)appBuild;
+ (NSString *)deviceType;
+ (NSString *)deviceSystem;
@end
