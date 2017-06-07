//
//  ProductActivityTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/6.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductActivityTableViewCell.h"

@implementation ProductActivityTableViewCell{
    UIImageView *_smallIconView;
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
    
    _smallIconView = [UIImageView new];
    _smallIconView.clipsToBounds = YES;
    _smallIconView.contentMode = 2;
    _smallIconView.userInteractionEnabled = YES;
    [self.contentView addSubview:_smallIconView];
    
}

- (void)settingAutoLayout{
    [_smallIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
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
