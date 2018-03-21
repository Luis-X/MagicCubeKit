//
//  LaboratoryViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "LaboratoryViewController.h"
#import "ProductDetailMenuViewController.h"
#import "AutoAlbumListViewController.h"
#import "HomePageViewController.h"
#import "ExamplePagerViewController.h"
#import "BalloonRefreshHeader.h"
#import "ExampleWebPlaceholderViewController.h"
#import "ExampleWebPageAlertViewController.h"
#import "ProductLoadMoreViewController.h"

@interface LaboratoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LaboratoryViewController{
    NSArray *_menuArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"实验室";
    [self initailData];
    [self createMainViews];
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
    _menuArray = @[@{@"ProductDetailMenuViewController" : @"商品详情"},
                   @{@"AutoAlbumViewController" : @"自动生成图片"},
                   @{@"HomePageViewController" : @"首页列表"},
                   @{@"WeexPagerViewController" : @"UIScrollview重用"},
                   @{@"ExampleWebPlaceholderViewController" : @"WebView网络异常"},
                   @{@"ExampleWebPageAlertViewController" : @"WebView弹框"},
                   @{@"ProductLoadMoreViewController" : @"详情图-(htmlString+webp+native)"},
                   @{@"MagicAlbumPicker" : @"多选相册"}];
}

- (void)createMainViews{
    
    BaseTableView *mainTableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    mainTableView.backgroundColor = [UIColor whiteColor];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
    
    [mainTableView baseClearUnnecessaryRow];
    
    //下拉刷新
    BalloonRefreshHeader *header = [BalloonRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [mainTableView.mj_header endRefreshing];
        });
    }];
    mainTableView.mj_header = header;
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    NSDictionary *menuDic = [_menuArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [menuDic.allKeys firstObject];
    cell.detailTextLabel.text = [menuDic.allValues firstObject];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSArray *viewControllers = @[[ProductDetailViewController class], [ExampleMagicNetworkingViewController class]];
            NSArray *titles = @[@"详情", @"素材"];
            ProductDetailMenuViewController *vc = [[ProductDetailMenuViewController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            AutoAlbumListViewController *autoAlbumViewController = [AutoAlbumListViewController new];
            autoAlbumViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:autoAlbumViewController animated:YES];
        }
        if (indexPath.row == 2) {
            HomePageViewController *homePageViewController = [HomePageViewController new];
            homePageViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:homePageViewController animated:YES];
        }
        if (indexPath.row == 3) {
            ExamplePagerViewController *homePageViewController = [ExamplePagerViewController new];
            homePageViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:homePageViewController animated:YES];
        }
        if (indexPath.row == 4) {
            ExampleWebPlaceholderViewController *webPlaceholderViewController = [ExampleWebPlaceholderViewController new];
            webPlaceholderViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webPlaceholderViewController animated:YES];
        }
        if (indexPath.row == 5) {
            ExampleWebPageAlertViewController *webPageAlertViewController = [ExampleWebPageAlertViewController new];
            webPageAlertViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webPageAlertViewController animated:YES];
        }
        if (indexPath.row == 6) {
            ProductLoadMoreViewController *productLoadMoreViewController = [ProductLoadMoreViewController new];
            productLoadMoreViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:productLoadMoreViewController animated:YES];
        }
        if (indexPath.row == 7) {
            [self presentAlbumViewControllerWithTitle:@"照片"];
        }
    }
    
}

- (void)presentAlbumViewControllerWithTitle:(NSString *)title
{
    MCAlbumViewController *albumViewController = [[MCAlbumViewController alloc] init];
    albumViewController.albumViewControllerDelegate = self;
    albumViewController.title = title;
    QMUINavigationController *navigationController = [[QMUINavigationController alloc] initWithRootViewController:albumViewController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - <QMUIAlbumViewControllerDelegate>
// 进入相册
- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController
{
    MCImagePickerViewController *imagePickerViewController = [[MCImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.allowsMultipleSelection = YES;
    imagePickerViewController.maximumSelectImageCount = 3;
    return imagePickerViewController;
}

// 预览（选择完成）
- (void)imagePickerPreviewViewController:(MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    [self allImageSelectedHandlerWithImagesAssetArray:imagesAssetArray];
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>
// 相册（选择完成）
- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
   [self allImageSelectedHandlerWithImagesAssetArray:imagesAssetArray];
}

// 进入预览
- (QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController
{
    MCMultipleImagePickerPreviewViewController *imagePickerPreviewViewController = [[MCMultipleImagePickerPreviewViewController alloc] init];
    imagePickerPreviewViewController.delegate = self;
    imagePickerPreviewViewController.maximumSelectImageCount = 9;
    imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
    return imagePickerPreviewViewController;
}

#pragma mark - <QMUIImagePickerPreviewViewControllerDelegate>
// 预览（勾选）
- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index
{
    MCMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
    [customImagePickerPreviewViewController reloadSendButtonTitlte];
}

// 预览（取消）
- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didUncheckImageAtIndex:(NSInteger)index
{
    MCMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (MCMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
     [customImagePickerPreviewViewController reloadSendButtonTitlte];
}

#pragma mark - 处理选择完成
- (void)allImageSelectedHandlerWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray
{
    for (QMUIAsset *qmUIAsset in imagesAssetArray) {
        UIImage *image = [qmUIAsset originImage];
    }
}

@end
