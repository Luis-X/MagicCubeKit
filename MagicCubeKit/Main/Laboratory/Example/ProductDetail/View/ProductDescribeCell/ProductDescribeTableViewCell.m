//
//  ProductDescribeTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductDescribeTableViewCell.h"

@implementation ProductDescribeTableViewCell{
    UIImageView *_logoImageView;
    UILabel *_titleLabel;
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
    
    _logoImageView = [UIImageView new];
    [self.contentView addSubview:_logoImageView];
      [_logoImageView setImage:[UIImage imageNamed:@"productDetailLogo@2x.png"]];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"达人店为您精选";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    [self.contentView addSubview:_titleLabel];
    
    _messageLabel = [UILabel new];
    _messageLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1.00];
    _messageLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    [self.contentView addSubview:_messageLabel];
    
}

- (void)settingAutoLayout{
   
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(25 * HOME_IPHONE6_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(40 * HOME_IPHONE6_HEIGHT, 40 * HOME_IPHONE6_HEIGHT));
        make.centerX.equalTo(self.contentView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView.mas_bottom).offset(10 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(self.contentView).offset(10 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(self.contentView).offset(-10 * HOME_IPHONE6_WIDTH);
        make.height.mas_equalTo(15 * HOME_IPHONE6_HEIGHT);
    }];

    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(self.contentView).offset(-30 * HOME_IPHONE6_WIDTH);
        make.top.equalTo(_titleLabel.mas_bottom).offset(15 * HOME_IPHONE6_HEIGHT);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-15 * HOME_IPHONE6_HEIGHT);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    _messageLabel.text = [NSString stringWithFormat:@"%@", _productDetailModel.item.introduction];

}

@end
