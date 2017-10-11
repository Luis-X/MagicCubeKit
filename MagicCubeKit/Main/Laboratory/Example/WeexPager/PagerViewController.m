//
//  PagerViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "PagerViewController.h"


@interface PagerViewController ()

@end

@implementation PagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor randomFlatColor];
    
    _pageLabel = [UILabel new];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = [UIFont boldSystemFontOfSize:16];
    _pageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_pageLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushViewControllerAction)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewDidLayoutSubviews{
    
    _pageLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
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

- (void)pushViewControllerAction{
    
    UIViewController *emptyViewController = [UIViewController new];
    emptyViewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:emptyViewController animated:YES];
    
}

@end
