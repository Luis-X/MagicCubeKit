//
//  ProductDetailSaleViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductDetailSaleViewController.h"
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
        self.contentSizeInPopup = CGSizeMake(Screen_width, 450 * HOME_IPHONE6_HEIGHT);
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
    [self.view addSubview:_mainHeaderView];
    [_mainHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(66 * HOME_IPHONE6_HEIGHT);
    }];
    
    UILabel *closeButton = [UILabel new];
    closeButton.textAlignment = NSTextAlignmentCenter;
    closeButton.font = [UIFont fontWithName:@"iconfont" size:14 * HOME_IPHONE6_HEIGHT];
    closeButton.text = @"\U0000e6e8";
    closeButton.textColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    closeButton.userInteractionEnabled = YES;
    [closeButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allCloseActionHandler)]];
    [_mainHeaderView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mainHeaderView);
        make.right.equalTo(_mainHeaderView);
        make.width.height.mas_equalTo(44 * HOME_IPHONE6_HEIGHT);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"促销活动";
    titleLabel.font = [UIFont systemFontOfSize:16 * HOME_IPHONE6_HEIGHT];
    titleLabel.textColor = [UIColor colorWithRed:0.10 green:0.07 blue:0.06 alpha:1.00];
    [_mainHeaderView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_mainHeaderView);
    }];
    
    UIView *blackLine = [UIView new];
    blackLine.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    [_mainHeaderView addSubview:blackLine];
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_mainHeaderView);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)createMainTableView{
    
    _mainTableView = [UITableView new];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.fd_debugLogEnabled = NO;       //打开自适应高度debug模式
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
