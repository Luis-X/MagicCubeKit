//
//  ProductSelectCollectionViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
@interface ProductSelectCollectionViewCell : UICollectionViewCell
- (void)updateCellDataWithValueModel:(Value *)valueModel selectedSkuId:(NSInteger)selectedSkuId;
@end
