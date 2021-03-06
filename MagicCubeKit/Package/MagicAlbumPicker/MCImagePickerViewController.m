//
//  MCImagePickerViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2018/3/15.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import "MCImagePickerViewController.h"
#import "MagicAlbumPickerManager.h"

@interface MCImagePickerViewController ()
@property(nonatomic, strong) NSMutableArray *signAssetArray;
@end

@implementation MCImagePickerViewController

- (void)initSubviews
{
    [super initSubviews];
    self.minimumImageWidth = 90.0f;
    [QMUIAlertController appearance].alertCancelButtonAttributes = @{NSForegroundColorAttributeName: MC_COLOR_RGB(26, 18, 16)};
    
     self.previewButton.titleLabel.font = UIFontMake(14);
    [self.previewButton setTitleColor:MC_COLOR_RGB(76, 76, 76) forState:UIControlStateNormal];
    [self.previewButton setTitleColor:MC_COLOR_RGB(76, 76, 76) forState:UIControlStateDisabled];
    self.previewButton.adjustsButtonWhenDisabled = NO;
    
    CGFloat sendButtonWidth = 92.5f;
    CGFloat sendButtonHeight = 30.0f;
    self.sendButton.titleLabel.font = UIFontMake(12);
    self.sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.sendButton setTitleColor:MC_COLOR_WHITE_A(1.0f) forState:UIControlStateNormal];
    [self.sendButton setTitleColor:MC_COLOR_WHITE_A(1.0f) forState:UIControlStateDisabled];
    [self.sendButton setBackgroundColor:MC_COLOR_RGB(204, 204, 204)];
    self.sendButton.adjustsButtonWhenDisabled = NO;
    [self.sendButton setTitle:@"未选择" forState:UIControlStateDisabled];
    self.sendButton.frame = CGRectMake(self.sendButton.frame.origin.x, self.sendButton.frame.origin.y, sendButtonWidth, sendButtonHeight);
    self.sendButton.layer.cornerRadius = 15.0f;
    self.sendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.imageCountLabel removeFromSuperview];
    
    [QMUIImagePickerCollectionViewCell appearance].checkboxImage = [MC_IMAGE_NAMED(@"album_picker_no_selected") qmui_imageResizedInLimitedSize:CGSizeMake(23, 23)];
    [QMUIImagePickerCollectionViewCell appearance].checkboxCheckedImage = nil;

}

// 监听 sendButton 状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"enabled"] && object == self.sendButton) {
        [self reloadSendButtonTitle];
    }
}

// 刷新显示
- (void)reloadSendButtonTitle
{
    if (self.sendButton.enabled) {
        NSInteger selectedImageCount = [self.selectedImageAssetArray count];
        [self.sendButton setTitle:MC_STRING_FORMAT(@"发送(%ld)", selectedImageCount) forState:UIControlStateNormal];
        [self.sendButton setBackgroundColor:MC_COLOR_RGB(251, 60, 76)];
    } else {
        [self.sendButton setBackgroundColor:MC_COLOR_RGB(204, 204, 204)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadCollectionViewItems)
                                                 name:@"albumReload"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadSendButtonTitle];
    [self.sendButton addObserver:self
                      forKeyPath:@"enabled"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:NULL];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadCollectionViewItems];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.sendButton removeObserver:self
                         forKeyPath:@"enabled"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"albumReload"
                                                  object:nil];
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

#pragma mark - QMUINavigationControllerDelegate

- (BOOL)shouldSetStatusBarStyleLight {
    return NO;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage qmui_imageWithColor:MC_COLOR_WHITE_A(0.95f)];
}

- (UIImage *)navigationBarShadowImage {
    return [UIImage qmui_imageWithColor:MC_COLOR_WHITE_A(0.95f) size:CGSizeMake(1, 1) cornerRadius:0.0f];
}

- (UIColor *)navigationBarTintColor {
    return MC_COLOR_RGB(26, 18, 16);
}

