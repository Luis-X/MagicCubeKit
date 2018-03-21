//
//  MCMultipleImagePickerPreviewViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2018/3/14.
//  Copyright © 2018年 LuisX. All rights reserved.
//

@class MCMultipleImagePickerPreviewViewController;

@protocol MCMultipleImagePickerPreviewViewControllerDelegate <QMUIImagePickerPreviewViewControllerDelegate>
@required
- (void)imagePickerPreviewViewController:(MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray;
@end

@interface MCMultipleImagePickerPreviewViewController : QMUIImagePickerPreviewViewController

@property(nonatomic, weak) id<MCMultipleImagePickerPreviewViewControllerDelegate> delegate;
@property(nonatomic, strong) QMUILabel *imageCountLabel;
@property(nonatomic, strong) QMUIAssetsGroup *assetsGroup;
@property(nonatomic, assign) BOOL shouldUseOriginImage;
- (void)reloadSendButtonTitlte;
@end
