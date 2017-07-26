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
                   @{@"AutoAlbumViewController" : @"自动生成图片"}];
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
    }
    
}

@end
