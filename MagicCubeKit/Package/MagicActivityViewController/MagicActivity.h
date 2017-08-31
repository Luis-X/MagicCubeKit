//
//  MagicActivity.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/18.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicActivity : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconfont_code;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highImage;

+ (MagicActivity *)activityWithTitle:(NSString *)title iconFontCode:(NSString *)iconfontCode;
+ (MagicActivity *)activityWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;
@end
