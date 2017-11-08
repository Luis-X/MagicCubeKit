//
//  ProductDetailModel.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/5.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductSalesPromotion;
@class ProductSkuEnsures;
@class ProductShop;
@class ProductRecommend;
@class ProductSaleInfo;
@class ProductSkuList;
@class ProductValue;
@class ProductSkuCommission;
@class ProductItem;
@class ProductTagSkus;
@class ProductTagMap;

@interface ProductDetailModel : NSObject
@property (nonatomic, strong) NSArray<ProductSkuEnsures *> *skuEnsures; //保险
@property (nonatomic, strong) ProductShop *shop;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSDictionary *productDeatilParam;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) BOOL addCart;
@property (nonatomic, strong) NSArray<ProductRecommend *> *recommend;
@property (nonatomic, assign) NSInteger shopProductId;
@property (nonatomic, assign) BOOL isFromHome;
@property (nonatomic, assign) BOOL isSpecialSell;
@property (nonatomic, assign) BOOL isFreezeSell;
@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, assign) CGFloat commission;
@property (nonatomic, strong) ProductSaleInfo *saleInfo;
@property (nonatomic, copy)   NSString *activityUrl;     //活动链接
@property (nonatomic, copy)   NSString *activityIcon;    //活动图标
@property (nonatomic, copy)   NSString *activityTips;    //活动文案
@property (nonatomic, copy)   NSString *pageName;
@property (nonatomic, copy)   NSString *taxRate;         //税率
@property (nonatomic, assign) NSInteger cartCount;       //购物车数量
@property (nonatomic, assign) NSInteger nowDate;         //当前时间
@property (nonatomic, assign) NSInteger shelveCount;     //上架店主数
@property (nonatomic, assign) NSInteger maxCouponAmount; //优惠券数
@property (nonatomic, assign) BOOL showCommission;
@property (nonatomic, assign) NSInteger commentsNum;
@property (nonatomic, strong) NSArray<ProductSkuList *> *skuList;
@property (nonatomic, copy)   NSString *discount;
@property (nonatomic, strong) ProductSkuCommission *skuCommission;
@property (nonatomic, copy)   NSString *byStages;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy)   NSString *shopName;
@property (nonatomic, strong) ProductItem *item;
@property (nonatomic, strong) NSArray<ProductTagSkus *> *tagSkus;
@property (nonatomic, strong) NSArray<ProductSalesPromotion *> *salesPromotion;
@end

@interface ProductSalesPromotion : NSObject
@property (nonatomic, copy) NSString *salesTitle;
@property (nonatomic, copy) NSString *salesType;
@end

@interface ProductSkuEnsures : NSObject
@property (nonatomic, copy) NSString *zhName;
@property (nonatomic, copy) NSString *picUrl;
@end

@interface ProductSaleInfo : NSObject
@property (nonatomic, assign) double endTime;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) double startTime;
@end

@interface ProductShop : NSObject
@property (nonatomic, assign) NSInteger gmtCreate;
@property (nonatomic, assign) NSInteger gmtModified;
@property (nonatomic, copy)   NSString *headImage;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) BOOL isProbation;
@property (nonatomic, assign) NSInteger isVip;
@property (nonatomic, assign) NSInteger membersCount;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, assign) NSInteger payOrderId;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy)   NSString *source;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger vipShopId;
@end

@interface ProductSkuList : NSObject
@property (nonatomic, copy)   NSString *classify;
@property (nonatomic, strong) NSArray<ProductValue *> *value;
@end

@interface ProductValue : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger skuId;
@end

@interface ProductRecommend : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *image;
@property (nonatomic, copy)   NSString *discount;
@end

@interface ProductSkuCommission : NSObject
@property (nonatomic, assign) CGFloat actPrice;
@property (nonatomic, assign) CGFloat commissionRate;
@property (nonatomic, assign) double endTime;
@property (nonatomic, assign) NSInteger gmtCreate;
@property (nonatomic, assign) NSInteger gmtModified;
@property (nonatomic, assign) NSInteger isDelete;
@property (nonatomic, assign) NSInteger limitCommissionRate;
@property (nonatomic, assign) NSInteger limitInventory;
@property (nonatomic, assign) NSInteger skuId;
@property (nonatomic, assign) BOOL specialSell;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) NSInteger type;
@end

@interface ProductItem : NSObject
@property (nonatomic, copy)   NSString *zhName;
@property (nonatomic, copy)   NSString *flagIcon;         //海淘国旗
@property (nonatomic, assign) NSInteger spuId;
@property (nonatomic, copy)   NSString *image;
@property (nonatomic, copy)   NSString *brandName;
@property (nonatomic, copy)   NSString *discount;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy)   NSString *unit;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat originalPrice;
@property (nonatomic, assign) NSInteger inventory;
@property (nonatomic, copy)   NSString *productTitle;
@property (nonatomic, copy)   NSString *skuSubtitle;      //副标题
@property (nonatomic, assign) NSInteger volume;
@property (nonatomic, assign) NSInteger htCountLimit;   //海淘限量
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) BOOL isHaiTao;
@property (nonatomic, copy)   NSString *brandImage;
@property (nonatomic, copy)   NSString *introduction;
@end

@interface ProductTagSkus : NSObject
@property (nonatomic, copy)   NSString *discount;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger inventory;
@property (nonatomic, assign) BOOL isCanSelect;
@property (nonatomic, copy)   NSString *originalPrice;
@property (nonatomic, copy)   NSString *price;
@property (nonatomic, strong) ProductTagMap *tagMaps;
@property (nonatomic, copy)   NSString *unit;
@property (nonatomic, assign) NSInteger volume;
@end

@interface ProductTagMap : NSObject

@end
