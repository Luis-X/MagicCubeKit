//
//  ExampleMagicButtonViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicButtonViewController.h"
#import "MagicIconButton.h"
@interface ExampleMagicButtonViewController ()

@end

@implementation ExampleMagicButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicIconButton";
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
    
    MagicIconButton *button = [MagicIconButton new];
    //button.backgroundColor = [UIColor orangeColor];
    button.titleLabel.text = @"iconfont";
    //button.iconImageView.image = [UIImage imageNamed:@"tabbar_0@2x.png"];
    button.iconLabel.text = @"\U0000e63c";
    button.buttonStyle = IconTextButtonStyleLeft;
    button.buttonEdges = UIEdgeInsetsMake(20, 10, 20, 10);
    button.iconFontSize = 25;
    button.layer.borderWidth = 2;
    button.layer.cornerRadius = 5;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.view);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(50);
        
    }];
    
}
@end
