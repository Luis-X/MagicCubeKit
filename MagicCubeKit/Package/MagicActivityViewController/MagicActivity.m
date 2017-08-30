//
//  MagicActivity.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/18.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicActivity.h"

@implementation MagicActivity

#pragma mark NSObject


+ (MagicActivity *)activityWithTitle:(NSString *)title iconFontCode:(NSString *)iconfontCode{
    MagicActivity *activity = [[MagicActivity alloc] init];
    activity.title = title;
    activity.iconfont_code = iconfontCode;
    return activity;
}

+ (MagicActivity *)activityWithTitle:(NSString *)title image:(UIImage *)image{
    MagicActivity *activity = [[MagicActivity alloc] init];
    activity.title = title;
    activity.image = image;
    return activity;
}
@end
