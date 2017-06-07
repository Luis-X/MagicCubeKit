//
//  ProductDetailSaleViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductDetailSaleViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <STPopup.h>
#import "ProductSaleTableViewCell.h"

@interface ProductDetailSaleViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UIView *_mainHeaderView;
    UITableView *_mainTableView;
}

@end

@implementation ProductDetailSaleViewController

//重写初始化方法
- (instancetype)init{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(Magic_screen_Width, Magic_screen_Height - 400);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMainView];
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

- (void)createMainView{
    [self createMainHeaderView];
    [self createMainTableView];
}

- (void)createMainHeaderView{
    
    _mainHeaderView = [UIView new];
    //_mainHeaderView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_mainHeaderView];
    [_mainHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *closeButton = [UILabel new];
    closeButton.font = [UIFont fontWithName:@"iconfont" size:20];
    closeButton.text = @"\U0000e646";
    closeButton.userInteractionEnabled = YES;
    [closeButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allCloseActionHandler)]];
    [_mainHeaderView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mainHeaderView);
        make.right.equalTo(_mainHeaderView).offset(-10);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"促销活动";
    [_mainHeaderView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mainHeaderView);
        make.left.equalTo(_mainHeaderView).offset(10);
        make.right.mas_lessThanOrEqualTo(closeButton.mas_left).offset(-10);
    }];
    
}

- (void)createMainTableView{
    
    _mainTableView = [UITableView new];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.fd_debugLogEnabled = NO;       //打开自适应高度debug模式
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [self.view addSubview:_mainTableView];
    [_mainTableView registerClass:[ProductSaleTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainHeaderView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];

}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductSaleTableViewCell *infomationCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self setupIntroduceModelOfCell:infomationCell AtIndexPath:indexPath];
    return infomationCell;

}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self allCloseActionHandler];
}

#pragma mark -重点 自适应高度必须实现
//预加载
- (void)setupIntroduceModelOfCell:(ProductSaleTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark -Action
- (void)allCloseActionHandler{
    
    if ([self.delegate respondsToSelector:@selector(productDetailSaleCloseActionWithValue:)]) {
        [self.delegate productDetailSaleCloseActionWithValue:nil];
    }
    
}

@end
