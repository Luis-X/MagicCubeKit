//
//  ExampleMagicAlertViewViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicAlertViewViewController.h"
#import "MagicAlertView.h"

@interface ExampleMagicAlertViewViewController ()

@end

@implementation ExampleMagicAlertViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicAlertView";
    [self createMainView];
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
- (void)createMainView{
    
    UIButton *button = [QuicklyUI quicklyUIButtonAddTo:self.view backgroundColor:[UIColor clearColor] cornerRadius:5];
    [button setTitle:@"SJAlertView" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 2;
    button.layer.cornerRadius = 5;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
        
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Action
- (void)buttonAction:(UIButton *)button{
    
    MagicAlertView *alertView = [MagicAlertView showAlterViewWithTitle:@"标题" content:@"内容" ButtonTitles:@[@"确认", @"取消"] Index:^(NSInteger index) {
        NSLog(@"选择了 %ld", index);
    }];
    [alertView customButtonColor:[UIColor grayColor] index:0];
    [alertView customButtonColor:[UIColor blackColor] index:1];
    
}
@end
