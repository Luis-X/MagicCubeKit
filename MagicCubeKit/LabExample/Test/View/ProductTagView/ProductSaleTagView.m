//
//  ProductSaleTagView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#define Tag_Border_Width            0.5      //边框宽度

#import "ProductSaleTagView.h"
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
        [self initialView];
    }
    return self;
}

- (void)initialView{

    _fontSize = 10;
    _height = _fontSize + 5;
    
    [self createSubViews];
    [self settingAutoLayout];
    [self settingTagTextColor:[UIColor colorWithHexString:@"#F63754"]];
    [self settingTagBorderColor:[UIColor colorWithHexString:@"#F63754"]];
    
}

- (void)createSubViews{

    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:_fontSize];
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.borderWidth = Tag_Border_Width;
    _tagLabel.clipsToBounds = YES;
    [self addSubview:_tagLabel];

}

- (void)settingAutoLayout{
    
    [_tagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(_height);
          _tagLabel.layer.cornerRadius = _height / 2;
    }];
    
}

- (void)settingTagTextColor:(UIColor *)color{
    _tagLabel.textColor = color;
}

- (void)settingTagBorderColor:(UIColor *)color{
    _tagLabel.layer.borderColor = color.CGColor;
}

- (void)settingTagBackgroundColor:(UIColor *)color{
    _tagLabel.backgroundColor = color;
}

#pragma mark -Property
- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title.length) {
        _tagLabel.text = _tagLabel.text = [NSString stringWithFormat:@"  %@  ", _title];
    }
}

- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    _tagLabel.font = [UIFont systemFontOfSize:_fontSize];
    [self settingAutoLayout];
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self settingTagTextColor:_textColor];
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self settingTagBorderColor:_borderColor];
}

- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    [self settingTagBackgroundColor:_bgColor];
}

- (void)setHeight:(CGFloat)height{
    _height = height;
    [self settingAutoLayout];
}
@end
