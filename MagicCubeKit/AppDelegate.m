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

@interface AppDelegate ()<UITabBarControllerDelegate>
@property (nonatomic, strong) SJBugVideoTool *bugVideoTool;
@end

@implementation AppDelegate{
    NSMutableArray *_mainTabbarData;
}

/**
 *
 *  七、当应用程序载入后执行
 *
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self startSJBugVideoKit:YES];
    [self initialData];
    [self startMainUIWindow];
    // DDTTYLogger，你的日志语句将被发送到Xcode控制台
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // DDASLLogger，你的日志语句将被发送到苹果文件系统、你的日志状态会被发送到 Console.app
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    // DDFileLogger，你的日志语句将写入到一个文件中，默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;                 // 刷新频率为24小时
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;      // 保存一周的日志，即7天
    [DDLog addLogger:fileLogger];
    
    // 产生Log
    DDLogVerbose(@"Verbose");    // 详细日志
    DDLogDebug(@"Debug");        // 调试日志
    DDLogInfo(@"Info");          // 信息日志
    DDLogWarn(@"Warn");          // 警告日志
    DDLogError(@"Error");        // 错误日志
    
    [MagicAPM start];
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

#pragma mark - 获取AppDelete实例
+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


#pragma mark - UIWindow

- (void)initialData{
    _mainTabbarData = [NSMutableArray arrayWithArray: @[@{@"page" :@"HomeViewController",
                                                                     @"normal" : @"tabbar_0@2x",
                                                                     @"selected" : @"tabbar_0@2x",
                                                                     @"title" : @"首页"},
                                                                   @{@"page" :@"LaboratoryViewController",
                                                                     @"normal" : @"tabbar_1@2x",
                                                                     @"selected" : @"tabbar_1@2x",
                                                                     @"title" : @"实验室"}]];
}

- (void)startMainUIWindow{
    
    UITabBarController *rootTabBarController = [UITabBarController new];
    rootTabBarController.delegate = self;
    rootTabBarController.viewControllers = [self loadingUINavigationControllerWithControllerNames:_mainTabbarData];
    
    //创建一个window对象,属于AppDelegate的属性
    //UIScreen:      表示屏幕硬件类
    //mainScreen:    获得主屏幕信息
    //bounds:        当前手机屏幕大小
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //对窗口的根视图控制器进行赋值操作
    //整个UIKit框架中只有一个根视图控制器,属于window的属性
    //视图控制器用来管理界面和处理界面的逻辑类对象
    //程序启动前必须对根视图控制器赋值
    self.window.rootViewController = rootTabBarController;
    //将window作为主视图并且显示
    [self.window makeKeyAndVisible];
    [self customAllNavigationBarAppearance];
}



- (NSMutableArray *)loadingUINavigationControllerWithControllerNames:(NSArray *)controllerNames{
    
    NSMutableArray *result = [NSMutableArray array];
    [controllerNames enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *page = [NSString stringWithFormat:@"%@", [obj objectForKey:@"page"]];
        NSString *normal = [NSString stringWithFormat:@"%@", [obj objectForKey:@"normal"]];
        NSString *selected = [NSString stringWithFormat:@"%@", [obj objectForKey:@"selected"]];
        NSString *title = [NSString stringWithFormat:@"%@", [obj objectForKey:@"title"]];
        
        Class cls = NSClassFromString(page);
        UIViewController *controller = (UIViewController*)[[cls alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        UIImage *laboratory_normal = [MC_IMAGE_FILE(normal, @"png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *laboratory_selected = [MC_IMAGE_FILE(selected, @"png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:laboratory_normal selectedImage:laboratory_selected];
        [result addObject:navigationController];
        
    }];
    return result;
    
}


#pragma mark - 全局导航栏
- (void)customAllNavigationBarAppearance{
    //背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor randomFlatColor]];
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
- (void)startSJBugVideoKit:(BOOL)start{
    
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
- (void)showSJBugVideo:(BOOL)show{
    
    self.bugVideoTool.hidden = !show;
    if (show == NO) {
        [self.bugVideoTool stopBugVideo];
    }
    
}
@end
