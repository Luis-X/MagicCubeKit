//
//  SJHSlideMenu.h
//  SJHSlideMenuViewDemo
//
//  Created by yzq on 16/6/16.
//  Copyright © 2016年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>

// 六进制颜色转换
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@protocol SJHSlideMenuDelegate <NSObject>

- (void)sjHSlideMenuDidSelect:(NSInteger)index;

@end

/**
 *  顶部滑动菜单
 */
@interface SJHSlideMenu : UIView

/**
 *  菜单按钮左侧偏移量
 */
@property (assign, nonatomic) CGFloat xOffset;

/**
 *  菜单按钮大小
 */
@property (assign, nonatomic) CGSize btnSize;

/**
 *  菜单按钮标题
 */
@property (strong, nonatomic) NSArray *arrTitles;

/**
 *  委托
 */
@property (assign, nonatomic) id<SJHSlideMenuDelegate> delegate;

/**
 *  当前选中的下标
 */
@property (assign, nonatomic) NSInteger selectedIndex;

/**
 *  滑动线
 */
@property (strong, nonatomic) UIView *mViewCurrent;

/**
 *  计算滑动线的Frame
 *
 *  @param index 下标
 *
 *  @return 滑动线在index的Frame
 */
- (CGRect)getCurrentViewFrameForIndex:(NSInteger)index;

/**
 *  菜单字体
 */
@property (strong, nonatomic) UIFont *menuFont;

/**
 *  菜单普通状态文字颜色
 */
@property (strong, nonatomic) UIColor *menuNormalColor;

/**
 *  菜单选中状态文字颜色
 */
@property (strong, nonatomic) UIColor *menuSelectedColor;

/**
 *  菜单滑动线颜色
 */
@property (strong, nonatomic) UIColor *menuSlideColor;
/**
 *  菜单顶部线条颜色
 */
@property (strong, nonatomic) UIColor *menuSlideBottomColor;

@end
