//
//  ExampleDrawViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/14.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleDrawViewController.h"
#import "ExampleDrawView.h"
@interface ExampleDrawViewController ()

@end

@implementation ExampleDrawViewController{
    UILabel *_cornerLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark -绘制
    ExampleDrawView *drawView = [ExampleDrawView new];
    drawView.frame = CGRectMake(50, 100, 200, 200);
    drawView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:drawView];
    
    
    
#pragma mark -任意角圆角
    
    _cornerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    _cornerLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_cornerLabel];
    //添加半圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_cornerLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(25, 25)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _cornerLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    _cornerLabel.layer.mask = maskLayer;
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

@end
