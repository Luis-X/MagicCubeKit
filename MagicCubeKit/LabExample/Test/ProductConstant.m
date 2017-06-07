//
//  ProductConstant.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductConstant.h"

@implementation ProductConstant{
    STPopupController *_stpopupController;
}

+ (ProductConstant *)shareManager{
    
    static ProductConstant *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ProductConstant new];
    });
    return manager;
    
}

- (STPopupController *)showPopViewControllerWithMagicVC:(UIViewController *)magicVC AddController:(UIViewController *)addController CornerRadius:(CGFloat)cornerRadius NavigationBarHidden:(BOOL)navigationBarHidden{
    
    STPopupController *mainSTPopupVC = [[STPopupController alloc] initWithRootViewController:magicVC];
    //样式(中心,底部)
    mainSTPopupVC.style = STPopupStyleBottomSheet;
    //动画效果
    mainSTPopupVC.transitionStyle = STPopupTransitionStyleSlideVertical;
    //透明
    mainSTPopupVC.containerView.backgroundColor = [UIColor clearColor];
    //设置圆角
    mainSTPopupVC.containerView.layer.cornerRadius = 0;
    mainSTPopupVC.backgroundView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.80];
    //隐藏导航栏
    if (navigationBarHidden) {
        mainSTPopupVC.navigationBarHidden = YES;
    }
    [mainSTPopupVC presentInViewController:addController];
    [mainSTPopupVC.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopupController)]];
    _stpopupController = mainSTPopupVC;
    return mainSTPopupVC;
}


/**
 点击背景消失
 */
- (void)dismissPopupController{
    [_stpopupController dismiss];
}

@end
