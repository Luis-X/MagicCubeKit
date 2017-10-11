//
//  ExamplePagerViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/22.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExamplePagerViewController.h"
#import "PagerViewController.h"

@interface ExamplePagerViewController ()<UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *allControllerArray;
@end


@implementation ExamplePagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //构造数据
    _allControllerArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        PagerViewController *vc = [PagerViewController new];
        [vc willMoveToParentViewController:self];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [_allControllerArray addObject:vc];
    }
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.view.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(300, 300);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat collectionViewX = (CGRectGetWidth(self.view.frame) - 300) / 2;
    CGFloat collectionViewY = 100;
    CGFloat collectionViewW = 300;
    CGFloat collectionViewH = 300;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];

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

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _allControllerArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    PagerViewController *vc = [_allControllerArray objectAtIndex:indexPath.row];
    vc.view.frame = cell.contentView.frame;
    vc.pageLabel.text = [NSString stringWithFormat:@"第%ld页", indexPath.row];
    [cell.contentView addSubview:vc.view];
    return cell;
    
}


@end
