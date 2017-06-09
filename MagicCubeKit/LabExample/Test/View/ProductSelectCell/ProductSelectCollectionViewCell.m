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
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.layer.borderWidth = 0.5;
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.layer.cornerRadius = 4;
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
        _titleLabel.layer.borderColor = [UIColor colorWithHexString:@"#F03337"].CGColor;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#F03337"];
    }else{
        _titleLabel.layer.borderColor = [UIColor colorWithHexString:@"#000000"].CGColor;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    
}


@end
