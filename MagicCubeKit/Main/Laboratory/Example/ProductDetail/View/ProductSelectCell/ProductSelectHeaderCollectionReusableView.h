//
//  ProductSelectHeaderCollectionReusableView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductConstant.h"
#import "ProductDetailModel.h"
@interface ProductSelectHeaderCollectionReusableView : UICollectionReusableView
- (void)updateHeaderDataWithSkuListModel:(ProductSkuList *)skuListModel;
@end
