//
//  ProductBuyMenuView.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProductBuyMenuTypeService,  //客服
    ProductBuyMenuTypeOnOff,    //上下架
    ProductBuyMenuTypeCart,     //购物车
    ProductBuyMenuTypeBuy,      //立即购买
} ProductBuyMenuType;

typedef enum : NSUInteger {
    ProductBuyMenuStatusNormal,         //正常
    ProductBuyMenuStatusNoInventory,    //无库存
} ProductBuyMenuStatus;

@protocol ProductBuyMenuViewDelegate <NSObject>

- (void)productBuyMenuViewSelectedType:(ProductBuyMenuType)type;

@end

@interface ProductBuyMenuView : UIView
@property (nonatomic, assign)id <ProductBuyMenuViewDelegate> delegate;
@property (nonatomic, assign)ProductBuyMenuStatus currentStatus;
@property (nonatomic, assign)BOOL isSelectByGoods;                    //商品是否上架
@property (nonatomic, assign)NSInteger cartAmount;                    //购物车总数
@end
