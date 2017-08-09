//
//  MagicAPM.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/4.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicAPM.h"

@implementation MagicAPM
+ (void)start{
    
    [self addCustomPlugin];
    [[ATManager shareInstance] show];
    
}

+ (void)addCustomPlugin{
    
    //只支持ATSDK.bundle中资源文件
    
    //一级插件
    [[ATManager shareInstance] addPluginWithId:@"weex"
                                       andName:@"入口"
                                   andIconName:@"at_alert_confirm"
                                      andEntry:nil
                                       andArgs:nil];
    //二级插件
    [[ATManager shareInstance] addSubPluginWithParentId:@"weex"
                                               andSubId:@"测试"
                                                andName:@"测试"
                                            andIconName:@"log"
                                               andEntry:@"CustomePlugin"
                                                andArgs:nil];
    
    [[ATManager shareInstance] addSubPluginWithParentId:@"weex"
                                               andSubId:@"测试"
                                                andName:@"测试"
                                            andIconName:@"log"
                                               andEntry:@"CustomePlugin"
                                                andArgs:nil];

}
@end
