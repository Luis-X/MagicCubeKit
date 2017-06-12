//
//  MagicScrollPage.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/19.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MagicScrollPageDelegate <NSObject>

- (void)magicScrollPageDidScrollToPageIndex:(NSInteger)index;

@end

@interface MagicScrollPage : UIScrollView


+ (instancetype)showScrollPageViewWithFrame:(CGRect)frame firstPage:(UIScrollView *)firstPageView secondPage:(UIScrollView *)secondPageView;
@property (nonatomic, assign)id <MagicScrollPageDelegate> myDelegate;
@property (nonatomic, assign) CGFloat animationDuration;               // 动画时长  (默认:0.3)
- (void)moveToFirstPageView;                                           // 切换到第一页
- (void)moveToSecondPageView;                                          // 切换到第二页
@end
