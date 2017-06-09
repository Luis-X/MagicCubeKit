//
//  ProductDetailMenuViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/9.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductDetailMenuViewController.h"
#import "ProductDetailViewController.h"
#import "ExampleMagicNetworkingViewController.h"
#import "CAPSPageMenu.h"

@interface ProductDetailMenuViewController ()<CAPSPageMenuDelegate>

@end

@implementation ProductDetailMenuViewController{
    CAPSPageMenu *_mainPageMenu;
    UILabel *_navigationBarTitleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initailData];
    [self createMainView];
    [self customNavigationBarTitleView];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
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

- (void)initailData{
    
}

- (void)createMainView{
    
    ProductDetailViewController *controller1 = [ProductDetailViewController new];
    ExampleMagicNetworkingViewController *controller2 = [ExampleMagicNetworkingViewController new];
    NSArray *controllerArray = @[controller1, controller2];
    NSDictionary *parameters = @{CAPSPageMenuOptionHideTopMenuBar: @(YES),
                                 CAPSPageMenuOptionEnableHorizontalBounce: @(NO)};
    _mainPageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    _mainPageMenu.delegate = self;
    [self.view addSubview:_mainPageMenu.view];

}

- (void)customNavigationBarTitleView{
    //导航条
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.navigationItem.titleView = navigationBarView;
    
    //左侧
    UILabel *leftItem = [UILabel new];
    leftItem.text = @"\U0000e6d5";
    leftItem.font = [UIFont fontWithName:@"iconfont" size:20];
    leftItem.textColor = [UIColor whiteColor];
    leftItem.userInteractionEnabled = YES;
    leftItem.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:leftItem];
    [leftItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLeftBarButtonItemAction)]];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationBarView);
        make.left.equalTo(navigationBarView);
        make.width.height.mas_equalTo(35);
    }];
    
    //右侧
    UILabel *rightItem = [UILabel new];
    rightItem.text = @"\U0000e66a";
    rightItem.font = [UIFont fontWithName:@"iconfont" size:20];
    rightItem.textColor = [UIColor whiteColor];
    rightItem.userInteractionEnabled = YES;
    rightItem.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:rightItem];
    [rightItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRightBarButtonItemAction)]];
    [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationBarView);
        make.right.equalTo(navigationBarView);
        make.width.height.mas_equalTo(leftItem);
    }];
    
    UIView *logoView = [UIView new];
    [navigationBarView addSubview:logoView];
//    logoView.backgroundColor = [UIColor blackColor];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationBarView);
        make.left.equalTo(leftItem.mas_right).offset(5);
        make.right.equalTo(rightItem.mas_left).offset(-5);
        make.height.mas_equalTo(44);
    }];
    
    _navigationBarTitleLabel = [UILabel new];
    _navigationBarTitleLabel.text = @"商品详情";
    _navigationBarTitleLabel.textColor = [UIColor whiteColor];
    [logoView addSubview:_navigationBarTitleLabel];
    [_navigationBarTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(logoView);
    }];

}



#pragma mark - CAPSPageMenuDelegate
- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index{
    
    if (0 == index) {
        _navigationBarTitleLabel.text = @"商品详情";
    }
    if (1 == index) {
        _navigationBarTitleLabel.text = @"素材中心";
    }
    
}

#pragma mark - Action
- (void)pressLeftBarButtonItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressRightBarButtonItemAction{
    NSLog(@"分享");
}
@end
