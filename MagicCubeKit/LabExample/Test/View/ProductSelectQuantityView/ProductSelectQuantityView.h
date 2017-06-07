//
//  ProductSelectQuantityView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/7.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSelectQuantityView : UIView
@property (nonatomic, assign) NSInteger currentNum;           //当前值   (默认: 1)
@property (nonatomic, assign) NSInteger miniValue;            //最小值   (默认: 1)
@property (nonatomic, assign) NSInteger maxValue;             //最大值   (默认: MAXFLOAT)
@property (nonatomic, assign) BOOL inputEnabled;              //支持输入 (默认: NO)
- (void)hiddenKeyboard;                                       //隐藏键盘
@end