- (UIColor *)titleViewTintColor {
    return MC_COLOR_RGB(26, 18, 16);
}

- (void)setupNavigationItems
{
    [super setupNavigationItems];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:MC_FONT_SYSTEM(14 * MC_SCREEN_H_SCALE)} forState:UIControlStateNormal];
    [self customLeftBarButtonItem];
}

// 导航栏
- (void)customLeftBarButtonItem
{
    
    if (self.navigationController.viewControllers.count > 1) {
        UIView *leftItem = [UIView new];
        leftItem.frame = CGRectMake(0, 0, 50 * MC_SCREEN_W_SCALE, MC_NAVIGATION_BAR_H);
        [leftItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popViewController)]];
        
        UILabel *icon = [UILabel new];
        icon.textColor = MC_COLOR_RGB(26, 18, 16);
        icon.font = MC_FONT(@"iconfont", 16 * MC_SCREEN_H_SCALE);
        icon.frame = CGRectMake(0, 0, 16 * MC_SCREEN_W_SCALE, MC_NAVIGATION_BAR_H);
        icon.text = @"\U0000e6d5";
        
        UILabel *title = [UILabel new];
        title.textColor = MC_COLOR_RGB(26, 18, 16);
        title.font = MC_FONT_SYSTEM(14 * MC_SCREEN_H_SCALE);
        title.frame = CGRectMake(CGRectGetWidth(icon.frame), 0, CGRectGetWidth(leftItem.frame) - CGRectGetWidth(icon.frame), MC_NAVIGATION_BAR_H);
        title.text = @"照片";
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
        self.navigationItem.leftBarButtonItems = @[item];
    }
    
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QMUIImagePickerCollectionViewCell *cell = (QMUIImagePickerCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    if (cell.checked) {
        QMUIAsset *imageAsset = [self.imagesAssetArray objectAtIndex:indexPath.item];
        for (NSDictionary *dic  in self.signAssetArray) {
            QMUIAsset *selectedImageAsset = [dic objectForKey:@"obj"];
            NSString *num = [dic objectForKey:@"index"];
            if ([selectedImageAsset.identifier isEqualToString:imageAsset.identifier]) {
                [cell.checkboxButton setImage:[self reloadNumberIconIndex:num] forState:UIControlStateSelected];
            }
        }
    }
    return cell;
}

- (UIImage *)reloadNumberIconIndex:(NSString *)index
{
    CGFloat size = 23;
    UILabel *numlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    numlabel.textColor = MC_COLOR_WHITE_A(1.0f);
    numlabel.font = MC_FONT_SYSTEM(14);
    numlabel.textAlignment = NSTextAlignmentCenter;
    numlabel.layer.cornerRadius = size / 2;
    numlabel.layer.backgroundColor = MC_COLOR_RGB(251, 60, 76).CGColor;
    numlabel.text = index;
    return [UIImage qmui_imageWithView:numlabel];
}

#pragma mark - 刷新
- (void)reloadCollectionViewItems
{
    self.signAssetArray = nil;
    self.signAssetArray = [NSMutableArray array];
    NSMutableArray *reloadItems = [NSMutableArray array];

    [self.imagesAssetArray enumerateObjectsUsingBlock:^(QMUIAsset * _Nonnull imageAsset, NSUInteger i, BOOL * _Nonnull stop) {
        [self.selectedImageAssetArray enumerateObjectsUsingBlock:^(QMUIAsset * _Nonnull selectedImageAsset, NSUInteger j, BOOL * _Nonnull stop) {
            if ([imageAsset.identifier isEqualToString:selectedImageAsset.identifier]) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:selectedImageAsset forKey:@"obj"];
                [dic setValue:MC_STRING_FORMAT(@"%ld", j + 1) forKey:@"index"];
                [self.signAssetArray addObject:dic];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [reloadItems addObject:indexPath];
            }
        }];
    }];

    if (reloadItems.count > 0) {
        [self.collectionView reloadItemsAtIndexPaths:reloadItems];
    }
    reloadItems = nil;
}
@end
