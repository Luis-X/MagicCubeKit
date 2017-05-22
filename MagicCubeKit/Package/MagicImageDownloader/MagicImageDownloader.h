//
//  MagicImageDownloader.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MagicImageDownloadCompletionBlock)(NSError *error);

@interface MagicImageDownloader : NSObject
+ (MagicImageDownloader *)shareManager;                                                                 //单例创建队列组
- (void)downloadImageInGroupWithImageView:(UIImageView *)imageView ImageURL:(NSString *)imageURL;       //将加载图片加入队列中
- (void)downloadImageInGroupNotifyCompletion:(MagicImageDownloadCompletionBlock)completion;             //队列组任务全部完成回调
@end
