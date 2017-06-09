//
//  ProductDetailModel.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/5.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shop;
@class ProductDeatilParam;
@class SkuList;
@class Value;
@class Recommend;
@class SkuCommission;
@class Item;
@class TagSkus;
@class TagMap;

@interface ProductDetailModel : NSObject
@property (nonatomic, strong) Shop *shop;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *pageName;
@property (nonatomic, strong) NSDictionary *productDeatilParam;
@property (nonatomic, assign) BOOL showCommission;
@property (nonatomic, assign) NSInteger commentsNum;
@property (nonatomic, strong) NSArray<SkuList *> *skuList;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL addCart;
@property (nonatomic, assign) NSInteger shopProductId;
@property (nonatomic, strong) NSArray<Recommend *> *recommend;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) SkuCommission *skuCommission;
@property (nonatomic, assign) BOOL isFromHome;
@property (nonatomic, strong) NSString *byStages;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, assign) BOOL isSpecialSell;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) NSArray<TagSkus *> *tagSkus;
@property (nonatomic, assign) CGFloat commission;
@end

@interface Shop : NSObject
@property (nonatomic, assign) NSInteger gmtCreate;
@property (nonatomic, assign) NSInteger gmtModified;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) BOOL isProbation;
@property (nonatomic, assign) NSInteger isVip;
@property (nonatomic, assign) NSInteger membersCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, assign) NSInteger payOrderId;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger vipShopId;
@end

@interface ProductDeatilParam : NSObject

@end

@interface SkuList : NSObject
@property (nonatomic, strong) NSString *classify;
@property (nonatomic, strong)  NSArray<Value *> *value;
@end

@interface Value : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger skuId;
@end

@interface Recommend : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *discount;
@end

@interface SkuCommission : NSObject
@property (nonatomic, assign) CGFloat actPrice;
@property (nonatomic, assign) CGFloat commissionRate;
@property (nonatomic, assign) NSInteger endTime;
@property (nonatomic, assign) NSInteger gmtCreate;
@property (nonatomic, assign) NSInteger gmtModified;
@property (nonatomic, assign) NSInteger isDelete;
@property (nonatomic, assign) NSInteger limitCommissionRate;
@property (nonatomic, assign) NSInteger limitInventory;
@property (nonatomic, assign) NSInteger skuId;
@property (nonatomic, assign) BOOL specialSell;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) NSInteger type;
@end

@interface Item : NSObject
@property (nonatomic, strong) NSString *zhName;
@property (nonatomic, assign) NSInteger spuId;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat originalPrice;
@property (nonatomic, assign) NSInteger inventory;
@property (nonatomic, strong) NSString *productTitle;
@property (nonatomic, assign) NSInteger volume;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) BOOL isHaiTao;
@property (nonatomic, strong) NSString *brandImage;
@property (nonatomic, strong) NSString *introduction;
@end

@interface TagSkus : NSObject
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger inventory;
@property (nonatomic, assign) BOOL isCanSelect;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) TagMap *tagMaps;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, assign) NSInteger volume;
@end

@interface TagMap : NSObject

@end
