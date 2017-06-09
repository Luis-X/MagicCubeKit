//
//  ProductDetailViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#define ProductBuyMenu_Height 50

#import "ProductDetailViewController.h"
#import "ParallaxHeaderView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MagicScrollPage.h"
#import "ZYBannerView.h"

#import "ProductInfomationTableViewCell.h"
#import "ProductOptionTableViewCell.h"
#import "ProductActivityTableViewCell.h"
#import "ProductSpecialTableViewCell.h"
#import "ProductDetailSelectViewController.h"
#import "ProductDetailSaleViewController.h"
#import "ProductBuyMenuView.h"
#import "ProductDetailModel.h"
@interface ProductDetailViewController ()<UITableViewDataSource, UITableViewDelegate, ProductBuyMenuViewDelegate, ProductDetailSelectViewControllerDelegate, ProductDetailSaleViewControllerDelegate, ZYBannerViewDataSource, ZYBannerViewDelegate>

@end

@implementation ProductDetailViewController{
    MagicScrollPage *_mainScrollView;                            //主ScrollView
    UITableView *_firtTableView;                                 //第一页
    UIScrollView *_secondScrollView;                             //第二页
    ProductBuyMenuView *_mainBuyMenuView;                        //购买菜单栏
    STPopupController *_productDetailSelectPopup;                //选规格
    STPopupController *_productDetailSalePopup;                  //选优惠
    ProductDetailModel *_mainModel;                              //数据
    ZYBannerView *_productBannerView;                            //主图Banner
    NSMutableArray *_allBannerDataArray;                         //主图Banner数据
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"商品详情";
    [self initailData];
    [self createMainView];
    [self networkGetAllProductDetailData];
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

- (void)initailData{
    _allBannerDataArray = [NSMutableArray array];
}

- (void)createMainView{
    
    [self createFirstPage];
    [self createSecondPage];
    [self createMainScrollView];
    [self createMainBuyMenuView];
}


/**
 主框架
 */
- (void)createMainScrollView{
    _mainScrollView = [MagicScrollPage showScrollPageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - ProductBuyMenu_Height) firstPage:_firtTableView secondPage:_secondScrollView];
    [self.view addSubview:_mainScrollView];
}

/**
 第一页
 */
- (void)createFirstPage{
    
    // 主图Banner
    _productBannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, Magic_screen_Width, 350)];
    _productBannerView.backgroundColor = [UIColor whiteColor];
    _productBannerView.dataSource = self;
    _productBannerView.delegate = self;
    [_mainScrollView addSubview:_productBannerView];
    
    // 滚动效果表头
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:_productBannerView];
    headerView.backgroundColor = [UIColor whiteColor];

    
    _firtTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _firtTableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    _firtTableView.tableHeaderView = headerView;
    _firtTableView.fd_debugLogEnabled = NO;       //打开自适应高度debug模式
    _firtTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firtTableView.dataSource = self;
    _firtTableView.delegate = self;
    [_firtTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_firtTableView registerClass:[ProductSpecialTableViewCell class] forCellReuseIdentifier:@"special"];
    [_firtTableView registerClass:[ProductInfomationTableViewCell class] forCellReuseIdentifier:@"infomation"];
    [_firtTableView registerClass:[ProductOptionTableViewCell class] forCellReuseIdentifier:@"option"];
    [_firtTableView registerClass:[ProductActivityTableViewCell class] forCellReuseIdentifier:@"activity"];
    
}


/**
 第二页
 */
- (void)createSecondPage{
    _secondScrollView = [UIScrollView new];
    UILabel *textLabel = [QuicklyUI quicklyUILabelAddTo:_secondScrollView];
    textLabel.text = @"Page 2";
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_secondScrollView);
    }];

}

/**
 购买菜单
 */
