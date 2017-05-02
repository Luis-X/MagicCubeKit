//
//  SJScreenShortManager.h
//  DaRenShop
//
//  Created by LuisX on 2017/4/18.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJScreenShortManager : NSObject
+ (SJScreenShortManager *)shareManager;
- (void)startScreenShort:(BOOL)open;
@end
