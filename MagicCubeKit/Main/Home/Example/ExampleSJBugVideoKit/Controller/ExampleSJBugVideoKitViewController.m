//
//  ExampleSJBugVideoKitViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleSJBugVideoKitViewController.h"


@interface ExampleSJBugVideoKitViewController ()

@end

@implementation ExampleSJBugVideoKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"SJBugVideoKit";
    [self initialData];
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

- (void)initialData{
    
    //基于ReplayKit实现屏幕录制，只可以录制本应用内视频，缓存可以通过清理缓存来清理。
    //ReplayKit.framework必须ios9.0以上才支持，所以需要将framework的属性设置为Optional，否则在9.0以下手机上会报错。

    //
    //1.导入ReplayKit.framework，设置为Optional
    //2.AppDelegate中startSJBugVideoKit初始化
    //
    
}

- (void)createMainView{
    
    UIButton *replayButton = [QuicklyUI quicklyUIButtonAddTo:self.view backgroundColor:[UIColor clearColor] cornerRadius:5];
    [replayButton setTitle:@"录屏 (真机)" forState:UIControlStateNormal];
    [replayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    replayButton.layer.borderWidth = 2;
    replayButton.layer.cornerRadius = 5;
    [replayButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
        
    }];
    [replayButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *screenButton =  [QuicklyUI quicklyUIButtonAddTo:self.view backgroundColor:[UIColor clearColor] cornerRadius:5];
    [screenButton setTitle:@"截屏 (真机Home + Power)" forState:UIControlStateNormal];
    [screenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    screenButton.layer.borderWidth = 2;
    screenButton.layer.cornerRadius = 5;
    [screenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(replayButton.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
        
    }];

    
}

#pragma mark - Action
- (void)buttonAction:(UIButton *)button{
    
    BOOL show = [[NSUserDefaults standardUserDefaults] boolForKey:@"bugVideoShow"];
    [[NSUserDefaults standardUserDefaults] setBool:!show forKey:@"bugVideoShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[AppDelegate shareAppDelegate] showSJBugVideo:!show];
    
}

@end
