//
//  ReplayKitManager.m
//  DaRenShop
//
//  Created by LuisX on 2017/4/6.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "ReplayKitManager.h"
@interface  ReplayKitManager() <RPPreviewViewControllerDelegate, RPScreenRecorderDelegate>

@end

@implementation ReplayKitManager
+ (ReplayKitManager *)sharedManager{
    
    static ReplayKitManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ReplayKitManager new];
    });
    return manager;
    
}


/**
 系统是否支持
 */
+ (BOOL)isSupportReplay{
    
    NSString* version = [[UIDevice currentDevice] systemVersion];
    BOOL _ios90orNewer = [version compare: @"9.0" options: NSNumericSearch] != NSOrderedAscending;
    return _ios90orNewer;
    
}

#pragma mark - 录制
/**
 开始录制
 */
- (void)startRecordingHandler:(void(^)(NSError *error))handler{
    
    RPScreenRecorder *recorder = RPScreenRecorder.sharedRecorder;
    if (recorder.available == NO) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"iOS9以上系统可以使用录屏功能"];
        return;
    }
    
    if (recorder.recording == YES) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"正在录制中..."];
        return;
    }
    
    // 添加代理:防止有些设备录制出来黑屏
    recorder.delegate = self;
    [recorder startRecordingWithMicrophoneEnabled:YES handler:handler];
    
}

/**
 结束录制
 */
- (void)stopRecording{
    
    RPScreenRecorder *recorder = RPScreenRecorder.sharedRecorder;
    if (recorder.recording == NO) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [recorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        
        if (error) {
            [QuicklyHUD showWindowsOnlyTextHUDText:@"未知错误"];
            return;
        }
        
        if (previewViewController) {
            previewViewController.previewControllerDelegate = self;
            if ([weakSelf.delegate respondsToSelector:@selector(replayKitDisplayRecordingContent:)]) {
                [weakSelf.delegate replayKitDisplayRecordingContent:previewViewController];
            }
        }
        
    }];
    
}


#pragma mark - RPPreviewViewControllerDelegate
- (void)previewControllerDidFinish:(RPPreviewViewController*)previewController{
    
    if (previewController) {
        [previewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}

#pragma mark - RPScreenRecorderDelegate
- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithError:(NSError *)error previewViewController:(nullable RPPreviewViewController *)previewViewController{
    
    // Display the error the user to alert them that the recording failed.
    //    showScreenRecordingAlert(error.localizedDescription)
    
    /// Hold onto a reference of the `previewViewController` if not nil.
    
}
@end
