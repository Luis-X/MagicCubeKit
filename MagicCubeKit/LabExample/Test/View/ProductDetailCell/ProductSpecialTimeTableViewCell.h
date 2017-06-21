//
//  ProductSpecialTimeTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

typedef enum : NSUInteger {
    ProductSpecialTimeStyleNone,        //无效
    ProductSpecialTimeStyleDay,         //按天数
    ProductSpecialTimeStyleHour,        //按小时
} ProductSpecialTimeStyle;

typedef enum : NSUInteger {
    ProductSpecialTimeStatusSaleStart,  //未开始
    ProductSpecialTimeStatusSaleing,    //进行中
    ProductSpecialTimeStatusSaleEnd,    //已结束
} ProductSpecialTimeStatus;

@protocol ProductSpecialTimeTableViewCellDelegate <NSObject>

- (void)productSpecialTimeTableViewCellCurrentTimerStatus:(ProductSpecialTimeStatus)status;

@end

@interface ProductSpecialTimeTableViewCell : UITableViewCell
@property (nonatomic, assign)BOOL m_isDisplayed;
@property (nonatomic, strong)ProductDetailModel *productDetailModel;
@property (nonatomic, weak) id <ProductSpecialTimeTableViewCellDelegate> delegate;
@end
