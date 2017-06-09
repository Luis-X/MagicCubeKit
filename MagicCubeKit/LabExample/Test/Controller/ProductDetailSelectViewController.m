//
//  ProductDetailSelectViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#define ProductBuyMenu_Height 50

#import "ProductDetailSelectViewController.h"
#import <STPopup.h>
#import "UICollectionViewLeftAlignedLayout.h"
#import "ProductBuyMenuView.h"
#import "ProductSelectCollectionViewCell.h"
#import "ProductSelectHeaderCollectionReusableView.h"
#import "ProductSelectFooterCollectionReusableView.h"


@interface ProductDetailSelectViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ProductDetailSelectViewController{
    UIView *_headerBackgroundView;              //头部背景
    UIImageView *_productImageView;             //商品主图
    UILabel *_productPriceLabel;                //商品价格
    UILabel *_productCommissionLabel;           //商品佣金
    UICollectionView *_selectedCollectionView;  //选择视图
    ProductBuyMenuView *_mainBuyMenuView;       //购买菜单栏
    NSInteger currentSelectedSkuId;             //选中skuId
    NSMutableArray *_allSkuListModelArray;      //SKUList数据
}


//重写初始化方法
- (instancetype)init{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(Magic_screen_Width, Magic_screen_Height - 120);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initailData];
    [self createMainView];
    [self reloadAllData];
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
    
    self.view.backgroundColor = [UIColor clearColor];
    _allSkuListModelArray = [NSMutableArray arrayWithArray:_productDetailModel.skuList];
    currentSelectedSkuId = _productDetailModel.item.ID;
    
}

- (void)createMainView{
    [self createHeaderSubViews];
    [self createBodySubViews];
    [self createMainBuyMenuView];
}



/**
 头部信息
 */
- (void)createHeaderSubViews{
    
    _headerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 100)];
    _headerBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerBackgroundView];
    
    
    UIView *blackLine = [UIView new];
    blackLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    [_headerBackgroundView addSubview:blackLine];
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_headerBackgroundView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *closeButton = [UILabel new];
    closeButton.font = [UIFont fontWithName:@"iconfont" size:20];
    closeButton.text = @"\U0000e646";
    closeButton.userInteractionEnabled = YES;
    [closeButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allCloseActionHandler)]];
    [_headerBackgroundView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerBackgroundView).offset(10);
        make.right.equalTo(_headerBackgroundView).offset(-10);
    }];
    
    
    _productImageView = [UIImageView new];
    _productImageView.backgroundColor = [UIColor whiteColor];
    _productImageView.contentMode = 2;
    _productImageView.clipsToBounds = YES;
    _productImageView.layer.borderColor = [UIColor colorWithHexString:@"#E6E6E6"].CGColor;
    _productImageView.layer.borderWidth = 0.5;
    _productImageView.layer.masksToBounds = YES;
    _productImageView.layer.cornerRadius = 5;
    [_headerBackgroundView addSubview:_productImageView];
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(_headerBackgroundView).offset(10);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(blackLine).offset(-20);
    }];
    
    _productCommissionLabel = [UILabel new];
    _productCommissionLabel.textColor = [UIColor blackColor];
    _productCommissionLabel.font = [UIFont systemFontOfSize:12];
    //_productCommissionLabel.backgroundColor = [UIColor grayColor];
    [_headerBackgroundView addSubview:_productCommissionLabel];
    [_productCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_productImageView).offset(-5);
        make.left.equalTo(_productImageView.mas_right).offset(10);
    }];
    
    
    _productPriceLabel = [UILabel new];
    _productPriceLabel.textColor = [UIColor flatRedColor];
    _productPriceLabel.font = [UIFont systemFontOfSize:18];
    //_productPriceLabel.backgroundColor = [UIColor grayColor];
    [_headerBackgroundView addSubview:_productPriceLabel];
    [_productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_productCommissionLabel.mas_top).offset(-5);
        make.left.equalTo(_productCommissionLabel);
    }];
    
}


/**
 内容信息
 */
