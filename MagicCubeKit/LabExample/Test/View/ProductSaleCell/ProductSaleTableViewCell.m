//
//  ProductSaleTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSaleTableViewCell.h"
#import "ProductSaleTagView.h"
@implementation ProductSaleTableViewCell{
    UILabel *_titleLabel;               //标题
    UILabel *_subTitleLabel;            //副标题
    ProductSaleTagView *_saleTagView;   //标签
    UILabel *_arrowIcon;                //箭头
    UIView *_blackLine;                 //分割线
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)createSubViews{
    
    _saleTagView = [ProductSaleTagView new];
    _saleTagView.title = @"3件199元";
    _saleTagView.height = 18;
    _saleTagView.fontSize = 12;
    [self.contentView addSubview:_saleTagView];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"只需要199元可享三件商品";
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel = [UILabel new];
    _subTitleLabel.textColor =  [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _subTitleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_subTitleLabel];
    
    _arrowIcon = [UILabel new];
    _arrowIcon.font = [UIFont fontWithName:@"iconfont" size:10];
    _arrowIcon.text = @"\U0000e64e";
    _arrowIcon.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    [self.contentView addSubview:_arrowIcon];

    _blackLine = [UIView new];
    _blackLine.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    [self.contentView addSubview:_blackLine];

}

- (void)settingAutoLayout{
    
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.right.equalTo(_arrowIcon.mas_left).offset(-10);
    }];
    
    [_saleTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(_saleTagView.mas_right).offset(10);
    }];

    [_blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
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

@end
