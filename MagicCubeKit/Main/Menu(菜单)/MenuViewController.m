//
//  MenuViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2018/2/6.
//Copyright © 2018年 LuisX. All rights reserved.
//

#import "MenuViewController.h"
#import "HomeViewController.h"
#import "LaboratoryViewController.h"
#import "WeexViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)didInitialized {
    [super didInitialized];
    // init 时做的事情请写在这里
}

- (void)initSubviews {
    [super initSubviews];
    // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 对 self.view 的操作写在这里
}

- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"示例", UIImageMake(@"emotion_01"),
                       @"实验室", UIImageMake(@"emotion_02"),
                       @"Weex", UIImageMake(@"emotion_03"),
                       nil];
}


- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"示例"]) {
        viewController = [[HomeViewController alloc] init];
    }
    else if ([title isEqualToString:@"实验室"]) {
        viewController = [[LaboratoryViewController alloc] init];
    }
    else if ([title isEqualToString:@"Weex"]) {
        viewController = [[WeexViewController alloc] init];
    }
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems
{
    [super setupNavigationItems];
}
@end
