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
                   @{@"快速创建列表" : @"ExampleXLFormViewController"}];
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
        
        switch (indexPath.row) {
            case 0:
                routerSkipString = Router_Skip_ViewController;
                break;
            case 1:
                routerSkipString = Router_Skip_ExampleTangramViewController;
                break;
            case 2:
                routerSkipString = Router_Skip_ExampleSJBugVideoKitViewController;
                break;
            case 3:
                routerSkipString = Router_Skip_ExampleMagicAlertViewViewController;
                break;
            case 4:
                routerSkipString = Router_Skip_ExampleMagicPermissionManagerViewController;
                break;
            case 5:
                routerSkipString = Router_Skip_ExampleMagicNetworkingViewController;
                break;
            case 6:
                routerSkipString = Router_Skip_ExampleMagicButtonViewController;
                break;
            case 7:
                routerSkipString = Router_Skip_ExampleMagicScrollPageViewController;
                break;
            case 8:
                routerSkipString = Router_Skip_ExampleMagicImageDownloaderViewController;
                break;
            case 9:
                routerSkipString = Router_Skip_ExampleMagicWebProgressViewController;
                break;
            case 10:
                routerSkipString = Router_Skip_ExampleMagicLoadingViewController;
                break;
            case 11:
                routerSkipString = Router_Skip_ExampleMagicTimerButtonViewController;
                break;
            case 12:
                routerSkipString = Router_Skip_ExampleWebViewJavascriptBridgeViewController;
                break;
            case 13:
                routerSkipString = Router_Skip_ExampleReachabilityViewController;
                break;
            case 14:
                routerSkipString = Router_Skip_ExampleiCarouselViewController;
                break;
            case 15:
                routerSkipString = Router_Skip_ExampleWYPopoverControllerViewController;
                break;
            case 16:
                routerSkipString = Router_Skip_ExampleMagicDynamicViewController;
                break;
            case 17:
                routerSkipString = Router_Skip_ExampleMagicWebViewController;
                break;
            case 18:
                routerSkipString = Router_Skip_ExampleDrawViewController;
                break;
            case 19:
                routerSkipString = Router_Skip_ExampleXLFormViewController;
                break;
            default:
                break;
        }
        [MagicRouterManager showAnyViewControllerWithRouterURL:routerSkipString AddedNavigationController:self.navigationController];
    }
    
}

@end
