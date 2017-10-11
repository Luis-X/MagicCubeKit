//
//  ProductDetailViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#define ProductBuyMenu_Height 50 * HOME_IPHONE6_HEIGHT

#import "ProductDetailViewController.h"

#import "ProductSecondPageView.h"
#import "ProductInfomationTableViewCell.h"
#import "ProductSpecialTimeTableViewCell.h"
#import "ProductOnlineStatusTableViewCell.h"
#import "ProductOptionTableViewCell.h"
#import "ProductOptionSaleTableViewCell.h"
#import "ProductActivityTableViewCell.h"
#import "ProductDescribeTableViewCell.h"
#import "ProductPromiseTableViewCell.h"

#import "ProductDetailSelectViewController.h"
#import "ProductDetailSaleViewController.h"
#import "ProductBuyMenuView.h"
#import "ProductDetailModel.h"


#define REUESED_CELL_INFO      @"infomation"
#define REUESED_CELL_SPECIAL   @"special"
#define REUESED_CELL_ONLINE    @"online"
#define REUESED_CELL_OPTION    @"option"
#define REUESED_CELL_SALE      @"optionSale"
#define REUESED_CELL_ACTIVITY  @"activity"
#define REUESED_CELL_DESCRIBE  @"describe"
#define REUESED_CELL_PROMISE   @"promise"

#define DES_MAX_LINES 7

@interface ProductDetailViewController ()<UITableViewDataSource, UITableViewDelegate, ProductBuyMenuViewDelegate, ProductDetailSelectViewControllerDelegate, ProductDetailSaleViewControllerDelegate, ZYBannerViewDataSource, ZYBannerViewDelegate, MagicScrollPageDelegate, ProductSpecialTimeTableViewCellDelegate>
@property (nonatomic, strong) NSTimer        *m_timer;          //倒计时
@property (nonatomic, strong) UILabel *noInventoryView;          //无库存提示
@end

@implementation ProductDetailViewController{
    MagicScrollPage *_mainScrollView;                            //主ScrollView
    UIButton *_stickButton;                                      //置顶
    UITableView *_firtTableView;                                 //第一页
    UIScrollView *_secondScrollView;                             //第二页
    ProductBuyMenuView *_mainBuyMenuView;                        //购买菜单栏
    STPopupController *_productDetailSelectPopup;                //选规格
    STPopupController *_productDetailSalePopup;                  //选优惠
    ProductDetailModel *_mainModel;                              //数据
    ZYBannerView *_productBannerView;                            //主图Banner
    UILabel *_productBannerPageLabel;                            //主图Page
    UIImageView *_productLogoImageView;                          //主图Logo
    NSMutableArray *_allBannerDataArray;                         //主图Banner数据
    UIButton *_addCartButton;                                    //加入购物车
    NSInteger allRowCount;                                       //模块总数量
    BOOL isStartTimer;                                           //倒计时状态
    NSInteger productDescribeNumberOfLines;                      //描述显示行数
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
    productDescribeNumberOfLines = DES_MAX_LINES;
    _allBannerDataArray = [NSMutableArray array];
    allRowCount = 8;
    [self createTimer];
}

- (void)createMainView{
    
    [self createFirstPage];
    [self createSecondPage];
    [self createMainScrollView];
    [self createMainBuyMenuView];
    [self createStickButton];
    
}

#pragma mark -懒加载
- (UILabel *)noInventoryView{
    if (_noInventoryView == nil) {
        _noInventoryView = [UILabel new];
        _noInventoryView.textAlignment = NSTextAlignmentCenter;
        _noInventoryView.text = @"该商品无货，非常抱歉！";
        _noInventoryView.font = [UIFont systemFontOfSize:14];
        _noInventoryView.textColor = [UIColor whiteColor];
        _noInventoryView.layer.cornerRadius = 25 / 2;
        _noInventoryView.layer.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.70].CGColor;
        [self.view addSubview:_noInventoryView];
        [_noInventoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(5);
            make.right.equalTo(self.view).offset(-5);
            make.height.mas_equalTo(25);
            make.bottom.equalTo(_mainBuyMenuView.mas_top).offset(-3);
        }];
    }
    return _noInventoryView;
}

/**
 主框架
 */
- (void)createMainScrollView{
    _mainScrollView = [MagicScrollPage showScrollPageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) firstPage:_firtTableView secondPage:_secondScrollView];
    _mainScrollView.myDelegate = self;
    [self.view addSubview:_mainScrollView];
}


/**
 特效表头
 */
