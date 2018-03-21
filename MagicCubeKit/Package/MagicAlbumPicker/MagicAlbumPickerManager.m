//
//  MagicAlbumPickerManager.m
//  DaRenShop
//
//  Created by LuisX on 2018/3/16.
//  Copyright © 2018年 YunRuo. All rights reserved.
//

#import "MagicAlbumPickerManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation MagicAlbumPickerManager{
    MagicAlbumPickerManagerBlock _handler;
    NSInteger maxSelectImageCount;
}

+ (MagicAlbumPickerManager *)shareManager{
    
    static MagicAlbumPickerManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MagicAlbumPickerManager alloc] init];
    });
    return manager;
    
}

- (void)presentAlbumViewControllerWithTitle:(NSString *)title maximumSelectImageCount:(NSInteger)maximumSelectImageCount addController:(UIViewController *)addController handler:(MagicAlbumPickerManagerBlock)handler
{
    _handler = handler;
    maxSelectImageCount = maximumSelectImageCount;
    MCAlbumViewController *albumViewController = [[MCAlbumViewController alloc] init];
    albumViewController.albumViewControllerDelegate = self;
    albumViewController.title = title;
    QMUINavigationController *navigationController = [[QMUINavigationController alloc] initWithRootViewController:albumViewController];
    [addController presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - <QMUIAlbumViewControllerDelegate>
// 进入相册
- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController
{
    MCImagePickerViewController *imagePickerViewController = [[MCImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.allowsMultipleSelection = YES;
    imagePickerViewController.maximumSelectImageCount = maxSelectImageCount;
    return imagePickerViewController;
}

// 预览（选择完成）
- (void)imagePickerPreviewViewController:(MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    [self allImageSelectedHandlerWithImagesAssetArray:imagesAssetArray];
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>
// 相册（选择完成）
- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    [self allImageSelectedHandlerWithImagesAssetArray:imagesAssetArray];
}

// 进入预览
- (QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController
{
    MCMultipleImagePickerPreviewViewController *imagePickerPreviewViewController = [[MCMultipleImagePickerPreviewViewController alloc] init];
    imagePickerPreviewViewController.delegate = self;
    imagePickerPreviewViewController.maximumSelectImageCount = 9;
    imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
    return imagePickerPreviewViewController;
}

#pragma mark - <QMUIImagePickerPreviewViewControllerDelegate>
// 预览（勾选）
- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index
{
    MCMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
    [customImagePickerPreviewViewController reloadSendButtonTitlte];
}

// 预览（取消）
- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didUncheckImageAtIndex:(NSInteger)index
{
    MCMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
    [customImagePickerPreviewViewController reloadSendButtonTitlte];
}

#pragma mark - 处理选择完成
- (void)allImageSelectedHandlerWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray
{
    NSMutableArray *resultImages = [NSMutableArray array];
    for (QMUIAsset *qmUIAsset in imagesAssetArray) {
        UIImage *image = [qmUIAsset originImage];
        [resultImages addObject:image];
    }
    if (_handler) {
        _handler(resultImages);
    }
}

#pragma mark - 批量上传
+ (void)networkUploadWithURLString:(NSString *)URLString parameters:(id)parameters images:(NSMutableArray *)images completionHandler:(void (^)(NSArray *imageUrls))completionHandler{
    
    NSMutableArray *result = [NSMutableArray array];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < images.count; i++) {
        
        dispatch_group_enter(group);
        
        //1. 图片存放地址
        NSString *url = URLString;
        //2. 图片名称自定义
        NSString *imageName = [[NSDate date] formattedDateWithFormat:@"yyyyMMddHHmmss"];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
        //3. 图片二进制文件
        NSData *imageData = UIImagePNGRepresentation(images[i]);
        //NSLog(@"文件大小: %ld k", (long)(imageData.length / 1024));
        //4. 发起网络请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", nil];
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // NSMutableArray 是线程不安全的，所以加个同步锁
            @synchronized (result) {
                NSString *data = [NSString stringWithFormat:@"%@", [responseObject valueForKey:@"data"]];
                [result addObject:data];
            }
            dispatch_group_leave(group);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1, error);
            dispatch_group_leave(group);
            
        }];
        
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completionHandler) {
            completionHandler(result);
        }
    });
}

@end
