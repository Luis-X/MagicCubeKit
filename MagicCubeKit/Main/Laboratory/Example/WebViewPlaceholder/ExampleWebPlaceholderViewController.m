//
//  ExampleWebPlaceholderViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleWebPlaceholderViewController.h"
#import "NetworkDisconnectedView.h"
#import <FLAnimatedImageView.h>

@interface ExampleWebPlaceholderViewController ()

@end

@implementation ExampleWebPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMainSubViews];
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

- (void)createMainSubViews{
    
  [NetworkDisconnectedView placeholderAddView:self.view reloadBlock:^{
      NSLog(@"刷新");
  }];
    
}

@end
