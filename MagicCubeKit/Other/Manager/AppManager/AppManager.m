//
//  AppManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

/**
 是否禁用手机睡眠
 */
+ (void)applicationIdleTimerDisabled:(BOOL)open{
    [UIApplication sharedApplication].idleTimerDisabled = open;
}

/**
 统一收起键盘
 */
+ (void)applicationEndEditing:(BOOL)open{
    [[[UIApplication sharedApplication] keyWindow] endEditing:open];
}


/**
 屏幕亮度
 
 @param value 0-1之间
 */
+ (void)applicationBrightness:(CGFloat)value{
    [[UIScreen mainScreen] setBrightness:value];
}


/**
 切换根视图控制器

 @param rootViewController 根视图控制器
 @param completion         完成
 */
+ (void)applicationChangeRootViewController:(UIViewController *_Nullable)rootViewController completion:(void (^ __nullable)(BOOL finished))completion{
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];

    } completion:completion];
    
}


/**
 打开APP设置
 */
+ (void)applicationOpenSettings{
    
    if (UIApplicationOpenSettingsURLString != NULL) {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:URL options:@{}
               completionHandler:nil];
        } else {
            [application openURL:URL];
        }
    }

}


/**
 获取window
 */
+ (UIWindow *)getApplicationWindow{
    
    UIWindow *result = nil;
    for (id item in [UIApplication sharedApplication].windows) {
        if ([item class] == [UIWindow class]) {
            if (!((UIWindow *)item).hidden) {
                result = item;
                break;
            }
        }
    }
    return result;
}


/**
 获取缓存大小
 */
+ (CGFloat)getApplicationCacheSize{
    
    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    //1.获取 文件夹枚举器
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    __block NSUInteger count = 0;
    //2.遍历
    for (NSString *fileName in enumerator) {
        NSString *path = [myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        count += fileDict.fileSize;
    }
    //3.Bit转MB
    CGFloat result = ((CGFloat)imageCacheSize + count) / 1024 / 1024;
    return result;
    
}


/**
 清理缓存
 */
+ (void)applicationClearCache{
    //1.删除图片缓存
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    //2.删除自己缓存
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
}


/**
 任意位置弹框

 @param title   标题
 @param message 文本
 */
+ (void)applicationShowAlertViewWithTitle:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]]){
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }
    if([rootViewController isKindOfClass:[UITabBarController class]]){
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
    
}
@end
