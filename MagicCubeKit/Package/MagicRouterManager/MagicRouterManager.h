//
//  MagicRouterManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/3.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JLRoutes.h>
#import "ViewController.h"
#import "ExampleTangramViewController.h"
#import "ExampleSJBugVideoKitViewController.h"
#import "ExampleMagicAlertViewViewController.h"
#import "ExampleMagicPermissionManagerViewController.h"
#import "ExampleMagicNetworkingViewController.h"

@interface MagicRouterManager : NSObject
#define Router_HOST @"tiantian://"                                                                                  //协议
#define Router_URL(object, action)  [NSString stringWithFormat:@"%@%@/%@", Router_HOST, (object), (action)]         //跳转

//注册跳转
#define Router_Skip_ViewController                                 Router_URL(@"ViewController", nil)
#define Router_Skip_ExampleTangramViewController                   Router_URL(@"ExampleTangramViewController", nil)
#define Router_Skip_ExampleSJBugVideoKitViewController             Router_URL(@"ExampleSJBugVideoKitViewController", nil)
#define Router_Skip_ExampleMagicAlertViewViewController            Router_URL(@"ExampleMagicAlertViewViewController", nil)
#define Router_Skip_ExampleMagicPermissionManagerViewController    Router_URL(@"ExampleMagicPermissionManagerViewController", nil)
#define Router_Skip_ExampleMagicNetworkingViewController           Router_URL(@"ExampleMagicNetworkingViewController", nil)

+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL AddedNavigationController:(UINavigationController *)navigationController;

@end
