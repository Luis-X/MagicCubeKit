//
//  UIColor+Magic.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Magic)
- (UIImage *)magicToUIImage;                                    //转UIImage
- (BOOL)magicIsEqualToColor:(UIColor *)otherColor;              //是否颜色相同
@end
