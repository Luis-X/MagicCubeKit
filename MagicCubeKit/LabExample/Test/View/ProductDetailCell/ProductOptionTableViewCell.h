//
//  ProductOptionTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSaleTagView.h"
@interface ProductOptionTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;               //标题
@property (nonatomic, strong) UILabel *subTitleLabel;            //副标题
@property (nonatomic, strong) ProductSaleTagView *saleTagView;   //标签
@end
