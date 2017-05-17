//
//  HomeViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController{
    NSArray *_menuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.title = @"Magic";
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
    _menuArray = @[@{@"UIViewController":@"ViewController调用机制"},
                   @{@"Tangram":@"七巧板界面动态化"},
                   @{@"SJBugVideoKit":@"录屏、截屏"},
                   @{@"MagicAlertView":@"弹框"},
                   @{@"MagicPermissionManager":@"权限"},
                   @{@"AFNetworkingViewController":@"网络"},];
}

- (void)createMainViews{
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    mainTableView.backgroundColor = [UIColor whiteColor];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [MagicRouterManager showAnyViewControllerWithRouterURL:Router_Skip_ViewController AddedNavigationController:self.navigationController];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        [MagicRouterManager showAnyViewControllerWithRouterURL:Router_Skip_ExampleTangramViewController AddedNavigationController:self.navigationController];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        [MagicRouterManager showAnyViewControllerWithRouterURL:Router_Skip_ExampleSJBugVideoKitViewController AddedNavigationController:self.navigationController];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        [MagicRouterManager showAnyViewControllerWithRouterURL:Router_Skip_ExampleMagicAlertViewViewController AddedNavigationController:self.navigationController];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        [MagicRouterManager showAnyViewControllerWithRouterURL:Router_Skip_ExampleMagicPermissionManagerViewController AddedNavigationController:self.navigationController];
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        [MagicRouterManager showAnyViewControllerWithRouterURL:Router_Skip_ExampleMagicNetworkingViewController AddedNavigationController:self.navigationController];
    }
}
@end
