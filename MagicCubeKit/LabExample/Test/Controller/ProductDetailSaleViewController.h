//
//  ProductDetailSaleViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseViewController.h"

@protocol ProductDetailSaleViewControllerDelegate <NSObject>

- (void)productDetailSaleCloseActionWithValue:(id)value;

@end

@interface ProductDetailSaleViewController : BaseViewController
@property (nonatomic, assign) id <ProductDetailSaleViewControllerDelegate> delegate;
@end
