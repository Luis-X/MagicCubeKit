//
//  UIQuicklyKit.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "UIQuicklyKit.h"

@implementation UIQuicklyKit

/**
 系统push
 
 @param navigationController 导航控制器
 @param viewController       视图控制器
 @param hidesBottomBar       是否隐藏Tabbar
 @param animated             是否动画
 */
+ (void)navigationController:(UINavigationController *)navigationController pushViewController:(UIViewController *)viewController hidesBottomBar:(BOOL)hidesBottomBar animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = hidesBottomBar;
    [navigationController pushViewController:viewController animated:animated];
    
}

@end
