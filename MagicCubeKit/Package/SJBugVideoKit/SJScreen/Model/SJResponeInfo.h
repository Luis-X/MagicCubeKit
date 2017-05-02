//
//  SJResponeInfo.h
//  DaRenShop
//
//  Created by LuisX on 2017/4/19.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJResponeInfo : NSObject
@property (nonatomic, copy)NSString *userId;          //用户ID
@property (nonatomic, copy)NSString *contentPicUrl;   //反馈图片
@property (nonatomic, copy)NSString *phoneType;       //设备机型
@property (nonatomic, copy)NSString *phoneSystem;     //设备系统
@property (nonatomic, copy)NSString *appName;         //app名称
@property (nonatomic, copy)NSString *appVersion;      //app版本
@property (nonatomic, copy)NSString *appBuild;        //app构建
@end
