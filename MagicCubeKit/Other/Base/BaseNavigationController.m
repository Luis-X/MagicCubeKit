//
//  BaseNavigationController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 自定义Back
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self customBackButtonWithController:viewController];
    [super pushViewController:viewController animated:animated];
}


/**
 自定义返回
 */
- (void)customBackButtonWithController:(UIViewController *)viewController{
    
    UIImage *backImage = [UIImage imageNamed:@"tabbar_0@2x.png"];
    NSInteger count = self.childViewControllers.count;
    if (count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAction)];
    }
    
}

- (void)popViewControllerAction{
    [self popViewControllerAnimated:YES];
}

@end
