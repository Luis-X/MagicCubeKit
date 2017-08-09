//
//  HomePageModel.h
//  DaRenShop
//
//  Created by LuisX on 2016/9/23.
//  Copyright © 2016年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Skus;
@class SaleInfo;

@interface HomePageModel : NSObject
@property (nonatomic, copy) NSString *day;
@property (nonatomic, strong) NSArray<Skus *> *skus;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, assign) NSInteger index;  //默认时段index
@property (nonatomic, strong) NSArray *times;   //所有时段
@end

@interface Skus : NSObject
@property (nonatomic, assign) NSInteger actPrice;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, assign) CGFloat commission;
@property (nonatomic, assign) CGFloat commissionRate;
@property (nonatomic, assign) long long endTime;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) NSInteger inventory;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) NSInteger limitCommissionRate;
@property (nonatomic, assign) NSInteger limitInventory;
@property (nonatomic, assign) CGFloat originalPrice;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat shelvesCount;
@property (nonatomic, assign) CGFloat shopPrice;
@property (nonatomic, copy) NSString *skuId;
@property (nonatomic, copy) NSString *skuName;
@property (nonatomic, assign) long long startTime;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger tagType;        //判断标签类型 (1:未开抢 -1:已结束 2:抢购中)
@property (nonatomic, strong) SaleInfo *saleInfo;
@end

@interface SaleInfo : NSObject
@property (nonatomic, assign) long long endTime;        //特卖结束时间
@property (nonatomic, assign) CGFloat price;            //特卖价格
@property (nonatomic, assign) long long startTime;      //特卖开始时间
@end
