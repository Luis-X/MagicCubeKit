//
//  ExampleWebPageAlertViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/11/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleWebPageAlertViewController.h"
#import "WebPageAlertManager.h"

@interface ExampleWebPageAlertViewController ()

@end

@implementation ExampleWebPageAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[WebPageAlertManager shareManager] showWebPageAlert];
    
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
