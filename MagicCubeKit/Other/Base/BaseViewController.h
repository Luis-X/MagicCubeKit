//
//  BaseViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, copy) NSString *mainTitle;

// 方法 【子类可以重写】
- (void)baseBuildDefaultConfig;
- (void)baseBuildSubViews;

// 是否开启摇一摇
- (void)applicationSupportsShakeToEdit:(BOOL)open;

// 上一个视图控制器
- (UIViewController *)baseBackViewController;
@end
