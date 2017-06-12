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
@property (nonatomic ,strong) UIScrollView *headScrollView;
@property (nonatomic ,strong) ProductDetailViewController  *firstVC;
@property (nonatomic ,strong) ExampleMagicNetworkingViewController  *secondVC;
@property (nonatomic ,strong) UIViewController *currentVC;
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
    

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    self.headScrollView.backgroundColor = [UIColor purpleColor];
    self.headScrollView.contentSize = CGSizeMake(560, 0);
    self.headScrollView.bounces = NO;
    self.headScrollView.pagingEnabled = YES;
    [self.view addSubview:self.headScrollView];
    
  
    self.firstVC = [[ProductDetailViewController alloc] init];
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[ExampleMagicNetworkingViewController alloc] init];
   
    
    
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
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


/**
 切换Controller
 */
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController{
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:2.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}
@end
