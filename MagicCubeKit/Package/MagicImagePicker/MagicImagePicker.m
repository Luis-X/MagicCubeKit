//
//  MagicImagePicker.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicImagePicker.h"
#import "MagicPermissionManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MagicImagePicker ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) id <MagicImagePickerDelegate> myDelegate;
@property (nonatomic, strong) UIViewController *addController;
@end

@implementation MagicImagePicker

+ (MagicImagePicker *)shareManager{
    static dispatch_once_t onceToken;
    static MagicImagePicker *manager;
    dispatch_once(&onceToken, ^{
        manager = [MagicImagePicker new];
    });
    return manager;
}


- (void)showImagePickerWithTitle:(NSString *)title message:(NSString *)message addController:(UIViewController *)addController delegate:(id)delegate{
    
    self.myDelegate = delegate;
    self.addController = addController;
    [self createSheetAlertControllerWithTitle:title message:message];
    
}


/**
 sheet弹框
 @param title   标题
 @param message 信息
 */
- (void)createSheetAlertControllerWithTitle:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertActionPhoto = [UIAlertAction actionWithTitle:@"拍照"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [self openSystemCamera];
                                                             }];
    UIAlertAction *alertActionAlbum = [UIAlertAction actionWithTitle:@"从相册选取"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [self openSystemPhotoLibrary];
                                                             }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:nil];
    [alertController addAction:alertActionPhoto];
    [alertController addAction:alertActionAlbum];
    [alertController addAction:cancleAction];
    [_addController presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - Action
//打开系统相机
- (void)openSystemCamera{
    
    // 相机权限
    if([[MagicPermissionManager shareManager] iPhoneSystemPermissionCamera]){
        [self openSystemUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
}

//打开系统相册
- (void)openSystemPhotoLibrary{
    
    // 相册权限
    if ([[MagicPermissionManager shareManager] iPhoneSystemPermissionPhotoLibrary]) {
        [self openSystemUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
}


#pragma mark - 相机/相册
/**
 *  打开系统相机或相册
 */
- (void)openSystemUIImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    
    // 创建图像选取控制器对象
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 将资源类型设置为相机类型
    picker.sourceType = sourceType;
    // 设置拍照后的图片允许编辑
    picker.allowsEditing = NO;
    // 设置摄像图像品质,默认是UIImagePickerControllerQualityTypeMedium
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    // 设置最长摄像时间,默认是10秒
    picker.videoMaximumDuration = 30;
    // 设置代理,需要遵守<UINavigationControllerDelegate, UIImagePickerControllerDelegate>两个协议
    picker.delegate = self;
    // 弹出图像选取控制器
    [_addController presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
// 操作完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (resultImage != nil) {
        [self executeMagicSystemImagePickerDidFinishPickingMediaWithImage:resultImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

// 操作取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self executeMagicSystemImagePickerDidCancel];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Delegate
/**
 执行代理方法
 */
- (void)executeMagicSystemImagePickerDidFinishPickingMediaWithImage:(UIImage *)image{
    
    if ([self.myDelegate respondsToSelector:@selector(magicSystemImagePickerDidFinishPickingMediaWithImage:)]) {
        [self.myDelegate magicSystemImagePickerDidFinishPickingMediaWithImage:image];
    }
    
}

- (void)executeMagicSystemImagePickerDidCancel{
    
    if ([self.myDelegate respondsToSelector:@selector(magicSystemImagePickerDidCancel)]) {
        [self.myDelegate magicSystemImagePickerDidCancel];
    }
    
}
@end
