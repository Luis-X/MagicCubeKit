//
//  HomePageViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "HomePageViewController.h"
#import "ShareQRCodeImageView.h"
@interface HomePageViewController ()
@end

@implementation HomePageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMainTableView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
//主框架
- (void)createMainTableView{
    
    UIImageView *imageView = [ShareQRCodeImageView createMainViewWithBackgroundImage:[UIImage imageNamed:@"shareQRCode_bg_normal.jpg"]];
    [self.view addSubview:imageView];
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


@end