- (ParallaxHeaderView *)createProductParallaxHeaderView{
    
    _productBannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 320)];
    _productBannerView.backgroundColor = [UIColor whiteColor];
    _productBannerView.dataSource = self;
    _productBannerView.delegate = self;
    [_mainScrollView addSubview:_productBannerView];
    
    
    _productLogoImageView = [UIImageView new];
    _productLogoImageView.contentMode = 2;
    _productLogoImageView.clipsToBounds = YES;
    [_productBannerView addSubview:_productLogoImageView];
    [_productLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_productBannerView).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    _productBannerPageLabel = [UILabel new];
    _productBannerPageLabel.textAlignment = NSTextAlignmentCenter;
    _productBannerPageLabel.textColor = [UIColor whiteColor];
    _productBannerPageLabel.font = [UIFont systemFontOfSize:10];
    [_productBannerPageLabel jm_setImageWithCornerRadius:(25 / 2) borderColor:[UIColor clearColor] borderWidth:0 backgroundColor:[UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00]];
    [_productBannerView addSubview:_productBannerPageLabel];
    [_productBannerPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.equalTo(_productBannerView);
        make.right.equalTo(_productBannerView).offset(-15);
    }];
   
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:_productBannerView];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
    
}

/**
 第一页
 */
- (void)createFirstPage{

    _firtTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _firtTableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    _firtTableView.tableHeaderView = [self createProductParallaxHeaderView];
    _firtTableView.estimatedRowHeight = 5;
    _firtTableView.rowHeight = UITableViewAutomaticDimension;
    _firtTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firtTableView.dataSource = self;
    _firtTableView.delegate = self;
    [_firtTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_firtTableView registerClass:[ProductInfomationTableViewCell class] forCellReuseIdentifier:REUESED_CELL_INFO];
     [_firtTableView registerClass:[ProductSpecialTimeTableViewCell class] forCellReuseIdentifier:REUESED_CELL_SPECIAL];
     [_firtTableView registerClass:[ProductOnlineStatusTableViewCell class] forCellReuseIdentifier:REUESED_CELL_ONLINE];
    [_firtTableView registerClass:[ProductOptionTableViewCell class] forCellReuseIdentifier:REUESED_CELL_OPTION];
    [_firtTableView registerClass:[ProductOptionSaleTableViewCell class] forCellReuseIdentifier:REUESED_CELL_SALE];
    [_firtTableView registerClass:[ProductActivityTableViewCell class] forCellReuseIdentifier:REUESED_CELL_ACTIVITY];
    [_firtTableView registerClass:[ProductDescribeTableViewCell class] forCellReuseIdentifier:REUESED_CELL_DESCRIBE];
    [_firtTableView registerClass:[ProductPromiseTableViewCell class] forCellReuseIdentifier:REUESED_CELL_PROMISE];
}


/**
 第二页
 */
- (void)createSecondPage{
    
    _secondScrollView = [UIScrollView new];
    _secondScrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    
}

/**
 购买菜单
 */
- (void)createMainBuyMenuView{
    
    _mainBuyMenuView = [ProductBuyMenuView new];
    _mainBuyMenuView.delegate = self;
    [self.view addSubview:_mainBuyMenuView];
    [_mainBuyMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-5);
        make.left.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(-5);
        make.height.mas_equalTo(ProductBuyMenu_Height);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _mainBuyMenuView.cartAmount = 10;
    });

    [self createAddCartButton];
}


/**
 加入购物车
 */
