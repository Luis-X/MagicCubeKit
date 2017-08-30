//
//  MagicActivityViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicActivity.h"
typedef void (^MagicActivityCompletion)(NSInteger selectedIndex);

@interface MagicActivityViewController : UIViewController


/**
 底部弹出分享视图

 @param addViewController 在某个视图控制器中弹出
 @param topCustomView     顶部自定义视图
 @param activitys item数组
 @param activityHeight item高度
 @param completion 选择完成
 */
+ (instancetype)presentAddViewController:(UIViewController *)addViewController
                           topCustomView:(UIView *)topCustomView
                               activitys:(NSArray *)activitys
                          activityHeight:(CGFloat)activityHeight
                              completion:(MagicActivityCompletion)completion;
@end
