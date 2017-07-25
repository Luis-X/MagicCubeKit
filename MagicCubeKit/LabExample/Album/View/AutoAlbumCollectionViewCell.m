//
//  AutoAlbumCollectionViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/23.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "AutoAlbumCollectionViewCell.h"

@implementation AutoAlbumCollectionViewCell{
    UIImageView *_imageView;
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
    
    _imageView = [UIImageView new];
    //_imageView.backgroundColor = [UIColor grayColor];
    _imageView.contentMode = 2;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
}

- (void)settingAutoLayout{
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
}

- (void)updateCellDataWithValue:(UIImage *)value{
    _imageView.image = value;
}
@end