- (void)createAddCartButton{
    
    _addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addCartButton.titleLabel.font = [UIFont systemFontOfSize:16 * HOME_IPHONE6_WIDTH];
    //_addCartButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_addCartButton];
    [_addCartButton addTarget:self action:@selector(addCartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(95 * HOME_IPHONE6_HEIGHT);
        make.right.bottom.equalTo(_mainBuyMenuView);
    }];
    
    MagicIconButton *button = [MagicIconButton new];
    //button.backgroundColor = [UIColor orangeColor];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.iconLabel.textColor = [UIColor whiteColor];
    button.titleLabel.text = @"加入购物袋";
    button.iconLabel.text = @"\U0000e6e3";
    button.titleLabel.font = [UIFont systemFontOfSize:10 * HOME_IPHONE6_WIDTH];
    button.buttonStyle = IconTextButtonStyleTop;
    button.iconFontSize = 25 * HOME_IPHONE6_WIDTH;
    [_addCartButton addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_addCartButton);
        make.height.mas_equalTo(45 * HOME_IPHONE6_HEIGHT);
    }];
   [button addTarget:self action:@selector(addCartButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

/**
 置顶
 */
- (void)createStickButton{
    
    CGSize stick_size = CGSizeMake(40 * HOME_IPHONE6_HEIGHT, 40 * HOME_IPHONE6_HEIGHT);
    _stickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stickButton setBackgroundImage:[UIImage imageNamed:@"productDetailGoTop@2x.png"] forState:UIControlStateNormal];
    _stickButton.hidden = YES;
    [self.view addSubview:_stickButton];
    [_stickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(stick_size);
        make.bottom.equalTo(self.view).offset(-120 * HOME_IPHONE6_HEIGHT);
        make.right.equalTo(self.view).offset(-30 * HOME_IPHONE6_WIDTH);
    }];
    [_stickButton addTarget:self action:@selector(stickButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 信息
    if (indexPath.row == 0) {
        ProductInfomationTableViewCell *infomationCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_INFO forIndexPath:indexPath];
        [self setupProductInfomationModelOfCell:infomationCell AtIndexPath:indexPath];
        return infomationCell;
    }

    // 倒计时
    if (indexPath.row == 1) {
        ProductSpecialTimeTableViewCell *specialTimeCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_SPECIAL forIndexPath:indexPath];
        [self setupProductSpecialTimeModelOfCell:specialTimeCell AtIndexPath:indexPath];
        return specialTimeCell;
    }
    
    // 上架状态
    if (indexPath.row == 2) {
        ProductOnlineStatusTableViewCell *onlineStatusCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_ONLINE forIndexPath:indexPath];
        [self setupProductOnlineStatusModelOfCell:onlineStatusCell AtIndexPath:indexPath];
        return onlineStatusCell;
    }
    
    // 促销
    if (indexPath.row == 3) {
        ProductOptionSaleTableViewCell *saleCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_SALE];
        if (saleCell == nil){
            saleCell = [[ProductOptionSaleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUESED_CELL_SALE];
        }
        [self setupProductSaleModelOfCell:saleCell AtIndexPath:indexPath];
        return saleCell;
    }
    
    // 规格
    if (indexPath.row == 4) {
        ProductOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_OPTION forIndexPath:indexPath];
        optionCell.productDetailModel = _mainModel;
        return optionCell;
    }
    
    
    // 活动
    if (indexPath.row == 5) {
        ProductActivityTableViewCell *activityCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_ACTIVITY forIndexPath:indexPath];
        return activityCell;
    }
    
    // 描述
    if (indexPath.row == 6) {
        ProductDescribeTableViewCell *describeCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_DESCRIBE forIndexPath:indexPath];
        [self setupProductDescribeModelOfCell:describeCell AtIndexPath:indexPath];
        return describeCell;
    }
    
    // 承诺
    if (indexPath.row == 7) {
        ProductPromiseTableViewCell *promiseCell = [tableView dequeueReusableCellWithIdentifier:REUESED_CELL_PROMISE forIndexPath:indexPath];
        return promiseCell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //防止倒计时消耗性能
    if ([cell isKindOfClass:[ProductSpecialTimeTableViewCell class]]) {
        ProductSpecialTimeTableViewCell *tmpCell = (ProductSpecialTimeTableViewCell *)cell;
        tmpCell.m_isDisplayed = YES;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    //防止倒计时消耗性能
    if ([cell isKindOfClass:[ProductSpecialTimeTableViewCell class]]) {
        ProductSpecialTimeTableViewCell *tmpCell = (ProductSpecialTimeTableViewCell *)cell;
        tmpCell.m_isDisplayed= YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        [self showProductDetailSaleViewController];
    }
    
    if (indexPath.row == 4) {
        [self showProductDetailSelectViewController];
    }
    
    if (indexPath.row == 6) {
        productDescribeNumberOfLines = (productDescribeNumberOfLines == DES_MAX_LINES) ? 0 : DES_MAX_LINES;
        //[_firtTableView reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationFade];
        [_firtTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:6]] withRowAnimation:UITableViewRowAnimationFade];
        //[_firtTableView reloadData];
    }
    
}

#pragma mark -Cell配置（自适应高度必须实现）
// 详情
- (void)setupProductInfomationModelOfCell:(ProductInfomationTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
     cell.productDetailModel = _mainModel;
}

// 倒计时
- (void)setupProductSpecialTimeModelOfCell:(ProductSpecialTimeTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.delegate = self;
    cell.productDetailModel = _mainModel;
}

// 上架状态
- (void)setupProductOnlineStatusModelOfCell:(ProductOnlineStatusTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.productDetailModel = _mainModel;
}

