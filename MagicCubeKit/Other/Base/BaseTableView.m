//
//  BaseTableView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()<UITableViewDelegate>

@end

@implementation BaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 功能
/*
 *不满一屏去除多余单元格
 */
- (void)baseClearUnnecessaryRow{
    self.tableHeaderView = [UIView new];
    self.tableFooterView = [UIView new];
}

/**
 置顶tableView
 */
- (void)baseStickTableView{
    [self setContentOffset:CGPointZero animated:YES];
    // 或
    //[self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
@end
