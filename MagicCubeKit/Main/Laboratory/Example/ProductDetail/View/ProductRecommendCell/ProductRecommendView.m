//
//  ProductRecommendView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductRecommendView.h"
#import "ProductRecommendCollectionViewCell.h"
@implementation ProductRecommendView{
    UICollectionView *_mainRecommendCollectionView;
    NSMutableArray *_allModelDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    [self createRecommendCollectionView];
}

/**
 商品推荐
 */
- (void)createRecommendCollectionView{
    
    UILabel *recommendLabel = [UILabel new];
    recommendLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    recommendLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    recommendLabel.text = @"更多推荐";
    [self addSubview:recommendLabel];
    [recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(self).offset(10 * HOME_IPHONE6_WIDTH);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5 * HOME_IPHONE6_WIDTH;
    layout.itemSize = CGSizeMake(105 * HOME_IPHONE6_WIDTH, 170 * HOME_IPHONE6_HEIGHT);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _mainRecommendCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _mainRecommendCollectionView.backgroundColor = [UIColor whiteColor];
    _mainRecommendCollectionView.dataSource = self;
    _mainRecommendCollectionView.delegate = self;
    [self addSubview:_mainRecommendCollectionView];
    [_mainRecommendCollectionView registerClass:[ProductRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
    //更新高度
    [_mainRecommendCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(170 * HOME_IPHONE6_HEIGHT);
        make.top.equalTo(recommendLabel.mas_bottom).offset(15 * HOME_IPHONE6_HEIGHT);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        
    }];
    
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _allModelDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.recommendModel = [_allModelDataArray objectAtIndex:indexPath.row];
    return cell;
    
}
#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Recommend *recommendModel = [_allModelDataArray objectAtIndex:indexPath.row];
    [self executeProductRecommendViewSelectedSkuId:recommendModel.ID];
}


#pragma mark -更新数据
- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    
    _allModelDataArray = [NSMutableArray arrayWithArray:_productDetailModel.recommend];
    [_mainRecommendCollectionView reloadData];
    
}

/**
 执行代理方法
 */
- (void)executeProductRecommendViewSelectedSkuId:(NSInteger)skuId{
    
    if ([self.myDelegate respondsToSelector:@selector(productRecommendViewSelectedSkuId:)]) {
        [self.myDelegate productRecommendViewSelectedSkuId:skuId];
    }
    
}
@end
