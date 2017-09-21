//
//  UIColor+Tool.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Tool)
- (UIImage *)colorToUIImage;                               //转UIImage
- (BOOL)isEqualToColor:(UIColor *)otherColor;              //是否颜色相同
@end
