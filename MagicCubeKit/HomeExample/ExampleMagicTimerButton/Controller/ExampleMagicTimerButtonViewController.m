//
//  ExampleMagicTimerButtonViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/23.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicTimerButtonViewController.h"
#import "MagicTimerButton.h"
@interface ExampleMagicTimerButtonViewController ()

@end

@implementation ExampleMagicTimerButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicTimerButton";
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
    
    MagicTimerButton *timeButton = [MagicTimerButton buttonWithType:UIButtonTypeCustom];
    timeButton.normalTitle = @"获取验证码";
    timeButton.timeRunningTitle = @"已发送";
    timeButton.timeDuration = 10;
    timeButton.titleFont = [UIFont systemFontOfSize:14];
    timeButton.normalTitleColor = [UIColor blackColor];
    timeButton.normalBorderColor = [UIColor blackColor];
    timeButton.normalBackgroundColor = [UIColor whiteColor];
    timeButton.timeRunningTitleColor = [UIColor grayColor];
    timeButton.timeRunningBorderColor = [UIColor grayColor];
    timeButton.timeRunningBackgroundColor = [UIColor whiteColor];
    timeButton.layer.borderWidth = 2;
    timeButton.layer.cornerRadius = 5;
    [self.view addSubview:timeButton];
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [timeButton addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)timeButtonAction:(UIButton *)sender{
    
    //开始
    [(MagicTimerButton *)sender start];
    
    //模拟提前结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [(MagicTimerButton *)sender end];
    });
    
}
@end
