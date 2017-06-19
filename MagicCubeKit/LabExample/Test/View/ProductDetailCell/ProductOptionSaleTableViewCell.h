//
//  ProductOptionSaleTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductOptionSaleTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *salesArray; // 控件个数
@property (nonatomic, assign) BOOL      flag;      // 控制标签
@end
