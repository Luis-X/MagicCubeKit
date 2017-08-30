//
//  MagicActivityCollectionViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicActivityCollectionViewCell.h"

@interface MagicActivityCollectionViewCell ()
@property (nonatomic, strong) UIView *itemBackgroundView;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemTextLabel;
@property (nonatomic, strong) UILabel *itemIconfontLabel;
@end

@implementation MagicActivityCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainLayoutSubViews];
    }
    return self;
}

#pragma mark - Lazy
- (UIView *)itemBackgroundView{
    if (!_itemBackgroundView) {
        _itemBackgroundView = [UIView new];
        [self.contentView addSubview:_itemBackgroundView];
    }
    return _itemBackgroundView;
}

- (UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
        _itemImageView.backgroundColor = [UIColor whiteColor];
        [self.itemBackgroundView addSubview:_itemImageView];
    }
    return _itemImageView;
}

- (UILabel *)itemTextLabel{
    if (!_itemTextLabel) {
        _itemTextLabel = [[UILabel alloc] init];
        _itemTextLabel.font = [UIFont systemFontOfSize:10];
        _itemTextLabel.textColor = [UIColor colorWithWhite:0.55 alpha:1.00];
        _itemTextLabel.numberOfLines = 2;
        _itemTextLabel.textAlignment = NSTextAlignmentCenter;
        [self.itemBackgroundView addSubview:_itemTextLabel];
    }
    return _itemTextLabel;
}

- (UILabel *)itemIconfontLabel{
    if (!_itemIconfontLabel) {
        _itemIconfontLabel = [[UILabel alloc] init];
        _itemIconfontLabel.font = [UIFont fontWithName:@"iconfont" size:30];
        _itemIconfontLabel.textAlignment = NSTextAlignmentCenter;
        [self.itemBackgroundView addSubview:_itemIconfontLabel];
    }
    return _itemIconfontLabel;
}

- (void)createMainLayoutSubViews{
    
    CGFloat item_width = self.frame.size.width;
    
    [self.itemBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(item_width);
    }];
    
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.itemBackgroundView);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.itemTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.itemBackgroundView);
        make.left.equalTo(self.itemBackgroundView).offset(5);
        make.right.equalTo(self.itemBackgroundView).offset(-5);
    }];

    [self.itemIconfontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.itemImageView);
    }];
    
}

- (void)setMagicActivityItem:(MagicActivity *)magicActivityItem{
    if (_magicActivityItem != magicActivityItem) {
        _magicActivityItem = magicActivityItem;
    }
    
    if (magicActivityItem.image) {
        [self.itemImageView setImage:magicActivityItem.image];
    }
    if (magicActivityItem.iconfont_code) {
        self.itemIconfontLabel.text = magicActivityItem.iconfont_code;
    }
    if (magicActivityItem.title.length) {
        self.itemTextLabel.text = [NSString stringWithFormat:@"%@", magicActivityItem.title];
    }
    
}
@end
