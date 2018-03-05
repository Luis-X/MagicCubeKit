//
//  AppDelegate.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "AppDelegate.h"

#import "SJBugVideoTool.h"
#import "SJScreenShortManager.h"
#import "MagicAPM.h"
#import "MagicLogManager.h"
#import <WeexSDK.h>

#import "MenuViewController.h"
#import "QDTabBarViewController.h"
#import "QDNavigationController.h"
#import "QDUIKitViewController.h"
#import "QDComponentsViewController.h"
#import "QDLabViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) SJBugVideoTool *bugVideoTool;
@end

@implementation AppDelegate

/**
 *
 *  七、当应用程序载入后执行
 
 *
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self startSJBugVideoKit:YES];
    [self startMainUIWindow];
    [MagicAPM start];
    [[MagicLogManager shareManager] start];

#ifdef MC_BETA
    NSLog(@"测试版本");
#else
    NSLog(@"生产版本");
    [WXApi registerApp:@"wx1639894ad229bb65"];
    TencentOAuth * tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105574446" andDelegate:[MagicShareQQ shareManager]];
    tencentOAuth.redirectURI = @"http://www.showjoy.com";
#endif

    for (NSString * family in [UIFont familyNames]) {
        NSLog(@"familyNames:%@", family);
        for (NSString * name in [UIFont fontNamesForFamilyName:family]) {
            NSLog(@"  name: %@",name);
        }
    }
    
    [self addLogAspect];
    return YES;
}

// 面向切面编程打点逻辑
- (void)addLogAspect
{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSLog(@"View Controller %@ will appear animated: %tu", aspectInfo.instance, animated);
    } error:NULL];
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

#pragma mark - 打开URL回调
/**
 *
 *  十、苹果整合了八、九的功能到此方法(iOS9.0+)
 *  优先级: 高
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [self managerHandleOpenURL:url sourceApplication:[options valueForKey:UIApplicationOpenURLOptionsSourceApplicationKey]];
}

/**
 *
 *  九、通过sourceApplication判断来自哪个App决定是否唤醒自己的App(iOS4.2 – 9.0)
 *  优先级: 中
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
   return [self managerHandleOpenURL:url sourceApplication:sourceApplication];
}

/**
 *
 *  八、打开URL时执行(iOS2.0 – 9.0)
 *  优先级: 低
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self managerHandleOpenURL:url sourceApplication:nil];
}


- (BOOL)managerHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
{

    NSLog(@"来源App: %@", sourceApplication);
    NSLog(@"url协议: %@", [url scheme]);
    NSLog(@"url参数: %@", [url query]);

    // QQ
    if ([TencentApiInterface canOpenURL:url delegate:[MagicShareQQ shareManager]]){
        return [TencentApiInterface handleOpenURL:url delegate:[MagicShareQQ shareManager]];
    }
    // 微信
    return [WXApi handleOpenURL:url delegate:[MagicShareWeChat shareManager]];
    
}

#pragma mark - 获取AppDelete实例
+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


#pragma mark - UIWindow
- (void)startMainUIWindow
{
    UIViewController *rootTabBarViewController = [self loadingUINavigationControllerWithController];
    //创建一个window对象,属于AppDelegate的属性
    //UIScreen:      表示屏幕硬件类
    //mainScreen:    获得主屏幕信息
    //bounds:        当前手机屏幕大小
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //对窗口的根视图控制器进行赋值操作
    //整个UIKit框架中只有一个根视图控制器,属于window的属性
    //视图控制器用来管理界面和处理界面的逻辑类对象
    //程序启动前必须对根视图控制器赋值
    self.window.rootViewController = rootTabBarViewController;
    //将window作为主视图并且显示
    [self.window makeKeyAndVisible];
    [self customAllNavigationBarAppearance];
}

- (UIViewController *)loadingUINavigationControllerWithController
{
   
    // QD自定义的全局样式渲染
    [QDCommonUI renderGlobalAppearances];
    // 预加载 QQ 表情，避免第一次使用时卡顿
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [QDUIHelper qmuiEmotions];
    });

    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
    
    // Menu
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    menuViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *menuNavController = [[QDNavigationController alloc] initWithRootViewController:menuViewController];
    menuNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"菜单" image:[UIImageMake(@"tabbar_1@2x.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"tabbar_1@2x.png") tag:0];
    
    // QMUIKit
    QDUIKitViewController *uikitViewController = [[QDUIKitViewController alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *uikitNavController = [[QDNavigationController alloc] initWithRootViewController:uikitViewController];
    uikitNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"UI" image:[UIImageMake(@"icon_tabbar_uikit") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:1];
    
    // UIComponents
    QDComponentsViewController *componentViewController = [[QDComponentsViewController alloc] init];
    componentViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *componentNavController = [[QDNavigationController alloc] initWithRootViewController:componentViewController];
    componentNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"组件" image:[UIImageMake(@"icon_tabbar_component") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:2];
    
    // Lab
    QDLabViewController *labViewController = [[QDLabViewController alloc] init];
    labViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *labNavController = [[QDNavigationController alloc] initWithRootViewController:labViewController];
    labNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"实验" image:[UIImageMake(@"icon_tabbar_lab") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:3];
    
    // window root controller
    tabBarViewController.viewControllers = @[menuNavController, uikitNavController, componentNavController, labNavController];
    return tabBarViewController;
}


#pragma mark - 全局导航栏
- (void)customAllNavigationBarAppearance
{
    //背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor flatBlackColor]];
    //文本颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //按钮颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //按钮字体
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateNormal];
    //半透明
    [[UINavigationBar appearance] setTranslucent:NO];
    
    
    //标签栏
    [[UITabBar appearance] setTintColor:[UIColor randomFlatColor]];
}

#pragma mark - SJBugVideoKit
- (void)startSJBugVideoKit:(BOOL)start
{
    
    if (start) {
        // 初始化屏幕录制（默认：隐藏）
        self.bugVideoTool = [SJBugVideoTool show];
        // 初始化截屏
        [[SJScreenShortManager shareManager] startScreenShort:YES];
    }
    
}

/**
 BUG录制
 */
- (void)showSJBugVideo:(BOOL)show
{
    
    self.bugVideoTool.hidden = !show;
    if (show == NO) {
        [self.bugVideoTool stopBugVideo];
    }
    
}

- (void)startWeexSDK
{
    //business configuration
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    //init sdk environment
    [WXSDKEngine initSDKEnvironment];
    //register custom module and component，optional
//    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
//    [WXSDKEngine registerHandler:[WXEventModule new] withProtocol:@protocol(WXEventModuleProtocol)];
//    [WXSDKEngine registerHandler:[WXConfigCenterDefaultImpl new] withProtocol:@protocol(WXConfigCenterProtocol)];
    
//    [WXSDKEngine registerComponent:@"select" withClass:NSClassFromString(@"WXSelectComponent")];
//    [WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];
//    [WXSDKEngine registerModule:@"syncTest" withClass:[WXSyncTestModule class]];
//    [WXSDKEngine registerExtendCallNative:@"test" withClass:NSClassFromString(@"WXExtendCallNativeTest")];
//    [WXSDKEngine registerModule:@"ext" withClass:[WXExtModule class]];
    
    //set the log level
#ifdef DEBUG
    [WXDebugTool setDebug:YES];
    [WXLog setLogLevel:WXLogLevelLog];
#else
    [WXDebugTool setDebug:NO];
    [WXLog setLogLevel:WXLogLevelError];
#endif

}

@end
