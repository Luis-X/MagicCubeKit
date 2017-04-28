//
//  AppDelegate.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 *
 *  七、当应用程序载入后执行
 *
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建一个window对象,属于AppDelegate的属性
    //UIScreen:      表示屏幕硬件类
    //mainScreen:    获得主屏幕信息
    //bounds:        当前手机屏幕大小
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HomeViewController *homeViewController = [HomeViewController new];
    BaseNavigationController *homeNavigationController = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    UIImage *home_normal = [Magic_LoadImage(@"tabbar_0@2x", @"png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *home_selected = [Magic_LoadImage(@"tabbar_0@2x", @"png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:home_normal selectedImage:home_selected];
    //标签栏
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    rootTabBarController.viewControllers = @[homeNavigationController];
    
    //对窗口的根视图控制器进行赋值操作
    //整个UIKit框架中只有一个根视图控制器,属于window的属性
    //视图控制器用来管理界面和处理界面的逻辑类对象
    //程序启动前必须对根视图控制器赋值
    self.window.rootViewController = rootTabBarController;
    //将window作为主视图并且显示
    [self.window makeKeyAndVisible];
    return YES;
}

/**
 *
 *  一、当应用程序将要进入非活动状态执行(在此期间,应用程序不接收消息或事件)
 *
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

/**
 *
 *  三、当应用程序被推送到后台时调用
 *
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

/**
 *
 *  四、当应用程序从后台将要重新回到前台时调用
 *
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

/**
 *
 *  二、当应用程序进入活动状态时执行
 *
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

/**
 *
 *  五、当应用程序要退出时调用(保存数据,退出前清理工作)
 *
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

/**
 *
 *  六、当应用程序终止前会执行这个方法(内存清理,防止程序被终止)
 *
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
}

/**
 *
 *  八、打开URL时执行
 *
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}


@end
