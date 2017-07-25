//
//  AutoAlbumListViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/23.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "AutoAlbumListViewController.h"
#import "AutoAlbumViewController.h"
#import "MagicImagePicker.h"

@interface AutoAlbumListViewController ()<UITableViewDelegate, UITableViewDataSource, MagicImagePickerDelegate>

@end

@implementation AutoAlbumListViewController{
    NSMutableArray *_allMenuArray;
    UITableView *_mainTableView;
    UIImageView *_mainBGImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initailData];
    [self createMainViews];
    [self networkGetAutoAlbumData];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"宣传图";
    _allMenuArray = [NSMutableArray array];
}

- (void)createMainViews{
    
    _mainBGImageView = [UIImageView new];
    _mainBGImageView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.80];
    _mainBGImageView.contentMode = 1;
    _mainBGImageView.clipsToBounds = YES;
    _mainBGImageView.image = [UIImage imageNamed:@"autoBackground.png"];
    [self.view addSubview:_mainBGImageView];
    [_mainBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.centerX.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"替换背景" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainBGImageView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(44);
    }];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [self.view addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.view);
    }];
    
}

- (void)networkGetAutoAlbumData{
    
    [_allMenuArray removeAllObjects];
    
    
    [QuicklyHUD showWindowsProgressHUDText:@"请稍后..."];
    [[MagicNetworkManager shareManager] GET:@"https://shop.m.showjoy.com/shop/foreshow/get" Parameters:nil Success:^(NSURLResponse *response, id responseObject) {
        
        //解析
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            for (NSString *key in dataDic.allKeys) {
                [_allMenuArray addObject:key];
            }
        }
        
        [_mainTableView reloadData];
         [QuicklyHUD hiddenMBProgressHUDForView:[UIApplication sharedApplication].keyWindow];
        
    } Failure:^(NSURLResponse *response, id error) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"网络请求失败"];
        
    }];
    
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_allMenuArray objectAtIndex:indexPath.row]];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allMenuArray.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_mainBGImageView.image == nil) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"请先设置背景图"];
        return;
    }
    
    AutoAlbumViewController *vc = [AutoAlbumViewController new];
    NSString *option_key = [NSString stringWithFormat:@"%@", [_allMenuArray objectAtIndex:indexPath.row]];
    [vc networkGetAutoAlbumDataWithKey:option_key backgroundImage:_mainBGImageView.image];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Action
- (void)buttonAction{
    [[MagicImagePicker shareManager] showImagePickerWithTitle:@"背景图" message:@"请选择一张背景图" addController:self delegate:self];
}

#pragma mark - MagicImagePickerDelegate
- (void)magicSystemImagePickerDidCancel{
    [QuicklyHUD showWindowsOnlyTextHUDText:@"已取消"];
}

- (void)magicSystemImagePickerDidFinishPickingMediaWithImage:(UIImage *)image{
    if (image) {
        _mainBGImageView.image = image;
        [QuicklyHUD showWindowsOnlyTextHUDText:@"替换完成"];
    }else{
        [QuicklyHUD showWindowsOnlyTextHUDText:@"替换失败"];
    }
}
@end
