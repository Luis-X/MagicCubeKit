//
//  ProductSelectCollectionViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSelectCollectionViewCell.h"

@implementation ProductSelectCollectionViewCell{
    UILabel *_titleLabel;
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
    _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.layer.borderWidth = 0.5;
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.layer.cornerRadius = 15;
    [self.contentView addSubview:_titleLabel];
    
}

- (void)settingAutoLayout{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
}



/**
 更新数据

 */
- (void)updateCellDataWithValueModel:(Value *)valueModel selectedSkuId:(NSInteger)selectedSkuId{
    
    NSString *name = [NSString stringWithFormat:@"%@", [valueModel.mj_keyValues objectForKey:@"name"]];
    NSInteger skuId = [[valueModel.mj_keyValues objectForKey:@"skuId"] integerValue];
    
    
    _titleLabel.text = name;
    if (skuId == selectedSkuId) {
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
         _titleLabel.layer.borderColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00].CGColor;
    }else{
        _titleLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
        _titleLabel.backgroundColor = [UIColor clearColor];
         _titleLabel.layer.borderColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00].CGColor;
    }
    
}


@end
