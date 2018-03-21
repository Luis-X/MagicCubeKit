//
//  MCAlbumViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2018/3/15.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import "MCAlbumViewController.h"

@interface MCAlbumViewController ()

@end

@implementation MCAlbumViewController

- (void)initSubviews
{
    [super initSubviews];
    self.contentType = QMUIAlbumContentTypeOnlyPhoto;
    self.albumTableViewCellHeight = 105;
    [QMUIAlbumTableViewCell appearance].albumImageSize = 75;
    [QMUIAlbumTableViewCell appearance].albumImageMarginLeft = 9;
    [QMUIAlbumTableViewCell appearance].albumNameFontSize = 16;
    [QMUIAlbumTableViewCell appearance].albumAssetsNumberFontSize = 12;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


#pragma mark - QMUINavigationControllerDelegate

- (BOOL)shouldSetStatusBarStyleLight {
    return NO;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage qmui_imageWithColor:MC_COLOR_WHITE_A(0.95f)];
}

- (UIImage *)navigationBarShadowImage {
    return [UIImage qmui_imageWithColor:MC_COLOR_WHITE_A(0.95f) size:CGSizeMake(1, 1) cornerRadius:0.0f];
}

- (UIColor *)navigationBarTintColor {
    return MC_COLOR_RGB(26, 18, 16);
}

- (UIColor *)titleViewTintColor {
    return MC_COLOR_RGB(26, 18, 16);
}

@end
