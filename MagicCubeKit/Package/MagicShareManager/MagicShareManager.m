//
//  MagicShareManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicShareManager.h"
#import "MagicActivityViewController.h"


@interface MagicShareManager ()<WXApiDelegate>

@end

@implementation MagicShareManager

+ (void)shareWebPageUrlParameters:(MagicShareParameter *)parameters{
    
    NSString *title = parameters.share_title;
    NSString *description = parameters.share_des;
    NSString *url = parameters.share_webpageUrl;
    NSString *thumbImageUrl = parameters.share_thumbImageUrl;
    
    [self showMagicActivityViewControllerWithCompletion:^(NSInteger selectedIndex) {
        
        UIImage *image = [self handleImageWithURLString:thumbImageUrl];
        if (selectedIndex == 0) {
            [[MagicShareWeChat shareManager] shareToWechatWithWebTitle:title description:description thumbImage:image webpageUrl:url scene:WXSceneSession];
        }
        if (selectedIndex == 1) {
            [[MagicShareWeChat shareManager] shareToWechatWithWebTitle:title description:description thumbImage:image webpageUrl:url scene:WXSceneTimeline];
        }
        if (selectedIndex == 2) {
            [[MagicShareQQ shareManager] shareToQQWithWebTitle:title description:description previewImageUrl:thumbImageUrl url:url];
        }
        
    }];
    
}


+ (UIImage *)handleImageWithURLString:(NSString *)url {
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSData *newImageData = imageData;
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:0.1], 0.1f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}



#pragma mark - 通用

+ (void)showMagicActivityViewControllerWithCompletion:(MagicActivityCompletion)completion{
    // 样式
    MagicActivity *activity0 = [MagicActivity activityWithTitle:@"微信好友" iconFontCode:@"\U0000e6e7"];
    MagicActivity *activity1 = [MagicActivity activityWithTitle:@"朋友圈" iconFontCode:@"\U0000e6e5"];
    MagicActivity *activity2 = [MagicActivity activityWithTitle:@"QQ好友" iconFontCode:@"\U0000e6e6"];
    
    UIViewController *addViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSArray *activitys = @[activity0, activity1, activity2];
    
    [MagicActivityViewController presentAddViewController:addViewController topCustomView:nil activitys:activitys activityHeight:150 completion:completion];
    
}


#pragma mark - 下载图片
+ (void)downloadImageWithImageUrl:(NSString *)imageUrl completed:(nullable SDWebImageDownloaderCompletedBlock)completedBlock{
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (completedBlock) {
            completedBlock(image, data, error, finished);
        }
    }];
    
}

@end
