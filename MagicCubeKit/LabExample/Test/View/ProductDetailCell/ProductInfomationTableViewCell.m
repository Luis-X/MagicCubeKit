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
    UIImageView *_flagIcon;                     //标识
    UILabel *_titleLabel;                       //标题
    UILabel *_priceLabel;                       //价格
    UIView  *_priceBackgroundView;              //价格背景
    UILabel *_originalPriceLabel;               //原价
    ProductSaleTagView *_commissionTagView;     //佣金
    ProductSaleTagView *_byStagesTagView;       //分期
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
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#1A1210"];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    _flagIcon = [UIImageView new];
    [_flagIcon setImage:[UIImage imageNamed:@"1.jpg"]];
    _flagIcon.clipsToBounds = YES;
    _flagIcon.contentMode = 1;
    [self.contentView addSubview:_flagIcon];
    
    _priceBackgroundView = [UIView new];
    _priceBackgroundView.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    [self.contentView addSubview:_priceBackgroundView];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont boldSystemFontOfSize:22];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.numberOfLines = 0;
    [_priceBackgroundView addSubview:_priceLabel];

    _commissionTagView = [ProductSaleTagView new];
    _commissionTagView.fontSize = 12;
    _commissionTagView.height = 19;
    _commissionTagView.textColor = [UIColor whiteColor];
    _commissionTagView.borderColor = [UIColor whiteColor];
    [_priceBackgroundView addSubview:_commissionTagView];
    
    _originalPriceLabel = [UILabel new];
    _originalPriceLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
    _originalPriceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_originalPriceLabel];
    
    //删除线
    UIView *deleteLine = [UIView new];
    deleteLine.backgroundColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
    [_originalPriceLabel addSubview:deleteLine];
    [deleteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_originalPriceLabel);
        make.left.equalTo(_originalPriceLabel).offset(-2);
        make.right.equalTo(_originalPriceLabel).offset(2);
        make.height.mas_equalTo(1);
    }];
    
    _byStagesTagView = [ProductSaleTagView new];
    _byStagesTagView.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    _byStagesTagView.fontSize = 10;
    _byStagesTagView.height = 23;
    _byStagesTagView.borderColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    _byStagesTagView.bgColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self.contentView addSubview:_byStagesTagView];
}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(Magic_screen_Width - 20);
    }];
    
    [_flagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_titleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    
    [_priceBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceBackgroundView);
        make.left.equalTo(_priceBackgroundView).offset(30);
    }];
    
    [_commissionTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.mas_right).offset(6);
        make.centerY.equalTo(_priceBackgroundView);
        make.right.equalTo(_priceBackgroundView).offset(-30);
    }];
    
//    [_originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_priceLabel);
//        make.top.equalTo(_priceLabel.mas_bottom).offset(10);
//    }];
    
    [_byStagesTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_priceBackgroundView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
}


#pragma mark -更新数据
- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    
    NSString *temp = [NSString string];
    for (NSInteger i = 0; i < 5; i++) {
        temp = [temp stringByAppendingString:@" "];
    }
    _titleLabel.text = [NSString stringWithFormat:@"%@ %@", temp, _productDetailModel.item.productTitle];
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f", _productDetailModel.item.price];
    _commissionTagView.title = [NSString stringWithFormat:@"赚:¥%.2f", _productDetailModel.commission];
    _byStagesTagView.title = [NSString stringWithFormat:@"%@", _productDetailModel.byStages];
    _originalPriceLabel.text = [NSString stringWithFormat:@"¥%.2f", _productDetailModel.item.originalPrice];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
