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
 */

+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL AddedNavigationController:(UINavigationController *)navigationController{
    
    [[JLRoutes globalRoutes] addRoute:@"/:object/:action" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *object = parameters[@"object"];   //对象
        NSString *action = parameters[@"action"];   //行为
        [self allActionManagementWithNavigationController:navigationController Object:object Action:action];
        return YES;
    }];
    [JLRoutes routeURL:[NSURL URLWithString:routerURL]];
    
}


#pragma mark -处理URL响应事件
/**
 所有事件处理
 
 @param navigationController navigationController
 @param object               对象
 @param action               行为
 */
+ (void)allActionManagementWithNavigationController:(UINavigationController *)navigationController Object:(NSString *)object Action:(NSString *)action{
    
    //NSLog(@"对象:%@\n事件:%@", object, action);
    
    //ViewController
    if ([object isEqualToString:@"ViewController"]) {
        ViewController *vc = [ViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
    }
    //七巧板
    if ([object isEqualToString:@"ExampleTangramViewController"]) {
        ExampleTangramViewController *vc = [ExampleTangramViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
    }
    //录屏、截屏
    if ([object isEqualToString:@"ExampleSJBugVideoKitViewController"]) {
        ExampleSJBugVideoKitViewController *vc = [ExampleSJBugVideoKitViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
    }
    //弹框
    if ([object isEqualToString:@"ExampleMagicAlertViewViewController"]) {
        ExampleMagicAlertViewViewController *vc = [ExampleMagicAlertViewViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
    }
    //权限
    if ([object isEqualToString:@"ExampleMagicPermissionManagerViewController"]) {
        ExampleMagicPermissionManagerViewController *vc = [ExampleMagicPermissionManagerViewController new];
        [UIQuicklyKit navigationController:navigationController pushViewController:vc hidesBottomBar:YES animated:YES];
    }
    
}

@end
