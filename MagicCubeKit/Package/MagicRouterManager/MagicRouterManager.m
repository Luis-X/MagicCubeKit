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

+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL AddedNavigationController:(UINavigationController *)navigationController{
    
    [[JLRoutes globalRoutes] addRoute:@"/:object" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        [self allActionManagementWithNavigationController:navigationController parameters:parameters];
        return YES;
    }];
    [JLRoutes routeURL:[NSURL URLWithString:routerURL]];
    
}


#pragma mark -处理URL响应事件
/**
 所有事件处理
 
 @param navigationController navigationController
 @param parameters           参数
 */
+ (void)allActionManagementWithNavigationController:(UINavigationController *)navigationController parameters:(NSDictionary *)parameters{
    
    NSLog(@"参数:%@", parameters);
    // 通用参数
    NSString *JLRoutePattern = [NSString stringWithFormat:@"%@", [parameters objectForKey:@"JLRoutePattern"]];
    NSString *JLRouteScheme = [NSString stringWithFormat:@"%@", [parameters objectForKey:@"JLRouteScheme"]];
    NSString *JLRouteURL = [NSString stringWithFormat:@"%@", [parameters objectForKey:@"JLRouteURL"]];
    // 私有参数
    NSString *page = [parameters objectForKey:@"object"];             //页面
    NSString *url = [JLRouteURL stringByReplacingOccurrencesOfString:Router_Skip_MagicWebViewController(@"") withString:@""];
    
    //ViewController
    if ([page isEqualToString:@"ViewController"]) {
        ViewController *vc = [ViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //七巧板
    if ([page isEqualToString:@"ExampleTangramViewController"]) {
        ExampleTangramViewController *vc = [ExampleTangramViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //录屏、截屏
    if ([page isEqualToString:@"ExampleSJBugVideoKitViewController"]) {
        ExampleSJBugVideoKitViewController *vc = [ExampleSJBugVideoKitViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //弹框
    if ([page isEqualToString:@"ExampleMagicAlertViewViewController"]) {
        ExampleMagicAlertViewViewController *vc = [ExampleMagicAlertViewViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //权限
    if ([page isEqualToString:@"ExampleMagicPermissionManagerViewController"]) {
        ExampleMagicPermissionManagerViewController *vc = [ExampleMagicPermissionManagerViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //网络
    if ([page isEqualToString:@"ExampleMagicNetworkingViewController"]) {
        ExampleMagicNetworkingViewController *vc = [ExampleMagicNetworkingViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //按钮
    if ([page isEqualToString:@"ExampleMagicButtonViewController"]) {
        ExampleMagicButtonViewController *vc = [ExampleMagicButtonViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //分页
    if ([page isEqualToString:@"ExampleMagicScrollPageViewController"]) {
        ExampleMagicScrollPageViewController *vc = [ExampleMagicScrollPageViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //图片下载
    if ([page isEqualToString:@"ExampleMagicImageDownloaderViewController"]) {
        ExampleMagicImageDownloaderViewController *vc = [ExampleMagicImageDownloaderViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //web进度
    if ([page isEqualToString:@"ExampleMagicWebProgressViewController"]) {
        ExampleMagicWebProgressViewController *vc = [ExampleMagicWebProgressViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //加载动画
    if ([page isEqualToString:@"ExampleMagicLoadingViewController"]) {
        ExampleMagicLoadingViewController *vc = [ExampleMagicLoadingViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //倒计时按钮
    if ([page isEqualToString:@"ExampleMagicTimerButtonViewController"]) {
        ExampleMagicTimerButtonViewController *vc = [ExampleMagicTimerButtonViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //JS交互
    if ([page isEqualToString:@"ExampleWebViewJavascriptBridgeViewController"]) {
        ExampleWebViewJavascriptBridgeViewController *vc = [ExampleWebViewJavascriptBridgeViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //3D卡片
    if ([page isEqualToString:@"ExampleiCarouselViewController"]) {
        ExampleiCarouselViewController *vc = [ExampleiCarouselViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //网络状态
    if ([page isEqualToString:@"ExampleReachabilityViewController"]) {
        ExampleReachabilityViewController *vc = [ExampleReachabilityViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //气泡
    if ([page isEqualToString:@"ExampleWYPopoverControllerViewController"]) {
        ExampleWYPopoverControllerViewController *vc = [ExampleWYPopoverControllerViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //动态Cell高度
    if ([page isEqualToString:@"ExampleMagicDynamicViewController"]) {
        ExampleMagicDynamicViewController *vc = [ExampleMagicDynamicViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //WebView优化
    if ([page isEqualToString:@"ExampleMagicWebViewController"]) {
        ExampleMagicWebViewController *vc = [ExampleMagicWebViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
    //MagicWebView
    if ([page isEqualToString:@"MagicWebViewController"]) {
        MagicWebViewController *vc = [[MagicWebViewController alloc] initWithRequestURL:url];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
        return;
    }
}

@end
