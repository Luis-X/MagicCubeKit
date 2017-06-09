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

#pragma mark -Update
- (void)updateHeaderDataWithSkuListModel:(SkuList *)skuListModel{
    _titleLabel.text = [NSString stringWithFormat:@"%@", skuListModel.classify];
}
@end
