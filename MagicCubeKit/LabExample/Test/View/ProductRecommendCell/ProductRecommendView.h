//
//  ProductRecommendView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductConstant.h"
#import "ProductDetailModel.h"

@protocol ProductRecommendViewDelegate <NSObject>

- (void)productRecommendViewSelectedSkuId:(NSInteger)skuId;

@end

@interface ProductRecommendView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) ProductDetailModel *productDetailModel;
@property (nonatomic, weak) id <ProductRecommendViewDelegate> myDelegate;
@end
