//
//  ExampleMagicCenterTagCollectionViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/6.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicCenterTagCollectionViewCell.h"

@implementation ExampleMagicCenterTagCollectionViewCell{
    UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)createSubViews{
    
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:10 * HOME_IPHONE6_HEIGHT];
    _titleLabel.layer.cornerRadius = (CenterTagCell_height / 2);
    _titleLabel.layer.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00].CGColor;
    [self.contentView addSubview:_titleLabel];
    
}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
}

- (void)updateCellDataWithValue:(NSString *)value{
    _titleLabel.text = value;
}
@end
