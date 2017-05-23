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
    self.view.backgroundColor = [UIColor whiteColor];
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

#pragma mark - 自定义Title
- (void)setMainTitle:(NSString *)mainTitle{
    self.navigationItem.titleView = [self customNavigationBarTitleStyleWithTitle:mainTitle];
}

- (UILabel *)customNavigationBarTitleStyleWithTitle:(NSString *)titleStr{
    
    UIFont *titleFont = [UIFont systemFontOfSize:18];
    CGSize labelSize = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObject:titleFont forKey:NSFontAttributeName]];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, labelSize.width, 44.f)];
    titleLabel.font = titleFont;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.backgroundColor = [UIColor orangeColor];
    return titleLabel;
    
}
@end
