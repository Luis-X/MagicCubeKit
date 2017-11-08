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
    _titleLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    [self addSubview:_titleLabel];
    
}

- (void)settingAutoLayout{

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10 * HOME_IPHONE6_WIDTH);
    }];
    
}

#pragma mark -Update
- (void)updateHeaderDataWithSkuListModel:(ProductSkuList *)skuListModel{
    _titleLabel.text = [NSString stringWithFormat:@"%@", skuListModel.classify];
}
@end
