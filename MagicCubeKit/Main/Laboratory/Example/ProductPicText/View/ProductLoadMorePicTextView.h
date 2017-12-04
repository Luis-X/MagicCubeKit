//
//  ProductLoadMorePicTextView.h
//  DaRenShop
//
//  Created by LuisX on 2017/11/22.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"
#import "ProductLoadMorePicTextModel.h"

@protocol ProductLoadMorePicTextViewDelegate <NSObject>
- (void)productLoadMorePicTextViewZoomImageWithIndex:(NSInteger)index;
- (void)productLoadMorePicTextViewPushProductWithSkuId:(NSString *)skuId;
- (void)productLoadMorePicTextViewGoTop;
@end

@interface ProductLoadMorePicTextView : UIView
@property (nonatomic, weak) id <ProductLoadMorePicTextViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame productDetailModel:(ProductDetailModel *)productDetailModel picTextModel:(ProductLoadMorePicTextModel *)picTextModel;
- (void)reload;
@end
