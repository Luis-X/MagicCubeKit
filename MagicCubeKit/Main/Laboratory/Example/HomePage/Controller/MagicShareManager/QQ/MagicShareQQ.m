//
//  MagicShareQQ.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicShareQQ.h"

@implementation MagicShareQQ

+ (MagicShareQQ *)shareManager{
    static MagicShareQQ *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MagicShareQQ alloc] init];
    });
    return manager;
}

/**
 发送消息
 
 @param content 多媒体数据
 */
- (void)sendToQQMessageContent:(QQApiObject *)content{
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:content];
    [QQApiInterface sendReq:req];
}

#pragma mark - QQ分享
/**
 分享文本
 
 @param text 文本
 */
- (void)shareToQQWithText:(NSString *)text{
    QQApiTextObject *textObject = [QQApiTextObject objectWithText:text];
    [self sendToQQMessageContent:textObject];
}


/**
 分享图片
 
 @param title       标题
 @param description 描述
 @param imageData   图片
 */
- (void)shareToQQWithImageTitle:(NSString *)title description:(NSString *)description imageData:(NSData *)imageData{
    QQApiImageObject *imageObject = [QQApiImageObject objectWithData:imageData
                                                    previewImageData:imageData
                                                               title:title
                                                         description:description];
    [self sendToQQMessageContent:imageObject];
}


/**
 分享网页
 
 @param title           标题
 @param description     描述
 @param previewImageUrl 预览图
 @param url             链接
 */
- (void)shareToQQWithWebTitle:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl url:(NSString *)url{
    QQApiNewsObject *webObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]
                                                          title:title
                                                    description:description
                                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    [self sendToQQMessageContent:webObject];
}


/**
 分享音乐
 
 @param title           标题
 @param description     描述
 @param previewImageUrl 预览图
 @param musicDataUrl    音乐url
 */
- (void)shareToQQWithMusicTitle:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl musicDataUrl:(NSString *)musicDataUrl{
    QQApiAudioObject *musicObject = [QQApiAudioObject objectWithURL:[NSURL URLWithString:musicDataUrl]
                                                              title:title
                                                        description:description
                                                    previewImageURL:[NSURL URLWithString:previewImageUrl]];
    [self sendToQQMessageContent:musicObject];
}


/**
 分享视频
 
 @param title            标题
 @param description      描述
 @param previewImageData 预览图
 @param videoDataUrl     视频url
 */
- (void)shareToQQWithVideotTitle:(NSString *)title description:(NSString *)description previewImageData:(NSData *)previewImageData videoDataUrl:(NSString *)videoDataUrl{
    
    QQApiVideoObject *videoObject = [QQApiVideoObject objectWithURL:[NSURL URLWithString:videoDataUrl]
                                                              title:title
                                                        description:description
                                                   previewImageData:previewImageData];
    [self sendToQQMessageContent:videoObject];
    
}
#pragma mark - TencentSessionDelegate
// 登录成功
- (void)tencentDidLogout{
    
}
// 非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled{
    
}

// 网络错误导致登录失败
- (void)tencentDidNotNetWork{
    
}
#pragma mark - TencentApiInterfaceDelegate
// 腾讯业务向第三方应用主动发起请求，要求第三方应用响应提供内容，第三方应用再响应完成后需要调用TencentApiInterface的sendRespMessageToTencentApp返回腾讯业务。
- (BOOL)onTencentReq:(TencentApiReq *)req{
    return YES;
}
// 第三方应用主动向腾讯业务发起请求后，腾讯业务返回请求结果
- (BOOL)onTencentResp:(TencentApiResp *)resp{
    return YES;
}
@end
