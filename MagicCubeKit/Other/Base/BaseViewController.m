//
//  BaseViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseBuildDefaultConfig];
    [self baseBuildSubViews];
    [self baseBuildLeftBarButtonItem];
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

/*
 * 默认配置
 */
- (void)baseBuildDefaultConfig{
    self.view.backgroundColor = [UIColor whiteColor];
}

/*
 * 构建视图
 */
- (void)baseBuildSubViews{
    
}

/**
 * 自定义导航栏
 */
- (void)baseBuildLeftBarButtonItem{
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backButton.frame = CGRectMake(0, 0, 25, 25);
        [backButton setBackgroundImage:[UIImage imageNamed:@"tabbar_0@2x.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(basePopViewController) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
}

/**
 返回
 */
- (void)basePopViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SET方法
- (void)setMainTitle:(NSString *)mainTitle{
    self.navigationItem.titleView = [self customTitleViewWithText:mainTitle
                                                             font:[UIFont systemFontOfSize:18]
                                                        textColor:[UIColor whiteColor]];
}

#pragma mark - CUSTOM
/*
 * 构建视图
 *
 * @param text          文本
 * @param font          字体
 * @param textColor     文本颜色
 */
- (UILabel *)customTitleViewWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    
    CGSize labelSize = [text sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, labelSize.width, 44.f)];
    label.font = font;
    label.textColor = textColor;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = [UIColor orangeColor];
    return label;
    
}

#pragma mark - 摇一摇
- (void)applicationSupportsShakeToEdit:(BOOL)open{
    if (open) {
        //1、打开摇一摇功能
        [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
        //2、让需要摇动的控制器成为第一响应者
        [self becomeFirstResponder];
        //3、实现以下方法
    }
}

// 开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}
// 取消摇动
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}
// 摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

/**
 获取前一个视图控制器
 */
- (UIViewController *)baseBackViewController{
    
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    if ( myIndex != 0 && myIndex != NSNotFound ) {
        return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    }
    return nil;
    
}

/**
 获取当前显示的控制器
 */
- (UIViewController *)getCurrentDisplayViewControllerFrom:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getCurrentDisplayViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]){
        return [self getCurrentDisplayViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    }
    
    if (vc.presentedViewController) {
        return [self getCurrentDisplayViewControllerFrom:vc.presentedViewController];
    }
    
    return vc;

}
@end
