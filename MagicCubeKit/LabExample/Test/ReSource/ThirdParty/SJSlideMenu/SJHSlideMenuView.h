//
//  SJHSlideMenuView.h
//  SJHSlideMenuViewDemo
//
//  Created by yzq on 16/6/16.
//  Copyright © 2016年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  滑动菜单视图
 */
@interface SJHSlideMenuView : UIView

/*****  必需属性    *****/

/**
 *  菜单高度
 */
@property (assign, nonatomic) CGFloat menuHeight;
/**
 *  菜单按钮左侧偏移量
 */
@property (assign, nonatomic) CGFloat xOffset;
/**
 *  菜单按钮大小，滑动线长度和按钮大小保持一致(按钮高度尽量保持比菜单高度少2个像素)
 */
@property (assign, nonatomic) CGSize btnSize;
/**
 *  菜单标题
 */
@property (strong, nonatomic) NSArray *arrTitles;
/**
 *  内容视图
 */
@property (strong, nonatomic) NSArray *arrContent;


/*****  可选属性    *****/


/**
 *  当前选中的下标
 */
@property (assign, nonatomic) NSInteger selectedIndex;

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