- (void)createMainBuyMenuView{
    
    _mainBuyMenuView = [ProductBuyMenuView new];
    _mainBuyMenuView.delegate = self;
    [self.view addSubview:_mainBuyMenuView];
    [_mainBuyMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ProductBuyMenu_Height);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _mainBuyMenuView.cartAmount = 10;
    });

}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 特卖
    if (indexPath.section == 0) {
        ProductSpecialTableViewCell *specialCell = [tableView dequeueReusableCellWithIdentifier:@"special" forIndexPath:indexPath];
        specialCell.productDetailModel = _mainModel;
        return specialCell;
    }
    
    // 信息
    if (indexPath.section == 1) {
        ProductInfomationTableViewCell *infomationCell = [tableView dequeueReusableCellWithIdentifier:@"infomation" forIndexPath:indexPath];
        [self setupIntroduceModelOfCell:infomationCell AtIndexPath:indexPath];
        return infomationCell;
    }
    
    // 规格
    if (indexPath.section == 2) {
        ProductOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"option" forIndexPath:indexPath];
        optionCell.titleLabel.text = @"规格选择";
        return optionCell;
    }
    
    // 促销
    if (indexPath.section == 3) {
        ProductOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"option" forIndexPath:indexPath];
        optionCell.titleLabel.text = @"促销";
        optionCell.subTitleLabel.text = @"购物满两件可享受八折";
        optionCell.saleTagView.title = @"促销标签";
        return optionCell;
    }
    
    // 活动
    if (indexPath.section == 4) {
        ProductActivityTableViewCell *activityCell = [tableView dequeueReusableCellWithIdentifier:@"activity" forIndexPath:indexPath];
        return activityCell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }
    if (section == 4) {
        return 50;
    }
    return 10;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return [tableView fd_heightForCellWithIdentifier:@"infomation" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self setupIntroduceModelOfCell:cell AtIndexPath:indexPath];
        }];
    }
    return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        [self showProductDetailSelectViewController];
    }
    
    if (indexPath.section == 3) {
        [self showProductDetailSaleViewController];
    }
    
}

#pragma mark -重点 自适应高度必须实现
// 预加载商品介绍
- (void)setupIntroduceModelOfCell:(ProductInfomationTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
     cell.productDetailModel = _mainModel;
}


#pragma mark - 滚动效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _firtTableView) {
        [(ParallaxHeaderView *)_firtTableView.tableHeaderView layoutFXGoodsDetailHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
    
}

#pragma mark - 显示
/**
 规格
 */
- (void)showProductDetailSelectViewController{
    
    
    ProductDetailSelectViewController *vc = [ProductDetailSelectViewController new];
    vc.productDetailModel = _mainModel;
    vc.delegate = self;
    _productDetailSelectPopup = [[ProductConstant shareManager] showPopViewControllerWithMagicVC:vc AddController:self CornerRadius:0 NavigationBarHidden:YES];
    
}

/**
 优惠
 */
- (void)showProductDetailSaleViewController{
    
    ProductDetailSaleViewController *vc = [ProductDetailSaleViewController new];
    vc.delegate = self;
    _productDetailSalePopup = [[ProductConstant shareManager] showPopViewControllerWithMagicVC:vc AddController:self CornerRadius:0 NavigationBarHidden:YES];
    
}

#pragma mark - ProductBuyMenuViewDelegate
- (void)productBuyMenuViewSelectedType:(ProductBuyMenuType)type{
    
    switch (type) {
        case ProductBuyMenuTypeService:
            NSLog(@"客服");
            break;
            
        case ProductBuyMenuTypeOnOff:
            
            if (_mainBuyMenuView.isOnByGoods == YES) {
                NSLog(@"下架操作");
                _mainBuyMenuView.isOnByGoods = NO;
                return;
            }
            
            if (_mainBuyMenuView.isOnByGoods == NO) {
                NSLog(@"上架操作");
                _mainBuyMenuView.isOnByGoods = YES;
                return;
            }
            
            break;
            
        case ProductBuyMenuTypeCart:
            NSLog(@"购物车");
            break;
            
        case ProductBuyMenuTypeBuy:
            NSLog(@"立即购买");
            break;
            
        case ProductBuyMenuTypeAdd:
            NSLog(@"加入购物车");
            break;
        default:
            break;
    }
    
}

