//
//  ProductSpecialTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/6.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSpecialTableViewCell.h"

@implementation ProductSpecialTableViewCell{
    UIView *_cellBackgroundView;     //背景
    UIButton *_tagButton;            //标签
    UILabel *_messageLabel;          //信息
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
    _cellBackgroundView.backgroundColor = [UIColor colorWithRed:0.93 green:0.45 blue:0.48 alpha:1.00];
    [self.contentView addSubview:_cellBackgroundView];

    
    _tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tagButton setTitle:@"限时特卖" forState:UIControlStateNormal];
    [_tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _tagButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _tagButton.layer.masksToBounds = YES;
    _tagButton.layer.cornerRadius = 26 / 2;
    _tagButton.backgroundColor = [UIColor flatRedColor];
    [_cellBackgroundView addSubview:_tagButton];

    
    _messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.text = [NSString stringWithFormat:@"距离结束 %@", [[NSDate date] formattedDateWithFormat:@"YYYY-MM-dd HH:mm:ss"] ];
    _messageLabel.adjustsFontSizeToFitWidth = YES;
    //_messageLabel.backgroundColor = [UIColor redColor];
    [_cellBackgroundView addSubview:_messageLabel];
    
}

- (void)settingAutoLayout{
    
    [_cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
    [_tagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cellBackgroundView).offset(15);
        make.size.mas_equalTo(CGSizeMake(69, 26 ));
        make.centerY.equalTo(_cellBackgroundView);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tagButton);
        make.left.greaterThanOrEqualTo(_tagButton.mas_right).offset(5);
        make.right.equalTo(_cellBackgroundView).offset(-15);
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
