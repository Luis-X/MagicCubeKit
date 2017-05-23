//
//  ExampleTangramViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleTangramViewController.h"
#import "TangramView.h"
#import "TangramDefaultDataSourceHelper.h"
#import "TangramDefaultItemModelFactory.h"

@interface ExampleTangramViewController ()<TangramViewDatasource>
@property (nonatomic, strong) NSMutableArray *layoutModelArray;
@property (nonatomic, strong) TangramView    *tangramView;
@property (nonatomic, strong) NSArray *layoutArray;
@property  (nonatomic, strong) TangramBus *tangramBus;
@end

@implementation ExampleTangramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"Tangram";
    [self initialData];
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

- (void)initialData{
    
}

- (void)createMainView{
    //获取数据
    NSString *jsonString = [NSString stringWithContentsOfFile:Magic_bundle(@"exampleTangram", @"json") encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.layoutModelArray = [[dic objectForKey:@"data"] objectForKey:@"cards"];
    
    [TangramDefaultItemModelFactory registElementType:@"1" className:@"ExampleElementImage"];
    [TangramDefaultItemModelFactory registElementType:@"2" className:@"ExampleElementText"];
    self.layoutArray = [TangramDefaultDataSourceHelper layoutsWithArray:self.layoutModelArray tangramBus:self.tangramBus];
    
    //刷新视图
    [self.tangramView reloadData];
}

#pragma mark -TangramViewDatasource
//返回layout个数
- (NSUInteger)numberOfLayoutsInTangramView:(TangramView *)view{
    return self.layoutModelArray.count;
}

//返回layout实例
- (UIView<TangramLayoutProtocol> *)layoutInTangramView:(TangramView *)view atIndex:(NSUInteger)index{
    return [self.layoutArray objectAtIndex:index];
}

//返回某一个layout中itemModel的个数
- (NSUInteger)numberOfItemsInTangramView:(TangramView *)view forLayout:(UIView<TangramLayoutProtocol> *)layout{
    return layout.itemModels.count;
}

//返回layout中指定index的itemModel实例
- (NSObject<TangramItemModelProtocol> *)itemModelInTangramView:(TangramView *)view forLayout:(UIView<TangramLayoutProtocol> *)layout atIndex:(NSUInteger)index{
    return [layout.itemModels objectAtIndex:index];
}

//根据Model生成View
//以上的方法在调用Tangram的reload方法后就会执行，而这个方法是按需加载
- (UIView *)itemInTangramView:(TangramView *)view withModel:(NSObject<TangramItemModelProtocol> *)model forLayout:(UIView<TangramLayoutProtocol> *)layout atIndex:(NSUInteger)index{
    
    //先尝试找可以复用的View，有的话就赋值，没有的话就生成一个
    UIView *reuseableView = [view dequeueReusableItemWithIdentifier:model.reuseIdentifier];
    
    if (reuseableView) {
        reuseableView =  [TangramDefaultDataSourceHelper refreshElement:reuseableView byModel:model layout:layout tangramBus:self.tangramBus];
    }else{
        reuseableView =  [TangramDefaultDataSourceHelper elementByModel:model layout:layout tangramBus:self.tangramBus];
    }
    return reuseableView;
    
}

#pragma mark - 懒加载
- (TangramBus *)tangramBus{
    if (nil == _tangramBus) {
        _tangramBus = [[TangramBus alloc]init];
    }
    return _tangramBus;
}

- (TangramView *)tangramView{
    if (nil == _tangramView) {
        _tangramView = [[TangramView alloc]init];
        _tangramView.frame = self.view.bounds;
        //要设置datasouce delegate
        [_tangramView setDataSource:self];
        _tangramView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tangramView];
    }
    return _tangramView;
}
@end
