//
//  ProductOptionTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductOptionTableViewCell.h"

@implementation ProductOptionTableViewCell{
    UILabel *_titleLabel;               //标题
    UILabel *_subtitleLabel;            //副标题
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
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    [self.contentView addSubview:_titleLabel];
    
    _subtitleLabel = [UILabel new];
    _subtitleLabel.textColor = [UIColor colorWithRed:0.10 green:0.07 blue:0.06 alpha:1.00];
    _subtitleLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    [self.contentView addSubview:_subtitleLabel];
    
    _arrowIcon = [UILabel new];
    _arrowIcon.font = [UIFont fontWithName:@"iconfont" size:10 * HOME_IPHONE6_HEIGHT];
    _arrowIcon.text = @"\U0000e64e";
    _arrowIcon.textColor = [UIColor grayColor];
    _arrowIcon.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_arrowIcon];

}

- (void)settingAutoLayout{
    
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15 * HOME_IPHONE6_WIDTH);
        make.centerY.equalTo(self.contentView);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(self.contentView).offset(10 * HOME_IPHONE6_WIDTH);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_arrowIcon);
        make.left.equalTo(_titleLabel.mas_right).offset(10 * HOME_IPHONE6_WIDTH);
        make.right.lessThanOrEqualTo(_arrowIcon.mas_left).offset(-10 * HOME_IPHONE6_WIDTH);
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
    
    [self checkSelectedInfomationWithModel:_productDetailModel];
}

/**
 检查选中信息
 */
- (void)checkSelectedInfomationWithModel:(ProductDetailModel *)model{
    
    NSString *showString = [NSString string];
    for (ProductSkuList *skuListModel in model.skuList) {
        for (ProductValue *valueModel in skuListModel.value) {
            NSString *name = [NSString stringWithFormat:@"%@", [valueModel.mj_keyValues objectForKey:@"name"]];
            NSInteger skuId = [[valueModel.mj_keyValues objectForKey:@"skuId"] integerValue];
            if (skuId == model.item.ID) {
                showString = [showString stringByAppendingString:[NSString stringWithFormat:@"%@，", name]];
            }
        }
    }
    //去处"，"符号
    if (showString.length) {
        if ([[showString substringFromIndex:showString.length - 1] isEqualToString:@"，"]) {
            showString = [showString substringToIndex:showString.length - 1];
        }
        
        _titleLabel.text = @"已选";
        _subtitleLabel.text = showString;
    }else{
        _titleLabel.text = @"选择规格";
    }

}
@end
