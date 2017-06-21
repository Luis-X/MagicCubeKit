//
//  ProductPromiseTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductPromiseTableViewCell.h"

@implementation ProductPromiseTableViewCell{
    UILabel *_titleLabel;
    UIView *_leftLine;
    UIView *_rightLine;
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
    _titleLabel.text = @"达人店为您承诺";
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    [self.contentView addSubview:_titleLabel];
    
    _leftLine = [UIView new];
    _leftLine.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    [self.contentView addSubview:_leftLine];
    
    _rightLine = [UIView new];
    _rightLine.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    [self.contentView addSubview:_rightLine];


    [self createMenuButtonWithTitles:@[@"PICC承保", @"正品保障", @"假一赔十", @"90天无理由退货"]
                               Icons:@[@"\U0000e6ef", @"\U0000e6e9", @"\U0000e6ed", @"\U0000e6eb"]
                              Height:70 * HOME_IPHONE6_HEIGHT
                        ContentWidth:Magic_screen_Width
                         BoundsSpace:15 * HOME_IPHONE6_WIDTH];

}

/**
 多功能按钮
 
 @param titles          标题
 @param icons           图标
 @param height          按钮高度
 @param contentWidth    视图总宽度
 @param boundsSpace     视图边界距离
 */
- (void)createMenuButtonWithTitles:(NSArray *)titles Icons:(NSArray *)icons Height:(CGFloat)height ContentWidth:(CGFloat)contentWidth BoundsSpace:(CGFloat)boundsSpace{
    
    if (titles.count != icons.count) {//拦截数组不一致
        return;
    }
    NSInteger itemNum = titles.count;
    double button_width = (contentWidth - (2 * boundsSpace)) / itemNum;
    
    for (NSInteger i = 0; i < itemNum; i++) {
        
        UIView *button = [UIView new];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(boundsSpace + button_width * i);
            make.size.mas_equalTo(CGSizeMake(button_width, height));
            make.top.equalTo(_titleLabel.mas_bottom).offset(25 * HOME_IPHONE6_HEIGHT);
            make.bottom.equalTo(self.contentView).offset(-25 * HOME_IPHONE6_WIDTH);
        }];
        
        UILabel *iconLabel = [UILabel new];
        iconLabel.text = [icons objectAtIndex:i];
        iconLabel.font = [UIFont fontWithName:@"iconfont" size:22 * HOME_IPHONE6_HEIGHT];
        iconLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
        iconLabel.textAlignment = NSTextAlignmentCenter;
        [iconLabel jm_setImageWithCornerRadius:(45 / 2) * HOME_IPHONE6_HEIGHT borderColor:[UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00] borderWidth:0.5 backgroundColor:[UIColor clearColor]];
        [button addSubview:iconLabel];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45 * HOME_IPHONE6_HEIGHT, 45 * HOME_IPHONE6_HEIGHT));
            make.top.equalTo(button);
            make.centerX.equalTo(button);
        }];
        
        UILabel *textLabel = [UILabel new];
        textLabel.text = [titles objectAtIndex:i];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
        textLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
        [button addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(button);
        }];
    }
    
}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(25 * HOME_IPHONE6_HEIGHT);
        make.centerX.equalTo(self.contentView);
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50 * HOME_IPHONE6_WIDTH, 0.5));
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(_titleLabel.mas_left).offset(-10 * HOME_IPHONE6_WIDTH);
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50 * HOME_IPHONE6_WIDTH, 0.5));
        make.centerY.equalTo(_titleLabel);
        make.left.equalTo(_titleLabel.mas_right).offset(10 * HOME_IPHONE6_WIDTH);
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
