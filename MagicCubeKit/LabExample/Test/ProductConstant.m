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

/**
 特殊金额样式（¥缩小，其余放大）
 */
+ (void)setRichSignNumberWithLabel:(UILabel*)label BigSize:(CGFloat)bigSize SmallSize:(CGFloat)smallSize Color:(UIColor *)color{
    
    if (label.text == nil) {
        //NSLog(@"过滤空数据");
        return;
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSString *temp = nil;
    for(int i = 0; i < [attributedString length]; i++){
        
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        
        if([temp isEqualToString:@"¥"] || [temp isEqualToString:@"¥"] ||[temp isEqualToString:@"￥"]){
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:smallSize]} range:NSMakeRange(i, 1)];
        }else{
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:bigSize]} range:NSMakeRange(i, 1)];
        }
    }
    
    label.attributedText = attributedString;
    
}

@end
