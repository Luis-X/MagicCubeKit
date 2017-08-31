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
@property (nonatomic, strong) UIButton *itemButton;
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

- (UIButton *)itemButton{
    if (!_itemButton) {
        _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _itemButton.layer.cornerRadius = 15;
        _itemButton.userInteractionEnabled = YES;
        [self.itemBackgroundView addSubview:_itemButton];
        [_itemButton addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemButton;
}

- (UILabel *)itemTextLabel{
    if (!_itemTextLabel) {
        _itemTextLabel = [[UILabel alloc] init];
        _itemTextLabel.font = [UIFont systemFontOfSize:10];
        _itemTextLabel.textColor = [UIColor colorWithWhite:0.35 alpha:1.00];
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
        make.top.equalTo(self.contentView).mas_equalTo(10);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(item_width);
    }];
    
    [self.itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.itemBackgroundView);
        make.width.height.mas_equalTo(64);
    }];
    
    [self.itemTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemButton.mas_bottom).offset(5);
        make.bottom.equalTo(self.itemBackgroundView);
        make.left.right.equalTo(self.itemButton);
    }];

    [self.itemIconfontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.itemButton);
    }];
    
}

- (void)setMagicActivityItem:(MagicActivity *)magicActivityItem{
    if (_magicActivityItem != magicActivityItem) {
        _magicActivityItem = magicActivityItem;
    }
    
    if (magicActivityItem.image) {
        [self.itemButton setImage:magicActivityItem.image forState:UIControlStateNormal];
    }
    if (magicActivityItem.highImage) {
        [self.itemButton setImage:magicActivityItem.highImage forState:UIControlStateHighlighted];
    }
    if (magicActivityItem.iconfont_code) {
        self.itemIconfontLabel.text = magicActivityItem.iconfont_code;
    }
    if (magicActivityItem.title.length) {
        self.itemTextLabel.text = [NSString stringWithFormat:@"%@", magicActivityItem.title];
    }
    
}

#pragma mark - Action
- (void)itemButtonAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(magicActivityCollectionViewCellDidSelectItemAtIndexPath:)]) {
        [self.delegate magicActivityCollectionViewCellDidSelectItemAtIndexPath:_cellIndexPath];
    }
}
@end
