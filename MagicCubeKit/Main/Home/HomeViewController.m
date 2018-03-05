//
//  HomeViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseTableViewCell.h"
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController{
    NSArray *_menuArray;
    UITableView *_mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"首页";
    [self initailData];
    [self createMainViews];
    
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        NSLog(@"设备为 iPad");
    }
    
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        NSLog(@"设备为 iPhone");
    }

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
    _menuArray = @[@{@"ViewController调用机制" : @"UIViewController"},
                   @{@"七巧板界面动态化" : @"Tangram" },
                   @{@"录屏、截屏" : @"SJBugVideoKit"},
                   @{@"弹框" : @"MagicAlertView"},
                   @{@"权限" : @"MagicPermissionManager"},
                   @{@"网络请求" : @"MagicNetworkManager"},
                   @{@"icon按钮" : @"MagicIconButton"},
                   @{@"滚动分页" : @"MagicScrollPage"},
                   @{@"图片下载" : @"MagicImageDownloader"},
                   @{@"网页进度条" : @"MagicWebProgress"},
                   @{@"加载动画" : @"MagicLoading"},
                   @{@"持续倒计时" : @"MagicTimerManager"},
                   @{@"JS交互" : @"WebViewJavascriptBridge"},
                   @{@"网络状态" : @"Reachability"},
                   @{@"3D卡片" : @"iCarousel"},
                   @{@"气泡" : @"WYPopoverController"},
                   @{@"列表高度自适应" : @"UITableView+FDTemplateLayoutCell"},
                   @{@"WebView优化" : @"ExampleMagicWebViewController"},
                   @{@"UIView绘制" : @"ExampleDrawViewController"},
                   @{@"快速创建列表" : @"ExampleXLFormViewController"},
                   @{@"选择器" : @"ExampleActionSheetPicker3"}];
}

- (void)createMainViews{
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [self.view addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
        
    }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        [cell baseSelectedBackgroudColor:[UIColor randomFlatColor]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *menuDic = [_menuArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [menuDic.allKeys firstObject];
    cell.textLabel.font = MC_FONT_SYSTEM_BOLD(16);
    cell.detailTextLabel.text = [menuDic.allValues firstObject];
    cell.detailTextLabel.textColor = [UIColor flatBlueColor];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}

#pragma mark - 分割线顶头
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)viewDidLayoutSubviews {
    [_mainTableView setSeparatorInset:UIEdgeInsetsZero];
    [_mainTableView setLayoutMargins:UIEdgeInsetsZero];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *routerSkipString = [NSString string];
        NSDictionary *data = @{@"1" : @"1", @"哈哈哈" : @"2"};
        
        switch (indexPath.row) {
            case 0:
                routerSkipString = R_URL_NORMAL(@"ViewController");
                break;
            case 1:
                routerSkipString = R_URL_NORMAL(@"ExampleTangramViewController");
                break;
            case 2:
                routerSkipString = R_URL_NORMAL(@"ExampleSJBugVideoKitViewController");
                break;
            case 3:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicAlertViewViewController");
                break;
            case 4:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicPermissionManagerViewController");
                break;
            case 5:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicNetworkingViewController");
                break;
            case 6:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicButtonViewController");
                break;
            case 7:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicScrollPageViewController");
                break;
            case 8:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicImageDownloaderViewController");
                break;
            case 9:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicWebProgressViewController");
                break;
            case 10:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicLoadingViewController");
                break;
            case 11:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicTimerButtonViewController");
                break;
            case 12:
                routerSkipString = R_URL_NORMAL(@"ExampleWebViewJavascriptBridgeViewController");
                break;
            case 13:
                routerSkipString = R_URL_NORMAL(@"ExampleReachabilityViewController");
                break;
            case 14:
                routerSkipString = R_URL_NORMAL(@"ExampleiCarouselViewController");
                break;
            case 15:
                routerSkipString = R_URL_NORMAL(@"ExampleWYPopoverControllerViewController");
                break;
            case 16:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicDynamicViewController");
                break;
            case 17:
                routerSkipString = R_URL_NORMAL(@"ExampleMagicWebViewController");
                break;
            case 18:
                routerSkipString = R_URL_NORMAL(@"ExampleDrawViewController");
                break;
            case 19:
                routerSkipString = R_URL_NORMAL(@"ExampleXLFormViewController");
                break;
            case 20:
                routerSkipString = R_URL_NORMAL(@"ExampleActionSheetPicker3ViewController");
                break;
            default:
                break;
        }
        
        [MagicRouterManager showAnyViewControllerWithRouterURL:routerSkipString data:@{@"哈哈" : @"啊"} addedNavigationController:self.navigationController];
    }
    
}


#pragma mark - 判断设备类型以及取得位置信息
// 当width或height的regular、compact发生变化时调用
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        NSLog(@"Compact Width");
    }
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        NSLog(@"Regular Width");
    }
    if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        NSLog(@"Compact Height");
    }
    if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        NSLog(@"Regular Height");
    }
}

// 当width或height的分辨率改变时调用
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"横向, 顶端, 左");
    }
    if (orientation == UIDeviceOrientationLandscapeRight) {
        NSLog(@"横向, 顶端, 右");
    }
    if (orientation == UIDeviceOrientationPortrait) {
        NSLog(@"竖向, 顶端, 上");
    }
    if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"竖向, 顶端, 下");
    }
    if (orientation == UIDeviceOrientationUnknown) {
        NSLog(@"方向未知");
    }
    NSLog(@"分辨率为 %.0f X %.0f", size.width, size.height);
    
}
@end
