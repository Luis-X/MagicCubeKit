//
//  ProductSaleTagView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//
#define Tag_Border_Space            5        //边框间距
#define Tag_Border_CornerRadius     2        //圆角
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
    
    self.backgroundColor = [UIColor whiteColor];
    _fontSize = 10;
    [self createSubViews];
    [self settingAutoLayout];
    [self settingTagColor:[UIColor colorWithHexString:@"#F03337"]];

}

- (void)createSubViews{

    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:_fontSize];
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.cornerRadius = Tag_Border_CornerRadius;
    _tagLabel.layer.borderWidth = Tag_Border_Width;
    [self addSubview:_tagLabel];

}

- (void)settingAutoLayout{
    
    [_tagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(_fontSize + Tag_Border_Space);
    }];
    
}

- (void)settingTagColor:(UIColor *)color{
    
    _tagLabel.textColor = color;
    _tagLabel.layer.borderColor = color.CGColor;
    
}


#pragma mark -Property
- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title.length) {
        _tagLabel.text = _tagLabel.text = [NSString stringWithFormat:@" %@ ", _title];
    }
}

- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    _tagLabel.font = [UIFont systemFontOfSize:_fontSize];
    [self settingAutoLayout];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    [self settingTagColor:_color];
}
@end
