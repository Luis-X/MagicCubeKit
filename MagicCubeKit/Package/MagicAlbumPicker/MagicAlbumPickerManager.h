//
//  MagicAlbumPickerManager.h
//  DaRenShop
//
//  Created by LuisX on 2018/3/16.
//  Copyright © 2018年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCAlbumViewController.h"
#import "MCImagePickerViewController.h"
#import "MCMultipleImagePickerPreviewViewController.h"

typedef void (^MagicAlbumPickerManagerBlock)(NSMutableArray *images);

@interface MagicAlbumPickerManager : NSObject<QMUIAlbumViewControllerDelegate, QMUIImagePickerViewControllerDelegate, MCMultipleImagePickerPreviewViewControllerDelegate>
+ (MagicAlbumPickerManager *)shareManager;

// 多选相册
- (void)presentAlbumViewControllerWithTitle:(NSString *)title maximumSelectImageCount:(NSInteger)maximumSelectImageCount addController:(UIViewController *)addController handler:(MagicAlbumPickerManagerBlock)handler;
// 批量上传
+ (void)networkUploadWithURLString:(NSString *)URLString parameters:(id)parameters images:(NSMutableArray *)images completionHandler:(void (^)(NSArray *imageUrls))completionHandler;
@end
