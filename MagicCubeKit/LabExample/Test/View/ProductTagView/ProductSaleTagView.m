//
//  ProductSaleTagView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSaleTagView.h"

#define TagFontSize 8
@implementation ProductSaleTagView{
    UILabel *_tagLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)createSubViews{

    _tagLabel = [UILabel new];
    _tagLabel.textColor = [UIColor flatRedColor];
    _tagLabel.font = [UIFont systemFontOfSize:TagFontSize];
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.layer.borderColor = _tagLabel.textColor.CGColor;
    _tagLabel.layer.borderWidth = 0.5;
    [self addSubview:_tagLabel];
    
}

- (void)settingAutoLayout{
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(TagFontSize + 5);
    }];
    
}


#pragma mark -Property
- (void)setTitle:(NSString *)title{
    _title = title;
    
    if (_title.length) {
        _tagLabel.text = _tagLabel.text = [NSString stringWithFormat:@" %@ ", _title];
    }
}

@end
