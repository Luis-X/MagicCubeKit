//
//  MagicShareManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicShareManager.h"
#import "MagicActivityViewController.h"

@implementation MagicShareManager
+ (void)showShareViewAddViewController:(UIViewController *)addViewController{
    
    MagicActivity *activity0 = [MagicActivity activityWithTitle:@"微信好友" iconFontCode:@"\U0000e6e7"];
    MagicActivity *activity1 = [MagicActivity activityWithTitle:@"朋友圈" iconFontCode:@"\U0000e6e5"];
    MagicActivity *activity2 = [MagicActivity activityWithTitle:@"QQ好友" iconFontCode:@"\U0000e6e6"];
    [MagicActivityViewController presentAddViewController:[UIApplication sharedApplication].keyWindow.rootViewController
                                            topCustomView:nil
                                                activitys:@[activity0, activity1, activity2]
                                           activityHeight:100
                                               completion:^(NSInteger selectedIndex) {
                                                   if (selectedIndex == 0) {
                                                       [[MagicShareWeChat shareManager] shareToWechatWithText:@"123" scene:WXSceneSession];
                                                   }
                                                   if (selectedIndex == 1) {
                                                       [[MagicShareWeChat shareManager] shareToWechatWithText:@"123" scene:WXSceneTimeline];
                                                   }
                                                   if (selectedIndex == 2) {
                                                       [[MagicShareQQ shareManager] shareToQQWithText:@"123"];
                                                   }
                                               }];
}

@end
