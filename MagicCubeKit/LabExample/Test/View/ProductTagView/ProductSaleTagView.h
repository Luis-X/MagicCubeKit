//
//  ProductSaleTagView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSaleTagView : UIView
@property (nonatomic, copy)NSString *title;             //文案
@property (nonatomic, assign)CGFloat fontSize;          //字体大小 （默认：10）
@property (nonatomic, strong)UIColor *textColor;        //字体颜色 （默认：#F03337）
@property (nonatomic, assign)UIColor *borderColor;      //边框颜色
@property (nonatomic, assign)UIColor *bgColor;          //背景颜色
@property (nonatomic, assign)CGFloat height;            //高度
@end
