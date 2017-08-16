//
//  ProductDetailModel.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/5.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

@end

@implementation Shop
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{@"ID" : @"id"};
}
@end

@implementation ProductDeatilParam

@end

@implementation SkuList

@end

@implementation Value

@end

@implementation Recommend
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{@"ID" : @"id"};
}
@end

@implementation SkuCommission

@end

@implementation Item
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{@"ID" : @"id"};
}
@end

@implementation TagSkus
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{@"ID" : @"id"};
}
@end

@implementation TagMap

@end
