//
//  ProductSpecialTimeView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

@interface ProductSpecialTimeView : UIView
@property (nonatomic, strong)ProductDetailModel *productDetailModel;
- (void)recoverProductSpecialTimeStyleNone;
@end