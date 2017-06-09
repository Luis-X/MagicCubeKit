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
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    
    
    _quantityStepView = [ProductSelectQuantityView new];
    _quantityStepView.inputEnabled = YES;
    _quantityStepView.delegate = self;
    [self addSubview:_quantityStepView];

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