#pragma mark - ProductDetailSelectViewControllerDelegate

- (void)productDetailSelectCloseActionWithValue:(id)value{
    
    [_productDetailSelectPopup dismiss];
    
}

#pragma mark - ProductDetailSaleViewControllerDelegate

- (void)productDetailSaleCloseActionWithValue:(id)value{
    
    [_productDetailSalePopup dismiss];
    
}

#pragma mark - ZYBannerViewDataSource

- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner{
    return _allBannerDataArray.count;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index{
   
    NSString *url = [_allBannerDataArray objectAtIndex:index];
    UIImageView *bannerImageView = [UIImageView new];
    [bannerImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"1.png"]];
    bannerImageView.contentMode = 2;
    bannerImageView.clipsToBounds = YES;
    return bannerImageView;
    
}

- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState{
    
    if (footerState == ZYBannerFooterStateIdle) {
        return @"滑动查看图文详情";
    }
    if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放查看图文详情";
    }
    return @"";
    
}

#pragma mark - ZYBannerViewDelegate

- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"放大%ld", index);
}

- (void)bannerFooterDidTrigger:(ZYBannerView *)banner{
    
    NSLog(@"触发侧拉");
    
}

#pragma mark - Network

- (void)networkGetAllProductDetailData{

    [_allBannerDataArray removeAllObjects];
    NSString *jsonString = [NSString stringWithContentsOfFile:Magic_bundle(@"shopSku", @"json") encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    [ProductDetailModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"shop" : [Shop class],
   @"productDeatilParam" : [ProductDeatilParam class],
              @"skuList" : [SkuList class],
                @"value" : [Value class],
            @"recommend" : [Recommend class],
        @"skuCommission" : [SkuCommission class],
                 @"item" : [Item class],
              @"tagSkus" : [TagSkus class],
               @"tagMap" : [TagMap class]};
    }];
    _mainModel = [ProductDetailModel mj_objectWithKeyValues:[dic objectForKey:@"data"]];
    [self reloadAllData];
    
}

#pragma mark -ReloadData
/**
 刷新数据
 */
- (void)reloadAllData{
    
    [_firtTableView reloadData];
    [self reloadProductBannerViewData];
    [self reloadMainBuyMenuViewData];
    
}

/**
 刷新Banner数据
 */
- (void)reloadProductBannerViewData{
    
    // 配置Banner数据
    if (_mainModel.item.images.count > 0) {
        for (NSString *imageUrl in _mainModel.item.images) {
            [_allBannerDataArray addObject:imageUrl];
        }
    }else{
        [_allBannerDataArray addObject:_mainModel.item.image];
    }
    // 配置Banner样式
    _productBannerView.showFooter = (_allBannerDataArray.count > 0) ? YES : NO;
    if (_allBannerDataArray.count > 1) {
        _productBannerView.pageControl.currentPageIndicatorTintColor =  [UIColor blackColor];
        _productBannerView.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0/255.0 alpha:0.2];
    }else{
        _productBannerView.pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
        _productBannerView.pageControl.pageIndicatorTintColor = [UIColor clearColor];
    }
    [_productBannerView reloadData];
    
}

/**
 刷新购买菜单数据
 */
- (void)reloadMainBuyMenuViewData{
    
    // 海淘商品
    if (_mainModel.item.isHaiTao) {
        _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNoAdd;
        return;
    }
    
    // 暂无库存
    if (_mainModel.item.inventory <= 0) {
        _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNoInventory;
        return;
    }
    
    // 普通商品
    _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNormal;
}
@end
