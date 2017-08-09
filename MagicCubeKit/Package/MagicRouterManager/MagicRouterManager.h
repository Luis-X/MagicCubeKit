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
#import "MagicWebViewController.h"

@interface MagicRouterManager : NSObject
#define R_HOST @"tiantian://"                                                         //协议
#define R_URL(page)  [NSString stringWithFormat:@"%@%@", R_HOST, (page)]         //跳转

//注册跳转
#define Router_Skip_ViewController                                 R_URL(@"ViewController")
#define Router_Skip_ExampleTangramViewController                   R_URL(@"ExampleTangramViewController")
#define Router_Skip_ExampleSJBugVideoKitViewController             R_URL(@"ExampleSJBugVideoKitViewController")
#define Router_Skip_ExampleMagicAlertViewViewController            R_URL(@"ExampleMagicAlertViewViewController")
#define Router_Skip_ExampleMagicPermissionManagerViewController    R_URL(@"ExampleMagicPermissionManagerViewController")
#define Router_Skip_ExampleMagicNetworkingViewController           R_URL(@"ExampleMagicNetworkingViewController")
#define Router_Skip_ExampleMagicButtonViewController               R_URL(@"ExampleMagicButtonViewController")
#define Router_Skip_ExampleMagicScrollPageViewController           R_URL(@"ExampleMagicScrollPageViewController")
#define Router_Skip_ExampleMagicImageDownloaderViewController      R_URL(@"ExampleMagicImageDownloaderViewController")
#define Router_Skip_ExampleMagicWebProgressViewController          R_URL(@"ExampleMagicWebProgressViewController")
#define Router_Skip_ExampleMagicLoadingViewController              R_URL(@"ExampleMagicLoadingViewController")
#define Router_Skip_ExampleMagicTimerButtonViewController          R_URL(@"ExampleMagicTimerButtonViewController")
#define Router_Skip_ExampleWebViewJavascriptBridgeViewController   R_URL(@"ExampleWebViewJavascriptBridgeViewController")
#define Router_Skip_ExampleReachabilityViewController              R_URL(@"ExampleReachabilityViewController")
#define Router_Skip_ExampleiCarouselViewController                 R_URL(@"ExampleiCarouselViewController")
#define Router_Skip_ExampleWYPopoverControllerViewController       R_URL(@"ExampleWYPopoverControllerViewController")
#define Router_Skip_ExampleMagicDynamicViewController              R_URL(@"ExampleMagicDynamicViewController")
#define Router_Skip_ExampleMagicWebViewController                  R_URL(@"ExampleMagicWebViewController")
#define Router_Skip_MagicWebViewController(url)                    MC_STRING_FORMAT(@"%@?url=%@", R_URL(@"MagicWebViewController"), (url))

+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL AddedNavigationController:(UINavigationController *)navigationController;

@end
