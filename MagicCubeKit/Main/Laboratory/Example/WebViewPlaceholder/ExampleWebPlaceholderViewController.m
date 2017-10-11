//
//  ExampleWebPlaceholderViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleWebPlaceholderViewController.h"
#import "NetworkDisconnectedView.h"
#import <FLAnimatedImageView.h>

@interface ExampleWebPlaceholderViewController ()

@end

@implementation ExampleWebPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMainSubViews];
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

- (void)createMainSubViews{
    
//  [NetworkDisconnectedView placeholderAddView:self.view reloadBlock:^{
//      NSLog(@"刷新");
//  }];
    
    /*
    NSString *url = @"https://raw.githubusercontent.com/Luis-X/LuisXNoteBook/master/Resource/1.gif";
    
    FLAnimatedImageView *gifImageView = [[FLAnimatedImageView alloc] init];
    gifImageView.backgroundColor = [UIColor orangeColor];
    [gifImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.view addSubview:gifImageView];
    [gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.center.equalTo(self.view);
    }];
    */
    
    
    NSString *url = @"data:image/gif;base64,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";
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString: url]];
    UIImage *image = [UIImage imageWithData:imgData];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.center.equalTo(self.view);
    }];
}

@end
