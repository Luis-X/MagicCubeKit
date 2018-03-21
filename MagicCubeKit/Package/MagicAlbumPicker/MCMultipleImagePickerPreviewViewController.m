//
//  MCMultipleImagePickerPreviewViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2018/3/14.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import "MCMultipleImagePickerPreviewViewController.h"

#define BottomToolBarViewHeight 45
#define ImageCountLabelSize CGSizeMake(18, 18)

@implementation MCMultipleImagePickerPreviewViewController {
    QMUIButton *_sendButton;
    UIView *_bottomToolBarView;
}

@dynamic delegate;

- (void)initSubviews
{
    [super initSubviews];
    
    self.toolBarBackgroundColor = MC_COLOR_WHITE_A(0.95f);
    self.backButton.tintColor = MC_COLOR_RGB(26, 18, 16);
    self.checkboxButton.tintColor = MC_COLOR_RGB(26, 18, 16);
    [self.backButton setImage:MC_IMAGE_NAMED(@"album_back") forState:UIControlStateNormal];
    [self.checkboxButton setImage:MC_IMAGE_NAMED(@"album_no_selected") forState:UIControlStateNormal];
    [self.checkboxButton setImage:MC_IMAGE_NAMED(@"album_selected") forState:UIControlStateSelected];
    
    _bottomToolBarView = [[UIView alloc] init];
    _bottomToolBarView.backgroundColor = MC_COLOR_WHITE_A(1.00f);
    [self.view addSubview:_bottomToolBarView];
    
    _sendButton = [[QMUIButton alloc] init];
    _sendButton.qmui_outsideEdge = UIEdgeInsetsMake(-6, -6, -6, -6);
    [_sendButton setTitleColor:MC_COLOR_WHITE_A(1.0f) forState:UIControlStateNormal];
    [_sendButton setBackgroundColor:MC_COLOR_RGB(204, 204, 204)];
    _sendButton.titleLabel.font = UIFontMake(12);
    [_sendButton sizeToFit];
    [_sendButton addTarget:self action:@selector(handleSendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomToolBarView addSubview:_sendButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateOriginImageCheckboxButtonWithIndex:self.imagePreviewView.currentImageIndex];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat sendButtonWidth = 92.5f;
    CGFloat sendButtonHeight = 30.0f;
    CGFloat toolBarItemSize = 23.5f;
    _bottomToolBarView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - BottomToolBarViewHeight, CGRectGetWidth(self.view.bounds), BottomToolBarViewHeight);
    _sendButton.frame = CGRectMake(CGRectGetWidth(_bottomToolBarView.frame) - sendButtonWidth - 10, (CGRectGetHeight(_bottomToolBarView.frame) - sendButtonHeight) / 2, sendButtonWidth, sendButtonHeight);
    _sendButton.layer.cornerRadius = 15.0f;
    self.backButton.frame = CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y, toolBarItemSize, toolBarItemSize);
    self.checkboxButton.frame = CGRectMake(self.checkboxButton.frame.origin.x, self.checkboxButton.frame.origin.y, toolBarItemSize, toolBarItemSize);
}

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView location:(CGPoint)location
{
    [super singleTouchInZoomingImageView:zoomImageView location:location];
    _bottomToolBarView.hidden = !_bottomToolBarView.hidden;
}

- (void)zoomImageView:(QMUIZoomImageView *)imageView didHideVideoToolbar:(BOOL)didHide
{
    [super zoomImageView:imageView didHideVideoToolbar:didHide];
    _bottomToolBarView.hidden = didHide;
}

- (void)setDownloadStatus:(QMUIAssetDownloadStatus)downloadStatus
{
    [super setDownloadStatus:downloadStatus];

}

// 发送
- (void)handleSendButtonClick:(id)sender
{
    if (self.selectedImageAssetArray.count <= 0) {
        return;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^(void) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerPreviewViewController:sendImageWithImagesAssetArray:)]) {
            [self.delegate imagePickerPreviewViewController:self sendImageWithImagesAssetArray:self.selectedImageAssetArray];
        }
    }];
}

- (void)updateOriginImageCheckboxButtonWithIndex:(NSInteger)index
{
    QMUIAsset *asset = self.imagesAssetArray[index];
    if (asset.assetType == QMUIAssetTypeAudio || asset.assetType == QMUIAssetTypeVideo) {
       
    } else {
        
    }
}

#pragma mark - <QMUIImagePreviewViewDelegate>

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView willScrollHalfToIndex:(NSUInteger)index
{
    [super imagePreviewView:imagePreviewView willScrollHalfToIndex:index];
    [self updateOriginImageCheckboxButtonWithIndex:index];
}

// 更新数据
- (void)updateImagePickerPreviewViewWithImagesAssetArray:(NSArray<QMUIAsset *> *)imageAssetArray selectedImageAssetArray:(NSArray<QMUIAsset *> *)selectedImageAssetArray currentImageIndex:(NSInteger)currentImageIndex singleCheckMode:(BOOL)singleCheckMode{
    [super updateImagePickerPreviewViewWithImagesAssetArray:imageAssetArray selectedImageAssetArray:selectedImageAssetArray currentImageIndex:currentImageIndex singleCheckMode:singleCheckMode];
    [self reloadSendButtonTitlte];
}

// 更新样式
- (void)reloadSendButtonTitlte
{
    if (self.selectedImageAssetArray.count <= 0) {
        [_sendButton setTitle:@"未选择" forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:MC_COLOR_RGB(204, 204, 204)];
    } else {
        [_sendButton setTitle:MC_STRING_FORMAT(@"完成(%ld)", self.selectedImageAssetArray.count) forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:MC_COLOR_RGB(251, 60, 76)];
    }
}
@end

