//
//  MagicShareManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MagicShareWeChat.h"
#import "MagicShareQQ.h"
#import "MagicShareParameter.h"


@interface MagicShareManager : NSObject
+ (void)shareWebPageUrlParameters:(MagicShareParameter *)parameters;
@end
