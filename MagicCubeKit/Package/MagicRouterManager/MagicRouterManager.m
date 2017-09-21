//
//  MagicRouterManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/3.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicRouterManager.h"

@implementation MagicRouterManager
/*
 说明:
 根据URL获取相应参数(多参数)
 例如: myapp://post/edit/123?debug=true&foo=bar  处理/:object/:action/:primaryKey 则object为post,action为edit,primaryKey为123
 注意: 不可包含中文
 */

+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL data:(NSDictionary *)data addedNavigationController:(UINavigationController *)navigationController{
    
    routerURL = MC_ENCODE_UTF8(routerURL);      //UTF8编码
    [[JLRoutes globalRoutes] addRoute:@"/:object" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        [self allActionManagementWithNavigationController:navigationController data:data parameters:parameters];
        return YES;
    }];
    [JLRoutes routeURL:[NSURL URLWithString:routerURL]];
    
}


#pragma mark -处理URL响应事件
/**
 所有事件处理
 
 @param navigationController navigationController
 @param data           数据
 @param parameters     参数
 */
+ (void)allActionManagementWithNavigationController:(UINavigationController *)navigationController data:(NSDictionary *)data parameters:(NSDictionary *)parameters{
    
    NSLog(@"参数:%@", parameters);
    // 通用参数
    //NSString *JLRoutePattern = [NSString stringWithFormat:@"%@", [parameters objectForKey:@"JLRoutePattern"]];
    //NSString *JLRouteScheme = [NSString stringWithFormat:@"%@", [parameters objectForKey:@"JLRouteScheme"]];
    NSString *JLRouteURL = [NSString stringWithFormat:@"%@", [parameters objectForKey:@"JLRouteURL"]];
    // 私有参数
    NSString *page = [parameters objectForKey:@"object"];             //页面
    // 匹配控制器
    id viewController = nil;
    
    // ViewController
    if ([page isEqualToString:@"ViewController"]) {
        NSLog(@"数据: %@", data);
        viewController = [ViewController new];
    }
    // MagicWebView
    if ([page isEqualToString:@"web"]) {
        //链接（特殊处理）
        NSString *link = [JLRouteURL stringByReplacingOccurrencesOfString:R_URL_WEB(@"") withString:@""];
        viewController = [[MagicWebViewController alloc] initWithRequestURL:link];
    }
    // 七巧板
    if ([page isEqualToString:@"ExampleTangramViewController"]) {
        viewController = [ExampleTangramViewController new];
    }
    // 录屏、截屏
    if ([page isEqualToString:@"ExampleSJBugVideoKitViewController"]) {
        viewController = [ExampleSJBugVideoKitViewController new];
    }
    // 弹框
    if ([page isEqualToString:@"ExampleMagicAlertViewViewController"]) {
        viewController = [ExampleMagicAlertViewViewController new];
    }
    // 权限
    if ([page isEqualToString:@"ExampleMagicPermissionManagerViewController"]) {
        viewController= [ExampleMagicPermissionManagerViewController new];
    }
    // 网络
    if ([page isEqualToString:@"ExampleMagicNetworkingViewController"]) {
        viewController = [ExampleMagicNetworkingViewController new];
    }
    // 按钮
    if ([page isEqualToString:@"ExampleMagicButtonViewController"]) {
        viewController = [ExampleMagicButtonViewController new];
    }
    // 分页
    if ([page isEqualToString:@"ExampleMagicScrollPageViewController"]) {
        viewController = [ExampleMagicScrollPageViewController new];
    }
    // 图片下载
    if ([page isEqualToString:@"ExampleMagicImageDownloaderViewController"]) {
        viewController = [ExampleMagicImageDownloaderViewController new];
    }
    // web进度
    if ([page isEqualToString:@"ExampleMagicWebProgressViewController"]) {
        viewController = [ExampleMagicWebProgressViewController new];
    }
    // 加载动画
    if ([page isEqualToString:@"ExampleMagicLoadingViewController"]) {
        viewController = [ExampleMagicLoadingViewController new];
    }
    // 倒计时按钮
    if ([page isEqualToString:@"ExampleMagicTimerButtonViewController"]) {
        viewController = [ExampleMagicTimerButtonViewController new];
    }
    // JS交互
    if ([page isEqualToString:@"ExampleWebViewJavascriptBridgeViewController"]) {
        viewController = [ExampleWebViewJavascriptBridgeViewController new];
    }
    // 3D卡片
    if ([page isEqualToString:@"ExampleiCarouselViewController"]) {
        viewController = [ExampleiCarouselViewController new];
    }
    // 网络状态
    if ([page isEqualToString:@"ExampleReachabilityViewController"]) {
        viewController = [ExampleReachabilityViewController new];
    }
    // 气泡
    if ([page isEqualToString:@"ExampleWYPopoverControllerViewController"]) {
        viewController = [ExampleWYPopoverControllerViewController new];
    }
    // 动态Cell高度
    if ([page isEqualToString:@"ExampleMagicDynamicViewController"]) {
        viewController = [ExampleMagicDynamicViewController new];
    }
    // WebView优化
    if ([page isEqualToString:@"ExampleMagicWebViewController"]) {
        viewController = [ExampleMagicWebViewController new];
    }
    // Draw
    if ([page isEqualToString:@"ExampleDrawViewController"]) {
        viewController = [ExampleDrawViewController new];
    }
    // XLForm
    if ([page isEqualToString:@"ExampleXLFormViewController"]) {
        viewController = [ExampleXLFormViewController new];
    }
    // ActionSheetPicker-3.0
    if ([page isEqualToString:@"ExampleActionSheetPicker3ViewController"]) {
        viewController = [ExampleActionSheetPicker3ViewController new];
    }
    
    // 判空
    if ([viewController isKindOfClass:[UIViewController class]] && (viewController != nil)) {
        [UIQuicklyKit navigationController:navigationController pushViewController:viewController hidesBottomBar:YES animated:YES];
    }
    
}

@end
