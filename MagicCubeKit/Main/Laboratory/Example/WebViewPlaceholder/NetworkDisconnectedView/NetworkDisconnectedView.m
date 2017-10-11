//
//  NetworkDisconnectedView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "NetworkDisconnectedView.h"

@interface NetworkDisconnectedView ()
@property(nonatomic,copy)NetworkDisconnectedReloadBlock reloadBlock;
@end

@implementation NetworkDisconnectedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubViews];
    }
    return self;
}

+ (instancetype)placeholderAddView:(UIView *)addView reloadBlock:(NetworkDisconnectedReloadBlock)reloadBlock
{
    
    NetworkDisconnectedView *networkDisconnectedView = [[NetworkDisconnectedView alloc] init];
    [networkDisconnectedView clearPlaceholderView];
    networkDisconnectedView.reloadBlock = reloadBlock;
    [addView addSubview:networkDisconnectedView];
    [networkDisconnectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(addView);
    }];
    return networkDisconnectedView;
    
}

- (void)createSubViews
{
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = 2;
    [imageView setImage:[UIImage imageNamed:@"network_disconnected_img"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(205 * HOME_IPHONE6_WIDTH);
        make.height.mas_equalTo(175 * HOME_IPHONE6_HEIGHT);
    }];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00];
    label.text = @"哎呀，网络竟然崩溃了\n刷新下试试吧~";
    label.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(15 * HOME_IPHONE6_HEIGHT);
        make.centerX.equalTo(self);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"network_disconnected_btn"] forState:UIControlStateNormal];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(92 * HOME_IPHONE6_WIDTH);
        make.height.mas_equalTo(30 * HOME_IPHONE6_HEIGHT);
        make.top.equalTo(label.mas_bottom).offset(25 * HOME_IPHONE6_HEIGHT);
    }];
    [button addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.top.left.right.equalTo(imageView);
        make.bottom.equalTo(button);
    }];
    
}

#pragma mark - Action
- (void)reloadButtonAction:(id)sender
{
    
    if (self.reloadBlock) {
        [self clearPlaceholderView];
        self.reloadBlock();
    }
    
}

#pragma mark - 隐藏
- (void)clearPlaceholderView
{
    
    [self.superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NetworkDisconnectedView class]]) {
            [obj removeFromSuperview];
        }
    }];
    
}

@end
