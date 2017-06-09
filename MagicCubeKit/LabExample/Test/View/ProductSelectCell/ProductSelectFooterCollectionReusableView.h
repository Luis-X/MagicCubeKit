//
//  ProductSelectFooterCollectionReusableView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

@protocol ProductSelectFooterCollectionReusableViewDelegate <NSObject>

- (void)productSelectFooterCollectionReusableViewSelectedNumber:(NSInteger)selectedNumber;        //选择数量

@end

@interface ProductSelectFooterCollectionReusableView : UICollectionReusableView
@property (nonatomic, assign)id <ProductSelectFooterCollectionReusableViewDelegate> delegate;
- (void)updateFooterDataWithProductDetailModel:(ProductDetailModel *)productDetailModel selectedNumber:(NSInteger)selectedNumber;
@end
