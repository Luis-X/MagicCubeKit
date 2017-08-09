//
//  MagicTimerManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/7.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicTimerManager : NSObject
@property (nonatomic, assign)__block int timeout;
+ (MagicTimerManager *)shareManager;
- (void)countDown;
@end
