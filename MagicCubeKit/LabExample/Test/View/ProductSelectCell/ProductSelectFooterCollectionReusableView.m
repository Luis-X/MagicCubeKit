//
//  ProductSelectFooterCollectionReusableView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSelectFooterCollectionReusableView.h"
#import "ProductSelectQuantityView.h"

@implementation ProductSelectFooterCollectionReusableView{
    UILabel *_titleLabel;
    ProductSelectQuantityView *_quantityStepView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)createSubViews{
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"数量";
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    _quantityStepView = [ProductSelectQuantityView new];
    _quantityStepView.currentNum = 1;
    _quantityStepView.miniValue = 0;
    _quantityStepView.maxValue = 3;
    _quantityStepView.inputEnabled = YES;
    [self addSubview:_quantityStepView];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];

}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
    }];
    
    [_quantityStepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 28));
    }];
    
}

- (void)tap{
    [_quantityStepView hiddenKeyboard];
    NSLog(@"%ld", _quantityStepView.currentNum);
}

@end
