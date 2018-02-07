//
//  UIQuicklyKit.h
//  UIQuicklyKit
//
//  Created by LuisX on 2017/3/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "QuicklyUI.h"
#import "QuicklyHUD.h"

@interface UIQuicklyKit : NSObject
//转场
+ (void)navigationController:(UINavigationController *)navigationController
          pushViewController:(UIViewController *)viewController
              hidesBottomBar:(BOOL)hidesBottomBar
                    animated:(BOOL)animated;
@end
