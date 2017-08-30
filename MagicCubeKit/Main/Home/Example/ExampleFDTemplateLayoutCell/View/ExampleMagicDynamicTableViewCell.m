//
//  ExampleMagicDynamicTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicDynamicTableViewCell.h"
#define CELL_VIEW_SPACE 5

@implementation ExampleMagicDynamicTableViewCell{
    UIImageView *_userAvatarImageView;
    UILabel *_userNameLabel;
    UILabel *_userAddressLabel;
    UILabel *_contentTextLabel;
    UIImageView *_contentImageView;
    UILabel *_priceLabel;
    UILabel *_timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}
/**
 *  注意,不管布局多复杂,一定要有相对于cell.contentView的bottom的约束
 */
- (void)createSubViews{
    //底部背景
    UIView *cellBackgroundView = [UIView new];
    [self.contentView addSubview:cellBackgroundView];
    cellBackgroundView.backgroundColor = [UIColor whiteColor];
    [cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    //头像
    _userAvatarImageView = [UIImageView new];
    _userAvatarImageView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _userAvatarImageView.layer.cornerRadius = 44/2;
    _userAvatarImageView.layer.masksToBounds = YES;
    _userAvatarImageView.contentMode = 2;
    _userAvatarImageView.clipsToBounds = YES;
    [self.contentView addSubview:_userAvatarImageView];
    [_userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackgroundView.mas_top).offset(CELL_VIEW_SPACE);
        make.left.equalTo(cellBackgroundView.mas_left).offset(CELL_VIEW_SPACE);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    //名字
    _userNameLabel = [UILabel new];
    //_userNameLabel.backgroundColor = [UIColor cyanColor];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textColor = [UIColor colorWithWhite:0.00 alpha:0.60];
    _userNameLabel.numberOfLines = 0;
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userAvatarImageView.mas_centerY);
        make.left.equalTo(_userAvatarImageView.mas_right).offset(CELL_VIEW_SPACE);
    }];
    
    //价格
    _priceLabel = [UILabel new];
    //_priceLabel.backgroundColor = [UIColor pinkColor];
    _priceLabel.textColor = [UIColor colorWithRed:251/255.0 green:74/255.0 blue:71/255.0 alpha:1];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userAvatarImageView.mas_centerY);
        make.right.equalTo(cellBackgroundView.mas_right).offset(-CELL_VIEW_SPACE);
    }];
    
    //内容
    _contentTextLabel = [UILabel new];
    //_contentTextLabel.backgroundColor = [UIColor cyanColor];
    _contentTextLabel.textColor = [UIColor colorWithWhite:0.00 alpha:0.75];
    _contentTextLabel.font = [UIFont systemFontOfSize:16];
    _contentTextLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentTextLabel];
    [_contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userAvatarImageView.mas_bottom).offset(CELL_VIEW_SPACE);
        make.left.equalTo(_userAvatarImageView);
        make.right.equalTo(_priceLabel);
    }];
    
    
    //图片
    _contentImageView = [UIImageView new];
    _contentImageView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _contentImageView.contentMode = 2;
    _contentImageView.clipsToBounds = YES;
    _contentImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentTextLabel.mas_bottom).offset(CELL_VIEW_SPACE);
        make.left.and.right.equalTo(_contentTextLabel);
        make.height.mas_equalTo(180);
    }];
    
    //地点
    _userAddressLabel = [UILabel new];
    //_userAddressLabel.backgroundColor = [UIColor redColor];
    _userAddressLabel.textColor = [UIColor colorWithWhite:0.00 alpha:0.60];
    _userAddressLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_userAddressLabel];
    [_userAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentImageView.mas_bottom).offset(CELL_VIEW_SPACE);
        make.left.equalTo(_contentImageView);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(cellBackgroundView.mas_bottom).offset(-CELL_VIEW_SPACE);
    }];
    
    //时间
    _timeLabel = [UILabel new];
    //_timeLabel.backgroundColor = [UIColor orangeColor];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userAddressLabel);
        make.right.equalTo(cellBackgroundView).offset(-CELL_VIEW_SPACE);
    }];
}
/**
 *  赋值
 *
 *  @param model ViewController传递过来的Model用来赋值
 */
- (void)setModel:(ExampleMagicDynamicModel *)model{
    if (_model != model) {
        _model = model;
    }
    _userAvatarImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", model.userImage]];
    _userNameLabel.text = [NSString stringWithFormat:@"%@", model.userName];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [model.userID doubleValue]];
    _contentTextLabel.text = model.textContent;
    _userAddressLabel.text = [NSString stringWithFormat:@"来自%@", model.address];
    //需要将工程设置支持国际化语言(NSDateTools包含了)
    NSDate *timeAgoDate = [NSDate dateWithString:[NSString stringWithFormat:@"%@", model.publishTime] formatString:@"yyyy-MM-dd HH:mm:ss"];
    _timeLabel.text = [NSString stringWithFormat:@"%@", timeAgoDate.timeAgoSinceNow];
    [_contentImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", model.imageContent]]];

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
