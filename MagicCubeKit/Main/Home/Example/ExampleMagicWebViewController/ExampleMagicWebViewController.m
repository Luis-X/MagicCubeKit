//
//  ExampleMagicWebViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicWebViewController.h"

@interface ExampleMagicWebViewController ()
@end

@implementation ExampleMagicWebViewController{
    UITextField *_textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMainView];
}

- (void)createMainView{
    
    UITextField *textField = [QuicklyUI quicklyUITextFieldAddTo:self.view font:MC_FONT_SYSTEM(14)];
    textField.text = @"http://10.1.2.118:9999/src/pages/sec-1212/sec-1212.html";
    textField.backgroundColor = [UIColor grayColor];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _textField = textField;
    
    UIButton *button = [QuicklyUI quicklyUIButtonAddTo:self.view backgroundColor:[UIColor grayColor] cornerRadius:5];
    [button setTitle:@" 使用WKWebView打开 " forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)buttonAction:(UIButton *)button{
    
    if (_textField.text.length <= 0) {
        return;
    }
    
    // 加载请求(防止网址中含有中文字符,转为URLNSURL为nil)
    NSString *urlString = _textField.text;
    NSString *url = R_URL_WEB(urlString);
    [MagicRouterManager showAnyViewControllerWithRouterURL:url data:nil addedNavigationController:self.navigationController];
    
}


@end