// 描述
- (void)setupProductDescribeModelOfCell:(ProductDescribeTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.productDetailModel = _mainModel;
    cell.messageLabel.numberOfLines = productDescribeNumberOfLines;
}

// 促销
- (void)setupProductSaleModelOfCell:(ProductOptionSaleTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.salesArray = @[@{@"title": @"3件199元", @"message": @"只需要199元可享三件商品"},
                        @{@"title": @"多买优惠", @"message": @"购满2件可享八折"},
                        @{@"title": @"3件199元", @"message": @"只需要199元可享三件商品只需要199元可享三件商品只需要199元可享三件商品"}];
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
            
            if (_mainBuyMenuView.isSelectByGoods == YES) {
                NSLog(@"下架操作");
                _mainBuyMenuView.isSelectByGoods = NO;
                return;
            }
            
            if (_mainBuyMenuView.isSelectByGoods == NO) {
                NSLog(@"上架操作");
                _mainBuyMenuView.isSelectByGoods = YES;
                return;
            }
            
            break;
            
        case ProductBuyMenuTypeCart:
            NSLog(@"购物车");
            break;
            
        case ProductBuyMenuTypeBuy:
            NSLog(@"立即购买");
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
    [_mainScrollView moveToSecondPageView];
}

#pragma mark - MagicScrollPageDelegate
- (void)magicScrollPageDidScrollToPageIndex:(NSInteger)index{
    [self updateProductBannerPageWithPage:index + 1];
    _stickButton.hidden = (index == 0) ? YES : NO;
}

#pragma mark - ProductSpecialTimeTableViewCellDelegate
- (void)productSpecialTimeTableViewCellCurrentTimerStatus:(ProductSpecialTimeStatus)status{
    
    if (status == ProductSpecialTimeStatusSaleEnd) {
        [self endTimer];
        [_firtTableView reloadData];
    }
    
}

#pragma mark - Network

- (void)networkGetAllProductDetailData{

    [_allBannerDataArray removeAllObjects];
    NSString *jsonString = [NSString stringWithContentsOfFile:MC_PATH(@"shopSku", @"json") encoding:NSUTF8StringEncoding error:nil];
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
    
    //是否特卖
    if (_mainModel.isSpecialSell) {
        [self startTimer];
    }
    [self reloadAllData];
    
}

#pragma mark -ReloadData
/**
 刷新数据
 */
- (void)reloadAllData{
    //_secondScrollView.productDetailModel = _mainModel;
    [_firtTableView reloadData];
    [self reloadProductBannerViewData];
    [self reloadMainBuyMenuViewData];
}

/**
 刷新Banner数据
 */
- (void)reloadProductBannerViewData{
    
    // 配置Banner数据
    [_allBannerDataArray removeAllObjects];
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
    [_productLogoImageView sd_setImageWithURL:[NSURL URLWithString:_mainModel.item.brandImage]];
    [self updateProductBannerPageWithPage:1];
    
}

/**
 更新Banner页面值
 */
- (void)updateProductBannerPageWithPage:(NSInteger)page{
    _productBannerPageLabel.text = [NSString stringWithFormat:@"%ld/%ld", page, _allBannerDataArray.count];
}

/**
 刷新购买菜单数据
 */
- (void)reloadMainBuyMenuViewData{
    
    _addCartButton.hidden = NO;
    _mainBuyMenuView.isSelectByGoods = _mainModel.isSelect;
    
    // 海淘商品
    if (_mainModel.item.isHaiTao) {
        return;
    }
    
    // 暂无库存
    if (_mainModel.item.inventory <= 0) {
        _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNoInventory;
        _addCartButton.hidden = YES;
        self.noInventoryView.hidden = NO;
        return;
    }
    
    // 普通商品
    self.noInventoryView.hidden = YES;
    _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNormal;
}

- (void)stickButtonAction{
    _stickButton.hidden = YES;
    [_mainScrollView moveToFirstPageView];
}


/**
 加入购物车
 */
- (void)addCartButtonAction:(id)sender{
    NSLog(@"加入购物车");
}


#pragma mark -倒计时相关
- (void)createTimer{
    
    if (self.m_timer == nil) {
        self.m_timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
    }
    [self endTimer];
   
}
//开启定时器
- (void)startTimer{
    [self.m_timer setFireDate:[NSDate distantPast]];
    isStartTimer = YES;
}

//关闭定时器
- (void)endTimer{
    [self.m_timer setFireDate:[NSDate distantFuture]];
    isStartTimer = NO;
}

- (void)timerEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIME_CELL object:nil];
}

@end
