//
//  ExampleMagicDynamicViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/26.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicDynamicViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ExampleMagicDynamicModel.h"
#import "ExampleMagicDynamicTableViewCell.h"
#import "ExampleMagicCenterTagTableViewCell.h"

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
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [myTableView registerClass:[ExampleMagicDynamicTableViewCell class] forCellReuseIdentifier:@"dynamicCell"];
    [myTableView registerClass:[ExampleMagicCenterTagTableViewCell class] forCellReuseIdentifier:@"tagCell"];
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
    if (indexPath.row < 1) {
        ExampleMagicDynamicTableViewCell *cell = (ExampleMagicDynamicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dynamicCell" forIndexPath:indexPath];
        [self setupModelOfCell:cell AtIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.row > 1) {
        ExampleMagicCenterTagTableViewCell *cell = (ExampleMagicCenterTagTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"tagCell" forIndexPath:indexPath];
        [self setupModelOfCenterTagCell:cell AtIndexPath:indexPath];
        return cell;
    }
    
    
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allDataArr.count;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 1) {
        return [tableView fd_heightForCellWithIdentifier:@"dynamicCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self setupModelOfCell:cell AtIndexPath:indexPath];
        }];
    }
    
    if (indexPath.row > 1) {
        return [tableView fd_heightForCellWithIdentifier:@"tagCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self setupModelOfCenterTagCell:cell AtIndexPath:indexPath];
        }];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#warning 重点(自适应高度必须实现)
//预加载Cell内容
- (void)setupModelOfCell:(ExampleMagicDynamicTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.model = [_allDataArr objectAtIndex:indexPath.row];
}

- (void)setupModelOfCenterTagCell:(ExampleMagicCenterTagTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    cell.allTagsArray = @[@"复盘后我恢复婆娘", @"画法几何地方", @"家分店", @"发配去诶陪我瑞我确认UI五日偶尔无人", @"哈哈哈", @"爱机打发票", @"1324"];
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
