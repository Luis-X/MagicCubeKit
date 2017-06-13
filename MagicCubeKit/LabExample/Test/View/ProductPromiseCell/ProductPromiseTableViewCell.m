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
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];


    [self createMenuButtonWithTitles:@[@"PICC承保", @"正品保障", @"假一赔十", @"90天无理由退货"]
                               Icons:@[@"\U0000e659", @"\U0000e659", @"\U0000e659", @"\U0000e659"]
                              Height:70
                        ContentWidth:Magic_screen_Width
                         BoundsSpace:15];

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
            make.top.equalTo(_titleLabel.mas_bottom).offset(25);
            make.bottom.equalTo(self.contentView).offset(-25);
        }];
        
        UILabel *iconLabel = [UILabel new];
        iconLabel.text = [icons objectAtIndex:i];
        iconLabel.font = [UIFont fontWithName:@"iconfont" size:16];
        iconLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
        iconLabel.textAlignment = NSTextAlignmentCenter;
        iconLabel.layer.masksToBounds = YES;
        iconLabel.layer.cornerRadius = 45 / 2;
        iconLabel.layer.borderWidth = 0.5;
        iconLabel.layer.borderColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00].CGColor;
        [button addSubview:iconLabel];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.top.equalTo(button);
            make.centerX.equalTo(button);
        }];
        
        UILabel *textLabel = [UILabel new];
        textLabel.text = [titles objectAtIndex:i];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
        [button addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(button);
        }];
    }
    
}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(25);
        make.centerX.equalTo(self.contentView);
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
