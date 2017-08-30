//
//  ExampleMagicScrollPageViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicScrollPageViewController.h"
#import "MagicScrollPage.h"

#define FX_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define FX_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ExampleMagicScrollPageViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ExampleMagicScrollPageViewController{
    MagicScrollPage *_mainScrollView;        //主ScrollView
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicScrollPage";
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
    
    UITableView *firtTableView = [UITableView new];
    firtTableView.backgroundColor = [UIColor whiteColor];
    firtTableView.dataSource = self;
    firtTableView.delegate = self;
    [firtTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIScrollView *secondScrollView = [UIScrollView new];
    UILabel *textLabel = [QuicklyUI quicklyUILabelAddTo:secondScrollView];
    textLabel.text = @"Page 2";
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(secondScrollView);
    }];
    
    _mainScrollView = [MagicScrollPage showScrollPageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) firstPage:firtTableView secondPage:secondScrollView];
    [self.view addSubview:_mainScrollView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Page 1";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}
@end
