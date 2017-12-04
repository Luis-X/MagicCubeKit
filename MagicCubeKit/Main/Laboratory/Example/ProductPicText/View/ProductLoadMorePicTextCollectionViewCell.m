//
//  ProductLoadMorePicTextCollectionViewCell.m
//  DaRenShop
//
//  Created by LuisX on 2017/11/24.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "ProductLoadMorePicTextCollectionViewCell.h"

@implementation ProductLoadMorePicTextCollectionViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self bulidSubViews];
        [self bulidLayouts];
    }
    return self;
}

- (void)bulidSubViews
{
    _imageView = [UIImageView new];
    _imageView.contentMode = 2;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    _priceLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_priceLabel];
}

- (void)bulidLayouts
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(105);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
}

- (void)dealloc{
    _imageView = nil;
    _titleLabel = nil;
    _priceLabel = nil;
}

- (void)setProductRecommendModel:(ProductRecommend *)productRecommendModel
{
    if (_productRecommendModel != productRecommendModel) {
        _productRecommendModel = productRecommendModel;
        
        NSString *imgUrlString = [NetworkManager httpsSchemeHandler:productRecommendModel.image];
        NSURL *imageUrl = [NSURL URLWithString:imgUrlString];
        [_imageView sd_setImageWithURL:imageUrl];
        _titleLabel.text = [NSString stringWithFormat:@"%@", _productRecommendModel.name];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _productRecommendModel.price];
        [ProductConstant setRichSignNumberWithLabel:_priceLabel BigSize:12 * HOME_IPHONE6_HEIGHT SmallSize:10 * HOME_IPHONE6_HEIGHT Color:_priceLabel.textColor];
    }
}
@end
