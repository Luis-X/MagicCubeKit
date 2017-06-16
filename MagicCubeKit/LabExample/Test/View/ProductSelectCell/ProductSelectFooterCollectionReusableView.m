//
//  ProductSelectFooterCollectionReusableView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSelectFooterCollectionReusableView.h"
#import "ProductSelectQuantityView.h"

@interface ProductSelectFooterCollectionReusableView ()<ProductSelectQuantityViewDelegate>

@end

@implementation ProductSelectFooterCollectionReusableView{
    UILabel *_titleLabel;
    UILabel *_subtitleLabel;
    ProductSelectQuantityView *_quantityStepView;
    UIView *_topLine;
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
    
    _topLine = [UIView new];
    _topLine.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    [self addSubview:_topLine];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"数量";
    _titleLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    
    _subtitleLabel = [UILabel new];
    _subtitleLabel.text = @"单次限购1件";
    _subtitleLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    _subtitleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_subtitleLabel];
    
    _quantityStepView = [ProductSelectQuantityView new];
    _quantityStepView.inputEnabled = YES;
    _quantityStepView.delegate = self;
    [self addSubview:_quantityStepView];

}

- (void)settingAutoLayout{
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine).offset(25);
        make.left.equalTo(self).offset(10);
    }];
    
    [_quantityStepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(_titleLabel);
        make.size.mas_equalTo(CGSizeMake(130, 30));
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_quantityStepView.mas_left).offset(-10);
        make.centerY.equalTo(_titleLabel);
    }];
    
}


#pragma mark - ProductSelectQuantityViewDelegate
- (void)productSelectQuantityViewUpdateQuantity:(NSInteger)quantity{
    
    if ([self.delegate respondsToSelector:@selector(productSelectFooterCollectionReusableViewSelectedNumber:)]) {
        [self.delegate productSelectFooterCollectionReusableViewSelectedNumber:quantity];
    }
    
}

#pragma mark -Update
- (void)updateFooterDataWithProductDetailModel:(ProductDetailModel *)productDetailModel selectedNumber:(NSInteger)selectedNumber{
    
    _quantityStepView.currentNum = selectedNumber;
    _quantityStepView.miniValue = 1;
    _quantityStepView.maxValue = productDetailModel.item.inventory;
    
}
@end
