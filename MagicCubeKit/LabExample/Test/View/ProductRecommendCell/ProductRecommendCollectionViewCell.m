//
//  ProductRecommendCollectionViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductRecommendCollectionViewCell.h"

@implementation ProductRecommendCollectionViewCell{
    UIImageView *_imageView;     //商品图
    UILabel *_titleLabel;        //标题
    UILabel *_priceLabel;        //价格
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creteSubviews];
    }
    return self;
}

- (void)creteSubviews{
    
    [self createImageView];
    [self createTitleLabel];
    [self createPriceLabel];
    
}

/**
 商品图
 */
- (void)createImageView{
    _imageView = [UIImageView new];
    _imageView.contentMode = 2;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(105 * HOME_IPHONE6_HEIGHT);
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
    }];
}

/**
 标题
 */
- (void)createTitleLabel{
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(10 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(self.contentView).offset(5 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(self.contentView).offset(-5 * HOME_IPHONE6_WIDTH);
    }];
}

/**
 价格
 */
- (void)createPriceLabel{
    _priceLabel = [UILabel new];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-20 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(self.contentView).offset(5 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(self.contentView).offset(-5 * HOME_IPHONE6_WIDTH);
    }];
}

- (void)setRecommendModel:(Recommend *)recommendModel{
    
    if (_recommendModel != recommendModel) {
        _recommendModel =  recommendModel;
    }
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_recommendModel.image]];
    _titleLabel.text = [NSString stringWithFormat:@"%@", _recommendModel.name];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _recommendModel.price];
    [ProductConstant setRichSignNumberWithLabel:_priceLabel BigSize:12 * HOME_IPHONE6_HEIGHT SmallSize:10 * HOME_IPHONE6_HEIGHT Color:_priceLabel.textColor];
}
@end
