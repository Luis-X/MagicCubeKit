//
//  ProductInfomationTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

@interface ProductInfomationTableViewCell : UITableViewCell
@property (nonatomic, strong)ProductDetailModel *productDetailModel;
@property (nonatomic, assign)BOOL m_isDisplayed;
@end
