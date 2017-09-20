//
//  MagicShareWeChat.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"                   // 微信

@interface MagicShareWeChat : NSObject<WXApiDelegate>
/*
 WXSceneSession  = 0,        // 聊天界面
 WXSceneTimeline = 1,        // 朋友圈
 WXSceneFavorite = 2,        // 收藏
 */
+ (MagicShareWeChat *)shareManager;

- (void)sendToWechatMessageTitle:(NSString *)title
                     description:(NSString *)description
                      thumbImage:(UIImage *)thumbImage
                     mediaObject:(id)mediaObject
                           scene:(enum WXScene)scene;
// 文本
- (void)shareToWechatWithText:(NSString *)text scene:(enum WXScene)scene;
// 图片
- (void)shareToWechatWithImageTitle:(NSString *)title
                        description:(NSString *)description
                         thumbImage:(UIImage *)thumbImage
                          imageData:(NSData *)imageData
                              scene:(enum WXScene)scene;
// 音乐
- (void)shareToWechatWithMusicTitle:(NSString *)title
                        description:(NSString *)description
                         thumbImage:(UIImage *)thumbImage
                           musicUrl:(NSString *)musicUrl
                       musicDataUrl:(NSString *)musicDataUrl
                              scene:(enum WXScene)scene;
// 视频
- (void)shareToWechatWithVideotTitle:(NSString *)title
                         description:(NSString *)description
                          thumbImage:(UIImage *)thumbImage
                            videoUrl:(NSString *)videoUrl
                               scene:(enum WXScene)scene;
// 网页
- (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                            scene:(enum WXScene)scene;
// 小程序
- (void)shareToWechatWithWXMiniProgramObject:(NSString *)title
                                 description:(NSString *)description
                                  webpageUrl:(NSString *)webpageUrl
                                    userName:(NSString *)userName
                                        path:(NSString *)path
                                 hdImageData:(NSData *)hdImageData;
@end
