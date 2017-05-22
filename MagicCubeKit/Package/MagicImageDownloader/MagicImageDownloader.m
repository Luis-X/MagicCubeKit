//
//  MagicImageDownloader.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicImageDownloader.h"
#import <UIImageView+WebCache.h>

@interface MagicImageDownloader ()
@property (nonatomic, strong) dispatch_group_t downloadGroup;
@property (nonatomic, copy) __block NSError *downloadError;
@end

@implementation MagicImageDownloader

+ (MagicImageDownloader *)shareManager{
    
    static MagicImageDownloader *downloadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        downloadManager = [MagicImageDownloader new];
        downloadManager.downloadGroup = dispatch_group_create();    //1.创建队列组
        NSLog(@"创建队列组");
        
    });
    return downloadManager;
    
}

/**
 队列中加载图片
 
 @param imageView 图片视图
 @param imageURL 图片URL
 */
- (void)downloadImageInGroupWithImageView:(UIImageView *)imageView ImageURL:(NSString *)imageURL{
    
    dispatch_group_enter(_downloadGroup); //2.进入队列
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error) {
            _downloadError = error;
        }
        dispatch_group_leave(_downloadGroup); //3.离开队列
        NSLog(@"完成队列任务---%@", imageURL);
        
    }];
    
}

/**
 结束所有任务通知
 */
- (void)downloadImageInGroupNotifyCompletion:(MagicImageDownloadCompletionBlock)completion{//4.完成队列组中所有任务
    
    dispatch_group_notify(_downloadGroup, dispatch_get_main_queue(), ^{
        
        NSLog(@"任务全部完成");
        if (completion) {
            completion(_downloadError);
        }
        
    });
    
    
}

@end
