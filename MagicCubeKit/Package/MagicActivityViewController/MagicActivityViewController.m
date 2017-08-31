//
//  MagicActivityViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#define MC_CANCLE_BUTTON_H 50       //取消高度
#define MC_MAX_ITEM_COUNT  4        //每行最大数量

#import "MagicActivityViewController.h"
#import <STPopup.h>
#import "MagicActivityCollectionViewCell.h"

@interface MagicActivityViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, MagicActivityCollectionViewCellDelegate>
@property(nonatomic, copy) MagicActivityCompletion completion;
@property(nonatomic, strong) NSMutableArray *allActivityItems;
@property(nonatomic, assign) NSInteger maxItemCount;
@property(nonatomic, strong) UIView *topCustomView;
@property(nonatomic, assign) CGFloat itemHeight;
@end

@implementation MagicActivityViewController{
    UICollectionView *_mainCollectionView;
    UIButton *_cancleButton;
}

//重写初始化方法
- (instancetype)initContentSizeInPopup:(CGSize)contentSize{
    if (self = [super init]) {
        self.contentSizeInPopup = contentSize;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:1.00 alpha:0.95];
    [self configPopupControllerStyle];
    [self createMainSubviews];
    [self createMainLayout];
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

#pragma mark----实现类方法
+ (instancetype)presentAddViewController:(UIViewController *)addViewController topCustomView:(UIView *)topCustomView activitys:(NSArray *)activitys activityHeight:(CGFloat)activityHeight completion:(MagicActivityCompletion)completion{
    
    if (!activitys.count) {
        return nil;
    }
    
    CGSize contentSize = CGSizeMake(CGRectGetWidth(addViewController.view.frame), CGRectGetHeight(topCustomView.frame) + MC_CANCLE_BUTTON_H + activityHeight);

    MagicActivityViewController *vc = [[MagicActivityViewController alloc] initContentSizeInPopup:contentSize];
    vc.allActivityItems = [NSMutableArray arrayWithArray:activitys];
    vc.maxItemCount = MC_MAX_ITEM_COUNT;           //超出滑动
    vc.topCustomView = topCustomView;
    vc.itemHeight = activityHeight;
    vc.completion = completion;
    STPopupController *stPopupController = [[STPopupController alloc] initWithRootViewController:vc];
    [stPopupController presentInViewController:addViewController];
    return vc;
    
}

#pragma mark - Config
- (void)configPopupControllerStyle{
    self.popupController.style = STPopupStyleBottomSheet;
    self.popupController.transitionStyle = STPopupTransitionStyleSlideVertical;
    self.popupController.containerView.backgroundColor = [UIColor clearColor];
    self.popupController.containerView.layer.cornerRadius = 0;
    self.popupController.backgroundView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.70];
    self.popupController.navigationBarHidden = YES;
    [self.popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissActivityViewController)]];
}

#pragma mark - UI
- (void)createMainSubviews{
    [self createMainCancleButton];
    [self createMainCollectionView];
}

- (void)createMainLayout{
    
    [self.view addSubview:_topCustomView];
    if (_topCustomView) {
        [_topCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(_topCustomView.frame.size.height);
        }];
    }
    
    [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(MC_CANCLE_BUTTON_H);
    }];
 
    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_topCustomView) {
            make.top.equalTo(_topCustomView.mas_bottom);
        }else{
            make.top.equalTo(self.view);
        }
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_cancleButton.mas_top);
    }];
    
}

- (void)createMainCollectionView{
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake([self loadingMainCollectionViewItemSizeHeight], _itemHeight);
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _mainCollectionView.alwaysBounceHorizontal = YES;
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    _mainCollectionView.showsVerticalScrollIndicator = NO;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate = self;
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView registerClass:[MagicActivityCollectionViewCell class] forCellWithReuseIdentifier:@"item"];

}

- (void)createMainCancleButton{
    
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithWhite:0.25 alpha:1.00] forState:UIControlStateNormal];
    _cancleButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cancleButton];
    [_cancleButton addTarget:self action:@selector(dismissActivityViewController) forControlEvents:UIControlEventTouchUpInside];
    
}


- (CGFloat)loadingMainCollectionViewItemSizeHeight{
    NSInteger dividend = (_allActivityItems.count < _maxItemCount) ? _allActivityItems.count : _maxItemCount;
    CGFloat result = self.view.frame.size.width / dividend;
    return result;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allActivityItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MagicActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    cell.magicActivityItem = [_allActivityItems objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissActivityViewController];
}

#pragma mark - Action
- (void)dismissActivityViewController{
    [self.popupController dismiss];
}

#pragma mark - MagicActivityCollectionViewCellDelegate
- (void)magicActivityCollectionViewCellDidSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.completion) {
        self.completion(indexPath.row);
    }
    [self dismissActivityViewController];
}
@end
