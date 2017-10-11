//
//  NetworkDisconnectedView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NetworkDisconnectedReloadBlock)();

@interface NetworkDisconnectedView : UIView
+ (instancetype)placeholderAddView:(UIView *)addView reloadBlock:(NetworkDisconnectedReloadBlock)reloadBlock;
@end
