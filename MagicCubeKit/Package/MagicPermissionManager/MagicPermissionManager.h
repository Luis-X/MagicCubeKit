//
//  MagicPermissionManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@import CoreTelephony;
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>

//系统版本
#define IPHONE_SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
#define SJ_APP_NAME            @"达人店"

//提示信息类型枚举
typedef enum : NSUInteger {
    PermissionMessageTypeCamera,
    PermissionMessageTypePhotoLibrary,
    PermissionMessageTypeNotification,
    PermissionMessageTypeNetwork,
    PermissionMessageTypeAudio,
    PermissionMessageTypeLocation,
    PermissionMessageTypeAddressBook,
    PermissionMessageTypeCalendar,
    PermissionMessageTypeReminder,
} PermissionMessageType;

@interface MagicPermissionManager : NSObject
+ (MagicPermissionManager *)shareManager;
- (BOOL)iPhoneSystemPermissionCamera;               //相机
- (BOOL)iPhoneSystemPermissionPhotoLibrary;         //相册
- (BOOL)iPhoneSystemPermissionNotification;         //通知
- (void)iPhoneSystemPermissionNetwork;              //网络
- (BOOL)iPhoneSystemPermissionAudio;                //麦克风
- (BOOL)iPhoneSystemPermissionLocation;             //定位
- (BOOL)iPhoneSystemPermissionAddressBook;          //通讯录
- (BOOL)iPhoneSystemPermissionCalendar;             //日历
- (BOOL)iPhoneSystemPermissionReminder;             //备忘录
@end
