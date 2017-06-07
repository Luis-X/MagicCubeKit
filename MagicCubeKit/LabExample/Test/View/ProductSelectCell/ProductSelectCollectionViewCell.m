//
//  ProductSelectCollectionViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSelectCollectionViewCell.h"

@implementation ProductSelectCollectionViewCell{
    UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        [self settingAutoLayout];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)createSubViews{
    
    _titleLabel = [UILabel new];
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
}

- (void)setModel:(Value *)model{
    
    if (_model != model) {
        _model = model;
    }
    _titleLabel.text = [NSString stringWithFormat:@"%@", [model.mj_keyValues objectForKey:@"name"]];
    
}

- (void)setCellSelected:(BOOL)cellSelected{
    
    _cellSelected = cellSelected;
    _titleLabel.backgroundColor = _cellSelected ? [UIColor colorWithRed:0.98 green:0.20 blue:0.31 alpha:1.00] : [UIColor whiteColor];
    
}

@end
