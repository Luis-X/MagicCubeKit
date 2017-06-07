//
//  ProductSelectHeaderCollectionReusableView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSelectHeaderCollectionReusableView.h"

@implementation ProductSelectHeaderCollectionReusableView{
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
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    
}

- (void)settingAutoLayout{

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
    
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}
@end
