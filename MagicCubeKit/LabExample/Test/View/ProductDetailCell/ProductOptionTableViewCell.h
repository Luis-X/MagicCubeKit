//
//  ProductOptionTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductConstant.h"
#import "ProductDetailModel.h"

@interface ProductOptionTableViewCell : UITableViewCell
@property (nonatomic, strong)ProductDetailModel *productDetailModel;
@end
