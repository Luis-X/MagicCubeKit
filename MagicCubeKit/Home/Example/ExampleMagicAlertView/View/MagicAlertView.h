//
//  MagicAlertView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedIndex)(NSInteger index);
@interface MagicAlertView : UIView
/**
 *  @param title       标题
 *  @param content     内容
 *  @param index       点击按钮
 */
+ (instancetype)showAlterViewWithTitle:(NSString *)title content:(NSString *)content ButtonTitles:(NSArray *)buttonTitles Index:(SelectedIndex)index;
- (void)customButtonColor:(UIColor *)color index:(NSInteger)index; //设置按钮颜色
@end
