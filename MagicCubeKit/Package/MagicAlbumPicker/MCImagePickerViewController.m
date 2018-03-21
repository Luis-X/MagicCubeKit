//
//  MCImagePickerViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2018/3/15.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import "MCImagePickerViewController.h"

@interface MCImagePickerViewController ()

@end

@implementation MCImagePickerViewController

- (void)initSubviews
{
    [super initSubviews];
    self.minimumImageWidth = 90.0f;
    
     self.previewButton.titleLabel.font = UIFontMake(14);
    [self.previewButton setTitleColor:MC_COLOR_RGB(76, 76, 76) forState:UIControlStateNormal];
    
    CGFloat sendButtonWidth = 92.5f;
    CGFloat sendButtonHeight = 30.0f;
    self.sendButton.titleLabel.font = UIFontMake(12);
    self.sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.sendButton setTitleColor:MC_COLOR_WHITE_A(1.0f) forState:UIControlStateNormal];
    [self.sendButton setTitleColor:MC_COLOR_WHITE_A(1.0f) forState:UIControlStateDisabled];
    [self.sendButton setBackgroundColor:MC_COLOR_RGB(204, 204, 204)];
    [self.sendButton setTitle:@"未选择" forState:UIControlStateDisabled];
    self.sendButton.frame = CGRectMake(self.sendButton.frame.origin.x, self.sendButton.frame.origin.y, sendButtonWidth, sendButtonHeight);
    self.sendButton.layer.cornerRadius = 15.0f;
    self.sendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.imageCountLabel removeFromSuperview];
    
    [QMUIImagePickerCollectionViewCell appearance].checkboxImage = MC_IMAGE_NAMED(@"album_picker_no_selected");
    [QMUIImagePickerCollectionViewCell appearance].checkboxCheckedImage = MC_IMAGE_NAMED(@"album_selected");

}

// 监听 sendButton 状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"enabled"] && object == self.sendButton) {
        [self reloadSendButtonTitle];
    }
}

// 刷新显示
- (void)reloadSendButtonTitle
{
    if (self.sendButton.enabled) {
        NSInteger selectedImageCount = [self.selectedImageAssetArray count];
        [self.sendButton setTitle:MC_STRING_FORMAT(@"发送(%ld)", selectedImageCount) forState:UIControlStateNormal];
        [self.sendButton setBackgroundColor:MC_COLOR_RGB(251, 60, 76)];
    } else {
        [self.sendButton setBackgroundColor:MC_COLOR_RGB(204, 204, 204)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadSendButtonTitle];
    [self.sendButton addObserver:self
                      forKeyPath:@"enabled"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:NULL];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.sendButton removeObserver:self
                         forKeyPath:@"enabled"];
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
