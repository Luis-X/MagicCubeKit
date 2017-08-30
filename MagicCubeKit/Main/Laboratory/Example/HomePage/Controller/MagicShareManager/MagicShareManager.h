//
//  MagicShareManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicActivityViewController.h"
#import "MagicShareWeChat.h"
#import "MagicShareQQ.h"

// ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
// 微博 (需要在项目Build Settings中的Other Linker Flags添加”-ObjC”)
#import "WeiboSDK.h"



@interface MagicShareManager : NSObject<WXApiDelegate>
+ (void)showShareViewAddViewController:(UIViewController *)addViewController;
@end
