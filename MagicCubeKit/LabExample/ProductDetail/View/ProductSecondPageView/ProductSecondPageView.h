//
//  ProductSecondPageView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/22.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductConstant.h"
#import "ProductDetailModel.h"
@interface ProductSecondPageView : UIScrollView
@property (nonatomic, strong) ProductDetailModel *productDetailModel;
@end
