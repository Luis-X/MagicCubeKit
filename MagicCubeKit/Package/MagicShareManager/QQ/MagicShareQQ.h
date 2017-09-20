//
//  MagicShareQQ.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface MagicShareQQ : NSObject<TencentSessionDelegate, TencentApiInterfaceDelegate>
+ (MagicShareQQ *)shareManager;
- (void)sendToQQMessageContent:(QQApiObject *)content;
// 文本
- (void)shareToQQWithText:(NSString *)text;
// 图片
- (void)shareToQQWithImageTitle:(NSString *)title
                    description:(NSString *)description
                      imageData:(NSData *)imageData;
// 网页
- (void)shareToQQWithWebTitle:(NSString *)title
                  description:(NSString *)description
              previewImageUrl:(NSString *)previewImageUrl
                          url:(NSString *)url;
// 音乐
- (void)shareToQQWithMusicTitle:(NSString *)title
                    description:(NSString *)description
                previewImageUrl:(NSString *)previewImageUrl
                   musicDataUrl:(NSString *)musicDataUrl;
// 视频
- (void)shareToQQWithVideotTitle:(NSString *)title
                     description:(NSString *)description
                previewImageData:(NSData *)previewImageData
                    videoDataUrl:(NSString *)videoDataUrl;
@end
