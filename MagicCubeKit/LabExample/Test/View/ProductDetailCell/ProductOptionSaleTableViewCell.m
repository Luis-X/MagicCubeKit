//
//  ProductOptionSaleTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductOptionSaleTableViewCell.h"
#import "ProductSaleTagView.h"

@implementation ProductOptionSaleTableViewCell{
    UILabel *_arrowIcon;                //箭头
    UILabel *_messageLabel;             //副标题
    ProductSaleTagView *_saleTagView;   //标签
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
    
    _messageLabel = [UILabel new];
    _messageLabel.text = @"只需要199元可享三件商品";
    _messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _messageLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_messageLabel];
    
    _saleTagView = [ProductSaleTagView new];
    _saleTagView.title = @"3件199元";
    _saleTagView.fontSize = 12;
    _saleTagView.height = 18;
    [self.contentView addSubview:_saleTagView];
    
    _arrowIcon = [UILabel new];
    _arrowIcon.font = [UIFont fontWithName:@"iconfont" size:10];
    _arrowIcon.text = @"\U0000e64e";
    _arrowIcon.textColor = [UIColor grayColor];
    [self.contentView addSubview:_arrowIcon];
    
}

- (void)settingAutoLayout{
    
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(18);
        make.bottom.equalTo(self.contentView).offset(-18);
    }];
    
    [_saleTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(_saleTagView.mas_right).offset(5);
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
