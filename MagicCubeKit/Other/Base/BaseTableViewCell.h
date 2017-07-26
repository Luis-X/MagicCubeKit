//
//  BaseTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
// 属性
@property (nonatomic, weak) NSIndexPath *cell_indexPath;

// 方法 【子类可以重写】
- (void)baseBuildDefaultConfig;
- (void)baseBuildSubViews;
- (void)baseLoadData:(id)data indexPath:(NSIndexPath *)indexPath;
- (void)baseSelectedBackgroudColor:(UIColor *)backgroundColor;
@end
