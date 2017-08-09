//
//  CustomePlugin.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/4.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "CustomePlugin.h"

@implementation CustomePlugin
// 加载
- (void)pluginDidLoadWithArgs:(NSArray *)args{
    
}

// 打开
- (void)pluginWillOpenInContainer:(UIViewController *)container withArg:(NSArray *)args{
    NSLog(@"点击了插件");
}

// 关闭
- (void)pluginWillClose{
    
}

// 未加载
- (void)pluginDidUnload{
    
}

// 位置
- (CGRect)wantReactArea{
    return CGRectZero;
}
@end
