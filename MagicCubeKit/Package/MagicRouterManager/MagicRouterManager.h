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
#import "ExampleDrawViewController.h"
#import "ExampleXLFormViewController.h"
#import "ExampleActionSheetPicker3ViewController.h"

@interface MagicRouterManager : NSObject
// 协议
#define R_HOST @"tiantian://"
// 普通页面URL
#define R_URL_NORMAL(page) [NSString stringWithFormat:@"%@%@", R_HOST, (page)]
// web页面URL
#define R_URL_WEB(link) [NSString stringWithFormat:@"%@web?link=%@", R_HOST, (link)]

+ (void)showAnyViewControllerWithRouterURL:(NSString *)routerURL data:(NSDictionary *)data addedNavigationController:(UINavigationController *)navigationController;

@end
