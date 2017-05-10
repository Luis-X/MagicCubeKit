//
//  MagicPermissionManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicPermissionManager.h"

@implementation MagicPermissionManager

+ (MagicPermissionManager *)shareManager{
    
    static MagicPermissionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MagicPermissionManager new];
    });
    return manager;
    
}

#pragma mark -权限检测
/**
 (相机)权限
 */
- (BOOL)iPhoneSystemPermissionCamera{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        //未授权
        [self showAlertViewWithType:PermissionMessageTypeCamera];
        return NO;
    }
    return YES;
    
}

/**
 (相册)权限
 */
- (BOOL)iPhoneSystemPermissionPhotoLibrary{
    
    if (IPHONE_SYSTEM_VERSION >= 8.0) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if(status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
            //未授权
            [self showAlertViewWithType:PermissionMessageTypePhotoLibrary];
            return NO;
        }
    }
    if (IPHONE_SYSTEM_VERSION >= 6.0 && IPHONE_SYSTEM_VERSION < 8.0){
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if(status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
            //未授权
            [self showAlertViewWithType:PermissionMessageTypePhotoLibrary];
            return NO;
        }
    }
    return YES;
    
}

/**
 (通知)权限
 */
- (BOOL)iPhoneSystemPermissionNotification{
    
    if (IPHONE_SYSTEM_VERSION >= 8.0){
        UIUserNotificationSettings *status = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (status.types == UIUserNotificationTypeNone){
            //未授权
            [self showAlertViewWithType:PermissionMessageTypeNotification];
            return NO;
        }
    }else{
        UIRemoteNotificationType status = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(status == UIRemoteNotificationTypeNone){
            //未授权
            [self showAlertViewWithType:PermissionMessageTypeNotification];
            return NO;
        }
    }
    return YES;
    
}

/**
 (网络)权限
 */
- (void)iPhoneSystemPermissionNetwork{
    
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    __weak typeof(self) weakSelf = self;
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        if (state == kCTCellularDataRestricted) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showAlertViewWithType:PermissionMessageTypeNetwork];
            });
            
        }
    };
    
}

/**
 (麦克风)权限
 */
- (BOOL)iPhoneSystemPermissionAudio{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        //未授权
        [self showAlertViewWithType:PermissionMessageTypeAudio];
        return NO;
    }
    return YES;
    
}

/**
 (定位)权限
 */
- (BOOL)iPhoneSystemPermissionLocation{
    
    BOOL status = [CLLocationManager locationServicesEnabled];
    if (!status) {
        CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
        if (CLstatus == kCLAuthorizationStatusDenied || CLstatus == kCLAuthorizationStatusDenied) {
            //未授权
            [self showAlertViewWithType:PermissionMessageTypeLocation];
            return NO;
        }
    }
    return YES;
}


/**
 (通讯录)权限
 */
- (BOOL)iPhoneSystemPermissionAddressBook{
    
    if (IPHONE_SYSTEM_VERSION >= 9.0) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted){
            //未授权
            [self showAlertViewWithType:PermissionMessageTypeAddressBook];
            return NO;
        }
    }else{
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted){
            //未授权
            [self showAlertViewWithType:PermissionMessageTypeAddressBook];
            return NO;
        }
    }
    return YES;
}


/**
 (日历)权限
 */
- (BOOL)iPhoneSystemPermissionCalendar{
    
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (status == EKAuthorizationStatusDenied || status == EKAuthorizationStatusRestricted){
        //未授权
        [self showAlertViewWithType:PermissionMessageTypeCalendar];
        return NO;
    }
    return YES;
    
}


/**
 (备忘录)权限
 */
- (BOOL)iPhoneSystemPermissionReminder{
    
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (status == EKAuthorizationStatusDenied || status == EKAuthorizationStatusRestricted){
        //未授权
        [self showAlertViewWithType:PermissionMessageTypeReminder];
        return NO;
    }
    return YES;
    
}

#pragma mark -跳转设置界面
/**
 提示框
 */
- (void)showAlertViewWithType:(PermissionMessageType)type{
    NSString *title;
    
    switch (type) {
        case PermissionMessageTypeCamera:
            title = [NSString stringWithFormat:@"允许“%@”使用相机?", SJ_APP_NAME];
            break;
        case PermissionMessageTypePhotoLibrary:
            title = [NSString stringWithFormat:@"允许“%@”使用相册?", SJ_APP_NAME];
            break;
        case PermissionMessageTypeNotification:
            title = [NSString stringWithFormat:@"允许“%@”使用推送?", SJ_APP_NAME];
            break;
        case PermissionMessageTypeNetwork:
            title = [NSString stringWithFormat:@"如果一直遇到不能联网的问题，请尝试前往手机的设置-无线局域网-使用无线局域网与蜂窝移动的应用中，进入列表中任意一项切换一下状态，再回到%@进行网络授权。", SJ_APP_NAME];
            break;
        case PermissionMessageTypeAudio:
            title = [NSString stringWithFormat:@"允许“%@”使用麦克风?", SJ_APP_NAME];
            break;
        case PermissionMessageTypeLocation:
            title = [NSString stringWithFormat:@"允许“%@”使用定位?", SJ_APP_NAME];
            break;
        case PermissionMessageTypeAddressBook:
            title = [NSString stringWithFormat:@"允许“%@”使用通讯录?", SJ_APP_NAME];
            break;
        case PermissionMessageTypeCalendar:
            title = [NSString stringWithFormat:@"允许“%@”使用日历?", SJ_APP_NAME];
            break;
        case PermissionMessageTypeReminder:
            title = [NSString stringWithFormat:@"允许“%@”使用备忘录?", SJ_APP_NAME];
            break;
        default:
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"我知道了", nil];
    alertView.delegate = self;
    [alertView show];
    alertView.tag = type;
    
}

#pragma mark -- AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0){
        [self openIPhoneSystemSettingPageAfterIOS8];
        [self openIPhoneSystemSettingPageBeforeIOS8WithType:alertView.tag];
    }
}


/**
 iOS8以后_设置界面
 */
- (void)openIPhoneSystemSettingPageAfterIOS8{
    
    if (IPHONE_SYSTEM_VERSION < 8.0) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

/**
 iOS8以前_设置界面
 */
- (void)openIPhoneSystemSettingPageBeforeIOS8WithType:(PermissionMessageType)type{
    
    if (IPHONE_SYSTEM_VERSION >= 8.0) {
        return;
    }
    
    NSURL *url;
    switch (type) {
        case PermissionMessageTypeCamera:
            url = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            break;
        case PermissionMessageTypePhotoLibrary:
            url = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            break;
        case PermissionMessageTypeNotification:
            break;
        case PermissionMessageTypeNetwork:
            url = [NSURL URLWithString:@"prefs:root=General&path=Network"];
            break;
        case PermissionMessageTypeAudio:
            url = [NSURL URLWithString:@"prefs:root=Privacy&path=Audio"];
            break;
        case PermissionMessageTypeLocation:
            url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            break;
        case PermissionMessageTypeAddressBook:
            url = [NSURL URLWithString:@"prefs:root=Privacy&path=AddressBook"];
            break;
        case PermissionMessageTypeCalendar:
            url = [NSURL URLWithString:@"prefs:root=Privacy&path=Calendar"];
            break;
        case PermissionMessageTypeReminder:
            url = [NSURL URLWithString:@"prefs:root=Privacy&path=NOTES"];
            break;
            
        default:
            break;
    }
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

@end
