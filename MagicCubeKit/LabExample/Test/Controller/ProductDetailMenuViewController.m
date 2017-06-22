//
//  ProductDetailMenuViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/9.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductDetailMenuViewController.h"

@interface ProductDetailMenuViewController ()

@end

@implementation ProductDetailMenuViewController{
    UILabel *_navigationBarTitleLabel;
    DZNSegmentedControl *_pageSegmentedControl;
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
    self.menuHeight = 0;
    self.pageAnimatable = YES;
}

- (void)createMainView{
    
}


/**
 自定义导航栏
 */
- (void)customNavigationBarTitleView{
  
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.navigationItem.titleView = navigationBarView;
    
    //左侧
    UILabel *leftItem = [UILabel new];
    leftItem.text = @"\U0000e6d5";
    leftItem.font = [UIFont fontWithName:@"iconfont" size:20 * HOME_IPHONE6_HEIGHT];
    leftItem.textColor = [UIColor whiteColor];
    leftItem.userInteractionEnabled = YES;
    leftItem.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:leftItem];
    [leftItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLeftBarButtonItemAction)]];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationBarView);
        make.left.equalTo(navigationBarView);
        make.width.height.mas_equalTo(35 * HOME_IPHONE6_HEIGHT);
    }];
    
    //右侧
    MagicIconButton *rightItem = [MagicIconButton new];
    //rightItem.backgroundColor = [UIColor whiteColor];
    rightItem.titleLabel.text = @"分享赚";
    rightItem.iconLabel.text = @"\U0000e6f3";
    rightItem.titleLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    rightItem.iconLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    rightItem.buttonStyle = IconTextButtonStyleRight;
    rightItem.buttonEdges = UIEdgeInsetsMake(0, 10 * HOME_IPHONE6_WIDTH, 0, 0);
    rightItem.iconFontSize = 14 * HOME_IPHONE6_HEIGHT;
    rightItem.titleLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    [rightItem jm_setImageWithCornerRadius:(25 / 2) * HOME_IPHONE6_HEIGHT borderColor:[UIColor clearColor] borderWidth:0 backgroundColor:[UIColor whiteColor]];
    [navigationBarView addSubview:rightItem];
    [rightItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRightBarButtonItemAction)]];
    [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navigationBarView);
        make.right.equalTo(navigationBarView);
        make.width.mas_equalTo(75 * HOME_IPHONE6_WIDTH);
        make.height.mas_equalTo(25 * HOME_IPHONE6_HEIGHT);
    }];
    
    _pageSegmentedControl = [[DZNSegmentedControl alloc] initWithItems:self.titles];
    _pageSegmentedControl.backgroundColor = [UIColor clearColor];
    _pageSegmentedControl.tintColor = [UIColor colorWithRed:0.57 green:0.09 blue:0.17 alpha:1.00];
    _pageSegmentedControl.selectionIndicatorHeight = 2;
    _pageSegmentedControl.showsCount = NO;
    _pageSegmentedControl.width = 100 * HOME_IPHONE6_WIDTH;
    _pageSegmentedControl.height = 44;
    _pageSegmentedControl.font = [UIFont systemFontOfSize:14];
    [navigationBarView addSubview:_pageSegmentedControl];
    [_pageSegmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(navigationBarView);
    }];
    [_pageSegmentedControl addTarget:self action:@selector(controlSelectedSegment) forControlEvents:UIControlEventValueChanged];
    [self updatePageSegmentedControlSelectedIndex];
    
}

#pragma mark - Update
- (void)updatePageSegmentedControlSelectedIndex{
    _pageSegmentedControl.selectedSegmentIndex = self.selectIndex;
}

#pragma mark - Action
/**
 返回
 */
- (void)pressLeftBarButtonItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 分享
 */
- (void)pressRightBarButtonItemAction{
    NSLog(@"分享");
}

/**
 导航栏切换Controller
 */
- (void)controlSelectedSegment{
    self.selectIndex = [[NSNumber numberWithInteger:_pageSegmentedControl.selectedSegmentIndex] intValue];
}

#pragma mark -WMPageControllerDelegate

/**
 手势切换Controller
 */
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    [self updatePageSegmentedControlSelectedIndex];
}
@end
