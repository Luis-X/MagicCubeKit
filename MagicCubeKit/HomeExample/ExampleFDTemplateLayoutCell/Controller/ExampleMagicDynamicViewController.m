//
//  ExampleMagicDynamicViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicDynamicViewController.h"
#import "ExampleMagicDynamicModel.h"
#import "ExampleMagicDynamicTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ExampleMagicDynamicViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ExampleMagicDynamicViewController{
    NSMutableArray *_allDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UITableView+FDTemplateLayoutCell";
    [self initailData];
    [self createMianViews];
    [self networkGetLocalExampleData];
}

- (void)initailData{
    _allDataArr = [NSMutableArray array];
}

- (void)createMianViews{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.fd_debugLogEnabled = YES;       //打开自适应高度debug模式
    [self.view addSubview:myTableView];
    [myTableView registerClass:[ExampleMagicDynamicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExampleMagicDynamicTableViewCell *cell = (ExampleMagicDynamicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allDataArr.count;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self setupModelOfCell:cell AtIndexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

#warning 重点(自适应高度必须实现)
//预加载Cell内容
- (void)setupModelOfCell:(ExampleMagicDynamicTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.model = [_allDataArr objectAtIndex:indexPath.row];
}








#pragma mark - 虚拟数据
- (void)networkGetLocalExampleData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ExampleMagicDynamic" ofType:@"plist"];
    NSArray *findViewArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    for (NSDictionary *dic in findViewArr) {
        ExampleMagicDynamicModel *model = [ExampleMagicDynamicModel new];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *userDic = [dic objectForKey:@"userInfo"];
        model.userID = [NSString stringWithFormat:@"%@", [userDic objectForKey:@"userID"]];
        model.userImage = [NSString stringWithFormat:@"%@", [userDic objectForKey:@"userImage"]];
        model.userName = [NSString stringWithFormat:@"%@", [userDic objectForKey:@"userName"]];
        [_allDataArr addObject:model];
    }
}
@end
