//
//  WebPageAlertManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/11/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebPageAlertManager : NSObject
+ (WebPageAlertManager *)shareManager;
- (void)showWebPageAlert;
@end
