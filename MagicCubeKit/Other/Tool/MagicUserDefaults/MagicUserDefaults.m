//
//  MagicUserDefaults.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicUserDefaults.h"

@implementation MagicUserDefaults

/**
 存储

 @param value 值
 @param key   键
 */
+ (void)setObject:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 获取

 @param key 键
 */
+ (id)objectForKey:(NSString *)key{
   return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


/**
 清除

 @param key 键
 */
+ (void)removeObjectForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 清除所有
 */
+ (void)clearAllKeyValue{
    // 方法一
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    // 方法二
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    // 方法三
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
}
@end
