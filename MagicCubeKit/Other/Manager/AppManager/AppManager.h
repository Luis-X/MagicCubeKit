//
//  AppManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject
+ (void)startManagerConfig;

// 切换根视图
+ (void)applicationChangeRootViewController:(UIViewController *_Nullable)rootViewController completion:(void (^ __nullable)(BOOL finished))completion;

// 跳转
+ (void)applicationOpenSettings;

// 缓存
+ (CGFloat)getApplicationCacheSize;
+ (void)applicationClearCache;
@end
