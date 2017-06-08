//
//  MagicScrollPageRefreshHeader.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicScrollPageRefreshHeader.h"

@interface MagicScrollPageRefreshHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UILabel *icon;
@property (weak, nonatomic) UIView *contentView;
@end

@implementation MagicScrollPageRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    // 设置控件的高度
    self.mj_h = 50;
    
    // 承载
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    
    // 文本
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.label = label;
    
    
    // icon
    UILabel *icon = [[UILabel alloc] init];
    icon.font = [UIFont fontWithName:@"iconfont" size:15];
    icon.text = @"\U0000e604";
    [self.contentView addSubview:icon];
    self.icon = icon;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    [super placeSubviews];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(self.frame.size.height);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉回到”商品详情“";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"释放回到”商品详情“";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在回到”商品详情“";
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"";
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
}

@end
