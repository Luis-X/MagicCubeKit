//
//  MagicShareWeChat.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicShareWeChat.h"

@implementation MagicShareWeChat

+ (MagicShareWeChat *)shareManager{
    static MagicShareWeChat *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MagicShareWeChat alloc] init];
    });
    return manager;
}

/**
 发送微信消息
 
 @param title       标题 （长度不能超过512字节)
 @param description 描述 （长度不能超过1K)
 @param thumbImage  缩略图 （大小不能超过32K)
 @param mediaObject 多媒体数据对象 (可以为WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject等)
 @param scene       发送的目标场景（可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline))
 */
- (void)sendToWechatMessageTitle:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage mediaObject:(id)mediaObject scene:(enum WXScene)scene{
    
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"未安装微信");
        return;
    }
    
    if (![WXApi isWXAppSupportApi]) {
        NSLog(@"微信版本过低");
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    message.mediaObject = mediaObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
    
}

#pragma mark - 微信分享
/**
 分享文本
 
 @param text  文本
 @param scene 场景
 */
- (void)shareToWechatWithText:(NSString *)text scene:(enum WXScene)scene{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = text;
    req.bText = YES;
    req.scene = scene;
    [WXApi sendReq:req];
}

/**
 分享图片

 @param title       标题
 @param description 描述
 @param thumbImage  缩略图
 @param imageData   图片
 @param scene       平台
 */
- (void)shareToWechatWithImageTitle:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage imageData:(NSData *)imageData scene:(enum WXScene)scene{
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    [self sendToWechatMessageTitle:title
                       description:description
                        thumbImage:thumbImage
                       mediaObject:imageObject
                             scene:scene];
    
}


/**
 分享音乐
 
 @param title           标题
 @param description     描述
 @param thumbImage      缩略图
 @param musicUrl        音乐url
 @param musicDataUrl    音乐数据url
 @param scene           场景
 */
- (void)shareToWechatWithMusicTitle:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage musicUrl:(NSString *)musicUrl musicDataUrl:(NSString *)musicDataUrl scene:(enum WXScene)scene{
    
    WXMusicObject *musicObject = [WXMusicObject object];
    musicObject.musicUrl = musicUrl;
    musicObject.musicLowBandUrl = musicUrl;
    musicObject.musicDataUrl = musicDataUrl;
    musicObject.musicLowBandDataUrl = musicDataUrl;
    [self sendToWechatMessageTitle:title
                       description:description
                        thumbImage:thumbImage
                       mediaObject:musicObject
                             scene:scene];
    
}


/**
 分享视频
 
 @param title       标题
 @param description 描述
 @param thumbImage  缩略图
 @param videoUrl    视频url
 @param scene       场景
 */
- (void)shareToWechatWithVideotTitle:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage videoUrl:(NSString *)videoUrl scene:(enum WXScene)scene{
    
    WXVideoObject *videoObject = [WXVideoObject object];
    videoObject.videoUrl = videoUrl;
    videoObject.videoLowBandUrl = videoUrl;
    [self sendToWechatMessageTitle:title
                       description:description
                        thumbImage:thumbImage
                       mediaObject:videoObject
                             scene:scene];
    
}


/**
 分享网页
 
 @param title       标题
 @param description 描述
 @param thumbImage  缩略图
 @param webpageUrl  视频url
 @param scene       场景
 */
- (void)shareToWechatWithWebTitle:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage webpageUrl:(NSString *)webpageUrl scene:(enum WXScene)scene{
    
    WXWebpageObject *webPageObject = [WXWebpageObject object];
    webPageObject.webpageUrl = webpageUrl;
    [self sendToWechatMessageTitle:title
                       description:description
                        thumbImage:thumbImage
                       mediaObject:webPageObject
                             scene:scene];
    
}


/**
 分享小程序
 
 @param title       标题
 @param description 描述
 @param webpageUrl  低版本url
 @param userName    小程序原始id
 @param path        小程序页面路径
 @param hdImageData 小程序节点高清图
 */
- (void)shareToWechatWithWXMiniProgramObject:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)webpageUrl userName:(NSString *)userName path:(NSString *)path hdImageData:(NSData *)hdImageData{
    
    WXMiniProgramObject *wxMiniProgramObject = [WXMiniProgramObject object];
    wxMiniProgramObject.webpageUrl = webpageUrl;
    wxMiniProgramObject.userName = userName;
    wxMiniProgramObject.path = path;
    wxMiniProgramObject.hdImageData = hdImageData;
    
    [self sendToWechatMessageTitle:title
                       description:description
                        thumbImage:nil                       //优先使用hdImageData（小于32k）
                       mediaObject:wxMiniProgramObject
                             scene:WXSceneSession];     //1.8.0只支持会话
    
}

#pragma mark - WXApiDelegate
// 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
- (void)onReq:(BaseReq *)req{
    
}

// 发送一个sendReq后，收到微信的回应
- (void)onResp:(BaseResp *)resp{
    
}
@end
