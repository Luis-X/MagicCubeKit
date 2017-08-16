//
//  ProductInfomationTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductInfomationTableViewCell.h"
#import "ProductSaleTagView.h"

@implementation ProductInfomationTableViewCell{
    UIView *_cellBackgroundView;                //背景
    UILabel *_titleLabel;                       //标题
    UIImageView *_flagImageView;                //国旗
    UILabel *_tagLabel;                         //标签
    UILabel *_subtitleLabel;                    //副标题
    UILabel *_priceLabel;                       //价格
    UIView  *_priceBackgroundView;              //价格背景
    UIImageView *_specialBGImageView;           //特卖背景
    ProductSaleTagView *_commissionTagView;     //佣金
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)createSubViews{
    
    _cellBackgroundView = [UIView new];
    //_cellBackgroundView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_cellBackgroundView];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithRed:0.10 green:0.07 blue:0.06 alpha:1.00];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16 * HOME_IPHONE6_HEIGHT];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [_cellBackgroundView addSubview:_titleLabel];
    
    _flagImageView = [UIImageView new];
    _flagImageView.hidden = YES;
    [_cellBackgroundView addSubview:_flagImageView];
    
    _tagLabel = [UILabel new];
    _tagLabel.hidden = YES;
    _tagLabel.textColor = [UIColor whiteColor];
    _tagLabel.text = @"海外直邮";
    _tagLabel.font = [UIFont boldSystemFontOfSize:10 * HOME_IPHONE6_HEIGHT];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [_tagLabel jm_setImageWithCornerRadius:8 * HOME_IPHONE6_HEIGHT borderColor:[UIColor clearColor] borderWidth:0 backgroundColor:[UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00]];
    [_cellBackgroundView addSubview:_tagLabel];
    
    _subtitleLabel = [UILabel new];
    _subtitleLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    _subtitleLabel.font = [UIFont systemFontOfSize:10 * HOME_IPHONE6_HEIGHT];
    [_cellBackgroundView addSubview:_subtitleLabel];
    
    _specialBGImageView = [UIImageView new];
    [_cellBackgroundView addSubview:_specialBGImageView];
    
    _priceBackgroundView = [UIView new];
    [_specialBGImageView addSubview:_priceBackgroundView];
    
    _priceLabel = [UILabel new];
    _priceLabel.numberOfLines = 0;
    [_priceBackgroundView addSubview:_priceLabel];

    _commissionTagView = [ProductSaleTagView new];
    _commissionTagView.fontSize = 12 * HOME_IPHONE6_HEIGHT;
    _commissionTagView.height = 19 * HOME_IPHONE6_HEIGHT;
    [_priceBackgroundView addSubview:_commissionTagView];

}

- (void)settingAutoLayout{
    
    [_cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(self.contentView).offset(20 * HOME_IPHONE6_HEIGHT);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20 * HOME_IPHONE6_HEIGHT);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellBackgroundView);
        make.left.right.equalTo(_cellBackgroundView);
    }];
    
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel).offset(3 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(_titleLabel);
        make.size.mas_equalTo(CGSizeMake(22.5 * HOME_IPHONE6_WIDTH, 15 * HOME_IPHONE6_HEIGHT));
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_flagImageView.mas_right).offset(10 * HOME_IPHONE6_WIDTH);
        make.centerY.equalTo(_flagImageView);
        make.size.mas_equalTo(CGSizeMake(55 * HOME_IPHONE6_WIDTH, 16 * HOME_IPHONE6_HEIGHT));
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10 * HOME_IPHONE6_HEIGHT);
        make.centerX.equalTo(_cellBackgroundView);
    }];
    
    [_specialBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subtitleLabel.mas_bottom).offset(10 * HOME_IPHONE6_HEIGHT);
        make.centerX.equalTo(_cellBackgroundView);
        make.width.mas_equalTo(230 * HOME_IPHONE6_WIDTH);
        make.height.mas_equalTo(70 * HOME_IPHONE6_HEIGHT);
        make.bottom.equalTo(_cellBackgroundView);
    }];
    
    [_priceBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(_specialBGImageView);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceBackgroundView);
        make.left.equalTo(_priceBackgroundView);
    }];
    
    [_commissionTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.mas_right).offset(6);
        make.centerY.equalTo(_priceBackgroundView);
        make.right.equalTo(_priceBackgroundView);
    }];


}


#pragma mark -更新数据
- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    [self updateProductInfomationTableViewCellDataWithModel:_productDetailModel];
}

// 更新数据
- (void)updateProductInfomationTableViewCellDataWithModel:(ProductDetailModel *)model{
    
    NSString *haiTaotemp = [self loadingTempStringWithIsHaiTao:model.item.isHaiTao];
    _titleLabel.text = [NSString stringWithFormat:@"%@%@", haiTaotemp, model.item.productTitle];
    _subtitleLabel.text = @"本商品为预售商品";
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f", model.item.price];
    _commissionTagView.title = [NSString stringWithFormat:@"赚¥%.2f", model.commission];
    [_flagImageView sd_setImageWithURL:[NSURL URLWithString:model.item.brandImage]];
    
    // 特卖
    if (model.isSpecialSell) {
        _commissionTagView.textColor = [UIColor whiteColor];
        _commissionTagView.borderColor = [UIColor whiteColor];
        [ProductConstant setRichSignNumberWithLabel:_priceLabel
                                            BigSize:22 * HOME_IPHONE6_HEIGHT
                                          SmallSize:14 * HOME_IPHONE6_HEIGHT
                                              Color:[UIColor whiteColor]];
    }else{
        _commissionTagView.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
        _commissionTagView.borderColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
        [ProductConstant setRichSignNumberWithLabel:_priceLabel
                                            BigSize:22 * HOME_IPHONE6_HEIGHT
                                          SmallSize:14 * HOME_IPHONE6_HEIGHT
                                              Color:[UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00]];
    }
    _specialBGImageView.image = model.isSpecialSell ? [UIImage imageNamed:@"productDetailTag@2x.png"] : nil;
    
    // 海淘
    _flagImageView.hidden = model.item.isHaiTao ? NO : YES;
    _tagLabel.hidden = model.item.isHaiTao ? NO : YES;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 空字符
- (NSString *)loadingTempStringWithIsHaiTao:(BOOL)isHaiTao{
    NSInteger count = 0;
    NSString *temp = @"";
    if (isHaiTao) {
        count = 22;
    }
    for (NSInteger i = 0; i < count; i++) {
        temp = [temp stringByAppendingString:@" "];
    }
    return temp;
}




@end
