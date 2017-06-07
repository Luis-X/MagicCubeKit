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
#import "ProductInfomationTableViewCell.h"
#import "ProductOptionTableViewCell.h"
#import "ProductActivityTableViewCell.h"
#import "ProductSpecialTableViewCell.h"
#import "ProductDetailSelectViewController.h"
#import "ProductDetailSaleViewController.h"
#import "ProductBuyMenuView.h"
#import "ProductDetailModel.h"
@interface ProductDetailViewController ()<UITableViewDataSource, UITableViewDelegate, ProductBuyMenuViewDelegate, ProductDetailSelectViewControllerDelegate, ProductDetailSaleViewControllerDelegate>

@end

@implementation ProductDetailViewController{
    MagicScrollPage *_mainScrollView;                            //主ScrollView
    UITableView *_firtTableView;                                 //第一页
    UIScrollView *_secondScrollView;                             //第二页
    ProductBuyMenuView *_mainBuyMenuView;                        //购买菜单栏
    STPopupController *_productDetailSelectPopup;                //选规格
    STPopupController *_productDetailSalePopup;                  //选优惠
    ProductDetailModel *_mainModel;                              //数据
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
    _mainScrollView.headerRefreshTitle = @"释放回到“商品详情”";
    _mainScrollView.footerRefreshTitle = @"拖动查看图文详情";
    [self.view addSubview:_mainScrollView];
}

/**
 第一页
 */
- (void)createFirstPage{
    
    UIImageView *productBrowerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320)];
    productBrowerView.backgroundColor = [UIColor whiteColor];
    productBrowerView.image = [UIImage imageNamed:@"1.jpg"];
    productBrowerView.contentMode = 2;
    productBrowerView.clipsToBounds = YES;
    
    //滚动效果表头
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:productBrowerView];
    headerView.backgroundColor = [UIColor whiteColor];

    
    _firtTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _firtTableView.backgroundColor = [UIColor whiteColor];
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
//    _mainBuyMenuView.backgroundColor = [UIColor orangeColor];
    _mainBuyMenuView.delegate = self;
    [self.view addSubview:_mainBuyMenuView];
    [_mainBuyMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ProductBuyMenu_Height);
    }];
    _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNoAdd;
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
    
    //特卖
    if (indexPath.section == 0) {
        ProductSpecialTableViewCell *specialCell = [tableView dequeueReusableCellWithIdentifier:@"special" forIndexPath:indexPath];
        return specialCell;
    }
    
    //信息
    if (indexPath.section == 1) {
        ProductInfomationTableViewCell *infomationCell = [tableView dequeueReusableCellWithIdentifier:@"infomation" forIndexPath:indexPath];
        [self setupIntroduceModelOfCell:infomationCell AtIndexPath:indexPath];
        return infomationCell;
    }
    
    //规格
    if (indexPath.section == 2) {
        ProductOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"option" forIndexPath:indexPath];
        optionCell.titleLabel.text = @"规格选择";
        return optionCell;
    }
    
    //促销
    if (indexPath.section == 3) {
        ProductOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"option" forIndexPath:indexPath];
        optionCell.titleLabel.text = @"促销";
        optionCell.subTitleLabel.text = @"促销标签";
        optionCell.tagLabel.text = @"购物满两件可享受八折";
        return optionCell;
    }
    
    //活动
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
    return 0.5;
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
//预加载商品介绍
- (void)setupIntroduceModelOfCell:(ProductInfomationTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
     cell.model = _mainModel;
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
    vc.allSkuListModelArray = _mainModel.skuList;
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

#pragma mark - Network
- (void)networkGetAllProductDetailData{

    //获取数据
    NSString *jsonString = [NSString stringWithContentsOfFile:Magic_bundle(@"shopSku", @"json") encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"%@", dic);
    
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
    [_firtTableView reloadData];
    
}
@end