- (void)createBodySubViews{
    
    //居左显示
    UICollectionViewLeftAlignedLayout *collectionLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    collectionLayout.minimumLineSpacing = 10;
    collectionLayout.minimumInteritemSpacing = 5;
    collectionLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    collectionLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
    
    _selectedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _headerBackgroundView.frame.origin.y + _headerBackgroundView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _headerBackgroundView.frame.origin.y - _headerBackgroundView.frame.size.height - ProductBuyMenu_Height) collectionViewLayout:collectionLayout];
    _selectedCollectionView.backgroundColor = [UIColor whiteColor];
    _selectedCollectionView.delegate = self;
    _selectedCollectionView.dataSource = self;
    [self.view addSubview:_selectedCollectionView];
    [_selectedCollectionView registerClass:[ProductSelectCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_selectedCollectionView registerClass:[ProductSelectHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_selectedCollectionView registerClass:[ProductSelectFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
     [_selectedCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"temp"];
    
}

/**
 购买菜单
 */
- (void)createMainBuyMenuView{
    
    _mainBuyMenuView = [ProductBuyMenuView new];
    //    _mainBuyMenuView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_mainBuyMenuView];
    [_mainBuyMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ProductBuyMenu_Height);
    }];
    _mainBuyMenuView.currentStatus = ProductBuyMenuStatusNoAdd;
    
}

#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Value *valueModel = [self getValueModelWithSection:indexPath.section Row:indexPath.row];
    NSString *name = [valueModel.mj_keyValues objectForKey:@"name"];
    CGFloat cell_width = [self settingCollectionViewItemWidthBoundingWithText:[NSString stringWithFormat:@"%@", name]];
    return CGSizeMake(cell_width, 30);
    
}


#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _allSkuListModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if ((section + 1) == _allSkuListModelArray.count) {
        return CGSizeMake(self.view.frame.size.width, 80);
    }
    
    return CGSizeMake(self.view.frame.size.width, 0.01);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    SkuList *skuListModel = [self getSkuListModelWithSection:section];
    return skuListModel.value.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Value *valueModel =  [self getValueModelWithSection:indexPath.section Row:indexPath.row];
    [cell updateCellDataWithValueModel:valueModel selectedSkuId:currentSelectedSkuId];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //头部
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ProductSelectHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        SkuList *skuListModel = [self getSkuListModelWithSection:indexPath.section];
        headerView.title = [NSString stringWithFormat:@"%@", skuListModel.classify];
        return headerView;
    }
    //尾部
    if ([kind isEqualToString:UICollectionElementKindSectionFooter] && ((indexPath.section + 1) == _allSkuListModelArray.count)) {
        ProductSelectFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footerView;
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"temp" forIndexPath:indexPath];
    
}


#pragma mark -UICollectionViewDelegate
//单选
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    Value *valueModel = [self getValueModelWithSection:indexPath.section Row:indexPath.row];
    currentSelectedSkuId = [[valueModel.mj_keyValues objectForKey:@"skuId"] integerValue];
    [self reloadAllData];
    
}


//计算文字宽度
- (CGFloat)settingCollectionViewItemWidthBoundingWithText:(NSString *)text{
    //1,设置内容大小  其中高度一定要与item一致,宽度度尽量设置大值
    CGSize size = CGSizeMake(MAXFLOAT, 20);
    //2,设置计算方式
    //3,设置字体大小属性   字体大小必须要与label设置的字体大小一致
    NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGRect frame = [text boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil];
    //4.添加间距
    return frame.size.width + 15;
}


#pragma mark -Action

- (void)allCloseActionHandler{
    
    if ([self.delegate respondsToSelector:@selector(productDetailSelectCloseActionWithValue:)]) {
        [self.delegate productDetailSelectCloseActionWithValue:nil];
    }

}

#pragma mark -HandlerData
/**
 获取SkuList
 */
- (SkuList *)getSkuListModelWithSection:(NSInteger)section{
    SkuList *skuListModel = [_allSkuListModelArray objectAtIndex:section];
    return skuListModel;
}

/**
 获取Value
 */
- (Value *)getValueModelWithSection:(NSInteger)section Row:(NSInteger)row{
    SkuList *skuListModel = [_allSkuListModelArray objectAtIndex:section];
    Value *valueModel = [skuListModel.value objectAtIndex:row];
    return valueModel;
}

#pragma mark -ReloadData
/**
 刷新数据
 */
- (void)reloadAllData{
    
    _productPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", _productDetailModel.price];
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:_productDetailModel.item.image]];
    _productCommissionLabel.text = [NSString stringWithFormat:@"skuId: %ld", currentSelectedSkuId];
    [_selectedCollectionView reloadData];
    
}
@end
