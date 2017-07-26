//
//  BaseWebView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseWebView.h"

@implementation BaseWebView

/**
 设置UIWebView透明
 */
- (void)backgroundClearColor{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];
}

@end
