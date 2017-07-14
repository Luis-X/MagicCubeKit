//
//  MainTabBarController.m
//  DaRenShop
//
//  Created by LuisX on 2017/7/12.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "MainTabBarController.h"

#import "HomeViewController.h"
#import "LaboratoryViewController.h"
@interface MainTabBarController ()

@property (nonatomic, strong) NSArray *navigateArr; //
@property (nonatomic, strong) NSMutableArray *titleArr; //
@property (nonatomic, strong) NSMutableArray *imageArr; //
@property (nonatomic, strong) NSMutableArray *CtrlArr; //

@end

@implementation MainTabBarController{
    UIImageView *selectImage;  //选中视图
    NSInteger selectTag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"%@",self.tabBar.subviews);
    [super viewDidAppear:animated];
    
    HomeViewController *viewController0 = [[HomeViewController alloc] init];
    viewController0.view.backgroundColor = [UIColor redColor];
    
    
    LaboratoryViewController *viewController1 = [[LaboratoryViewController alloc] init];
    viewController1.view.backgroundColor = [UIColor grayColor];
    
    self.viewControllers = @[viewController0,viewController1];

    [self setupTabBar];
    
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

- (void)setupTabBar {
    //取消tabBar的透明效果。
    [UITabBar appearance].translucent = NO;
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        
        switch (idx) {
            case 0:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"recording"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"recording"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"录音";
                
            } break;
            case 1:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"视频";
            } break;
            case 2:{
                obj.tabBarItem.enabled=NO;
                obj.tabBarItem.title=@"";
                
            } break;
            case 3:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"txt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"txt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"记事本";
                
            } break;
            case 4:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"voice"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"voice"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"声音";
                
            } break;
                
            default:
                break;
        }
    }];
    
    //修改文字颜色
    self.customSelectViews  = [[NSMutableArray alloc] init];
    for (UIView *UITabBarButton in self.tabBar.subviews) {
        if ([@"UITabBarButton" isEqualToString:NSStringFromClass([UITabBarButton class])]) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UITabBarButton.frame.origin.x+UITabBarButton.frame.size.width/2-5, UITabBarButton.frame.origin.y+UITabBarButton.frame.size.height-5, 10, 5)];
            imageView.image = [UIImage imageNamed:@"tabbar_1@2x"];
            [self.tabBar addSubview:imageView];
            [self.customSelectViews addObject:imageView];
            
        }
    }
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-37.5 , -15, 75, 75)];
    
    button.layer.cornerRadius = 37.5;
    button.layer.masksToBounds = YES;
    
    [button setBackgroundColor:[UIColor whiteColor]];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    
    
}


@end
