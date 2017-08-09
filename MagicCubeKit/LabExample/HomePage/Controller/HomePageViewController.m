//
//  HomePageViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeMainPageTableViewCell.h"

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation HomePageViewController{
    NSMutableArray *_allSkuModelArr;        //所有Model数据
    UITableView *_mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initailData];
    [self createMainTableView];
}

- (void)initailData{
    
    _allSkuModelArr = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    
}

//主框架
- (void)createMainTableView{
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [self.view addSubview:_mainTableView];
    [_mainTableView registerClass:[HomeMainPageTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    /*
     [self addMainFooterRefreshing];
     */
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

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeMainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
    
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_allSkuModelArr.count > 0) {
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

@end
