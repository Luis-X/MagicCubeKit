//
//  ProductOptionTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductOptionTableViewCell.h"

@implementation ProductOptionTableViewCell{
    UILabel *_arrowIcon;                //箭头
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
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
//    _titleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel = [UILabel new];
    _subTitleLabel.textColor = [UIColor blackColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:14];
//    _subTitleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_subTitleLabel];
    
    _saleTagView = [ProductSaleTagView new];
    [self.contentView addSubview:_saleTagView];
    
    _arrowIcon = [UILabel new];
    _arrowIcon.font = [UIFont fontWithName:@"iconfont" size:15];
    _arrowIcon.text = @"\U0000e64e";
    _arrowIcon.textColor = [UIColor grayColor];
//    _arrowIcon.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_arrowIcon];

}

- (void)settingAutoLayout{
    
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(_titleLabel.mas_right).offset(10);
    }];
    
    [_saleTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(_subTitleLabel.mas_right).offset(10);
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
