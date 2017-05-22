//
//  MagicScrollPage.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/19.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagicScrollPage : UIScrollView
+ (instancetype)showScrollPageViewWithFrame:(CGRect)frame firstPage:(UIScrollView *)firstPageView secondPage:(UIScrollView *)secondPageView;
@property (nonatomic, assign) CGFloat animationDuration;               //动画时长  (默认:0.3)
@property (nonatomic, copy) NSString *headerRefreshTitle;              //下拉标题  (默认: 下拉回到“商品详情”)
@property (nonatomic, copy) NSString *footerRefreshTitle;              //上拉标题  (默认: 上拉查看图文详情)

@end
