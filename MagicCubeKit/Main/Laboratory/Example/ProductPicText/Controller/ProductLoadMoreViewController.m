//
//  ProductLoadMoreViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/12/4.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductLoadMoreViewController.h"
#import "MagicNetworkManager.h"
#import "ProductLoadMorePicTextView.h"

static NSString * const SJProductAPI = @"https://shopappserver.showjoy.com/api/shop/sku";
static NSString * const SJProductPicTextAPI = @"https://shopappserver.showjoy.com/api/shop/item/pictext";
static NSString * const SJProductSkuId = @"146931";

@interface ProductLoadMoreViewController () <ProductLoadMorePicTextViewDelegate>

@end

@implementation ProductLoadMoreViewController{
    ProductDetailModel *_productModel;
    ProductLoadMorePicTextModel *_productPicTextModel;
    ProductLoadMorePicTextView *_picTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self networkRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Network
- (void)networkRequestData
{
    [QuicklyHUD showWindowsProgressHUDText:@"加载中..."];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t serialQueue = dispatch_queue_create("product_group", DISPATCH_QUEUE_SERIAL);
    
    // 商品信息
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        [[MagicNetworkManager shareManager] GET:SJProductAPI Parameters:@{@"skuId" : SJProductSkuId} Success:^(NSURLResponse *response, id responseObject) {
            [ProductDetailModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"shop" : [ProductShop class],
                         @"skuList" : [ProductSkuList class],
                         @"value" : [ProductValue class],
                         @"saleInfo" : [ProductSaleInfo class],
                         @"recommend" : [ProductRecommend class],
                         @"skuCommission" : [ProductSkuCommission class],
                         @"item" : [ProductItem class],
                         @"tagSkus" : [ProductTagSkus class],
                         @"tagMap" : [ProductTagMap class],
                         @"skuEnsures" : [ProductSkuEnsures class],
                         @"salesPromotion" : [ProductSalesPromotion class]};
            }];
            _productModel = [ProductDetailModel mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
            dispatch_group_leave(group);
        } Failure:^(NSURLResponse *response, id error) {
            dispatch_group_leave(group);
        }];
    });
    
    // 图文信息
    dispatch_group_enter(group);
    dispatch_group_async(group, serialQueue, ^{
        [[MagicNetworkManager shareManager] GET:SJProductPicTextAPI Parameters:@{@"skuId" : SJProductSkuId} Success:^(NSURLResponse *response, id responseObject) {
            [ProductLoadMorePicTextModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"item" : [PicTextItem class],
                         @"itemPic" : [PicTextItemPic class],
                         @"spu" : [PicTextSpu class]};
            }];
            _productPicTextModel = [ProductLoadMorePicTextModel mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
            dispatch_group_leave(group);
        } Failure:^(NSURLResponse *response, id error) {
            dispatch_group_leave(group);
        }];
    });
    
    // 主线程刷新UI
    dispatch_group_notify(group, serialQueue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [QuicklyHUD hiddenMBProgressHUDForView:MC_APP_WINDOW];
                [self reloadPicTextView];
            });
        });
    });
    
}

#pragma mark - Reload
- (void)reloadPicTextView
{
    if (_picTextView) {
        [_picTextView removeFromSuperview];
        _picTextView.delegate = nil;
        _picTextView = nil;
    }
    CGFloat border = 20.0f;
    _picTextView = [[ProductLoadMorePicTextView alloc] initWithFrame:CGRectMake(border, border, MC_SCREEN_W - 2 * border, MC_SCREEN_H - MC_NAVIGATION_BAR_H - MC_STATUS_BAR_H - 2 * border) productDetailModel:_productModel picTextModel:_productPicTextModel];
    _picTextView.delegate = self;
    [self.view addSubview:_picTextView];
    [_picTextView reload];
}

#pragma mark - ProductLoadMorePicTextViewDelegate
- (void)productLoadMorePicTextViewGoTop
{
    [QuicklyHUD showWindowsOnlyTextHUDText:@"Go Top"];
}

- (void)productLoadMorePicTextViewZoomImageWithIndex:(NSInteger)index
{
    [QuicklyHUD showWindowsOnlyTextHUDText:[NSString stringWithFormat:@"img: %ld", index]];
}

- (void)productLoadMorePicTextViewPushProductWithSkuId:(NSString *)skuId
{
    [QuicklyHUD showWindowsOnlyTextHUDText:[NSString stringWithFormat:@"skuId: %@", skuId]];
}
@end
