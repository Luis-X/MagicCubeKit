//
//  LaboratoryViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "LaboratoryViewController.h"
#import "ProductDetailViewController.h"
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
    _menuArray = @[@{@"ProductDetailViewController" : @"商品详情"}];
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
            ProductDetailViewController *vc = [ProductDetailViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
