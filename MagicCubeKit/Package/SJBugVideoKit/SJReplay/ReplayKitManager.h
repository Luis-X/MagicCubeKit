//
//  ReplayKitManager.h
//  DaRenShop
//
//  Created by LuisX on 2017/4/6.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReplayKit/ReplayKit.h>

@protocol ReplayKitManagerDelegate <NSObject>

- (void)replayKitDisplayRecordingContent:(RPPreviewViewController *)previewViewController;          //显示预览

@end

@interface ReplayKitManager : NSObject<RPPreviewViewControllerDelegate, RPScreenRecorderDelegate>
+ (ReplayKitManager *)sharedManager;
// 是否支持录像功能(仅ios9以上支持)
+ (BOOL)isSupportReplay;
// 开始
- (void)startRecordingHandler:(void(^)(NSError *error))handler;
// 结束
- (void)stopRecording;

@property (nonatomic, assign)id <ReplayKitManagerDelegate>delegate;
@end
