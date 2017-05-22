//
//  MagicIconButton.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/19.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    IconTextButtonStyleTop,                 //Icon(上)
    IconTextButtonStyleLeft,                //Icon(左)
    IconTextButtonStyleBottom,              //Icon(下)
    IconTextButtonStyleRight,               //Icon(右)
} IconTextButtonStyle;

@interface MagicIconButton: UIControl
@property(nonatomic, strong)UIImageView *iconImageView;               //图片icon
@property(nonatomic, strong)UILabel *iconLabel;                       //字体icon
@property(nonatomic, strong)UILabel *titleLabel;                      //默认: 居中,字号17,字色black
@property(nonatomic, assign)IconTextButtonStyle buttonStyle;          //默认: IconTextButtonStyleLeft
@property(nonatomic, assign)CGSize iconSize;                          //默认: (30,30)
@property(nonatomic, assign)CGFloat iconFontSize;                     //默认: 20
@property(nonatomic, assign)UIEdgeInsets buttonEdges;                 //默认: (0,0,0,0)    调节(上,左,下,右)间距
@property(nonatomic, assign)BOOL enableHighlight;                     //默认: NO           按下black(根据titleLabel颜色还原icon,titleLabel颜色)
@end

