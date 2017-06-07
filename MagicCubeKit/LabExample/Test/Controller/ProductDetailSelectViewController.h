//
//  ProductDetailSelectViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDetailModel.h"
@protocol ProductDetailSelectViewControllerDelegate <NSObject>

- (void)productDetailSelectCloseActionWithValue:(id)value;

@end

@interface ProductDetailSelectViewController : BaseViewController
@property (nonatomic, assign) id <ProductDetailSelectViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *allSkuListModelArray;                    //数据
@end
