//
//  ExampleMagicTimerButtonViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/23.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicTimerButtonViewController.h"
#import "MagicTimerManager.h"
@interface ExampleMagicTimerButtonViewController ()
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, assign) __block int timeout;
@end

@implementation ExampleMagicTimerButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicTimerManager";
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
#pragma mark - 倒计时
- (void)createMainView{
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    timeButton.backgroundColor = [UIColor redColor];
    timeButton.layer.borderWidth = 2;
    timeButton.layer.cornerRadius = 5;
    [self.view addSubview:timeButton];
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [timeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _button = timeButton;
    
}

// 获取单例倒计时
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([MagicTimerManager shareManager].timeout > 0) {
        _timeout = [MagicTimerManager shareManager].timeout; //倒计时时间
        [self timerCountDown];
    }
    
}

// 记录单例倒计时
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.timeout > 0) {
        if ([MagicTimerManager shareManager].timeout == 0) {
            [MagicTimerManager shareManager].timeout = _timeout;
            [[MagicTimerManager shareManager] countDown];
        }
        _timeout = 0;//置为0，释放controller
    }
    
}


/**
 按钮时间
 */
- (void)buttonAction:(id)sender {
    _timeout = 60;          //倒计时时间
    [self timerCountDown];
}

/**
 GCD计时器逻辑
 */
- (void)timerCountDown{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(_timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{   //计时结束
                _button.enabled = YES;
                [_button setTitle:@"重新获取" forState:UIControlStateNormal];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{  //计时中
                [_button setTitle:[NSString stringWithFormat:@"%d秒", _timeout] forState:UIControlStateNormal];
                _button.enabled = NO;
            });
            _timeout--;
        }
    });
    dispatch_resume(_timer);
    
}


@end
