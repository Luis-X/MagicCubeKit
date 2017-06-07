//
//  ProductSaleTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSaleTableViewCell.h"

@implementation ProductSaleTableViewCell{
    UILabel *_titleLabel;           //标题
    UILabel *_subTitleLabel;        //副标题
    UILabel *_tagLabel;             //标签
    UILabel *_arrowIcon;            //箭头
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
    
    _tagLabel = [UILabel new];
    _tagLabel.text = [NSString stringWithFormat:@"  %@  ", @"促销标签"];
    _tagLabel.textColor = [UIColor flatRedColor];
    _tagLabel.font = [UIFont systemFontOfSize:10];
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.cornerRadius = 3;
    _tagLabel.layer.borderColor = _tagLabel.textColor.CGColor;
    _tagLabel.layer.borderWidth = 1;
    //    _tagLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_tagLabel];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"促销活动名称";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    //    _titleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel = [UILabel new];
    _subTitleLabel.text = @"查看活动";
    _subTitleLabel.textColor = [UIColor blackColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:15];
    //    _subTitleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_subTitleLabel];
    
    _arrowIcon = [UILabel new];
    _arrowIcon.font = [UIFont fontWithName:@"iconfont" size:20];
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
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.right.equalTo(_arrowIcon.mas_left).offset(-10);
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(_tagLabel.mas_right).offset(10);
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
