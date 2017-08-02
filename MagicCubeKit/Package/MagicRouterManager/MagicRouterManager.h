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
#import "ExampleMagicButtonViewController.h"
#import "ExampleMagicScrollPageViewController.h"
#import "ExampleMagicImageDownloaderViewController.h"
#import "ExampleMagicWebProgressViewController.h"
#import "ExampleMagicLoadingViewController.h"
#import "ExampleMagicTimerButtonViewController.h"
#import "ExampleWebViewJavascriptBridgeViewController.h"
#import "ExampleReachabilityViewController.h"
#import "ExampleiCarouselViewController.h"
#import "ExampleWYPopoverControllerViewController.h"
#import "ExampleMagicDynamicViewController.h"
#import "ExampleMagicWebViewController.h"

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
#define Router_Skip_ExampleMagicButtonViewController               Router_URL(@"ExampleMagicButtonViewController", nil)
#define Router_Skip_ExampleMagicScrollPageViewController           Router_URL(@"ExampleMagicScrollPageViewController", nil)
#define Router_Skip_ExampleMagicImageDownloaderViewController      Router_URL(@"ExampleMagicImageDownloaderViewController", nil)
#define Router_Skip_ExampleMagicWebProgressViewController          Router_URL(@"ExampleMagicWebProgressViewController", nil)
#define Router_Skip_ExampleMagicLoadingViewController              Router_URL(@"ExampleMagicLoadingViewController", nil)
#define Router_Skip_ExampleMagicTimerButtonViewController          Router_URL(@"ExampleMagicTimerButtonViewController", nil)
#define Router_Skip_ExampleWebViewJavascriptBridgeViewController   Router_URL(@"ExampleWebViewJavascriptBridgeViewController", nil)
#define Router_Skip_ExampleReachabilityViewController              Router_URL(@"ExampleReachabilityViewController", nil)
#define Router_Skip_ExampleiCarouselViewController                 Router_URL(@"ExampleiCarouselViewController", nil)
#define Router_Skip_ExampleWYPopoverControllerViewController       Router_URL(@"ExampleWYPopoverControllerViewController", nil)
#define Router_Skip_ExampleMagicDynamicViewController              Router_URL(@"ExampleMagicDynamicViewController", nil)
#define Router_Skip_ExampleMagicWebViewController                  Router_URL(@"ExampleMagicWebViewController", nil)


+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL AddedNavigationController:(UINavigationController *)navigationController;

@end
