//
//  ExampleiCarouselViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/23.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleiCarouselViewController.h"
#import <iCarousel.h>

@interface ExampleiCarouselViewController ()<iCarouselDataSource, iCarouselDelegate>

@end

@implementation ExampleiCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"iCarousel";
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
    //轮播控件
    iCarousel *carousel = [iCarousel new];
    //carousel.backgroundColor = [UIColor orangeColor];
    carousel.type = iCarouselTypeRotary;            //轮播类型
    carousel.contentOffset = CGSizeMake(0, 0);      //内容偏移量
    carousel.viewpointOffset = CGSizeMake(0, 0);    //视图焦点偏移量
    
    carousel.dataSource = self;
    carousel.delegate = self;
    [self.view addSubview:carousel];
    [carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
    [carousel reloadData];
}


#pragma mark -iCarouselDataSource
/**
 轮播item数量
 */
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 10;
}

/**
 轮播item内容
 @param index   下标
 @param view    重用视图
 */
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UILabel *label = nil;
    //item内容视图
    if (view == nil){
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
        view.backgroundColor = [UIColor orangeColor];
        ((UIImageView *)view).image = [UIImage imageNamed:@"bg2.png"];
        view.contentMode = UIViewContentModeScaleToFill;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }else{
        //获取视图
        label = (UILabel *)[view viewWithTag:1];
    }
    //赋值
    label.text = [NSString stringWithFormat:@"%ld", index];
    //NSLog(@"item:%ld", index);
    return view;
}

/**
 边界占位数目
 */
- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
    return 2;
}

/**
 边界占位
 @param index   (0:前 1:后)
 @param view    重用视图
 */
- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UILabel *label = nil;
    if (view == nil){
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        view.backgroundColor = [UIColor redColor];
        ((UIImageView *)view).image = [UIImage imageNamed:@"bg1.png"];
        view.contentMode = UIViewContentModeScaleToFill;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0];
        label.tag = 1;
        [view addSubview:label];
    }else{
        label = (UILabel *)[view viewWithTag:1];
    }
    
    label.text = (index == 0)? @"[": @"]";
    //NSLog(@"占位:%ld", index);
    return view;
}


/**
 轮播显示设置
 @param option 项目
 @param value 值
 */
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    if (option == iCarouselOptionWrap) {      //是否轮播
        return NO;
    }
    if (option == iCarouselOptionSpacing) {   //item之间距离  (value * 参数)
        return value * 1.1;
    }
    if (option == iCarouselOptionRadius) {    //轮播半径范围   (value * 参数)
        return value * 1;
    }
    if (option == iCarouselOptionArc) {       //当前item与其他弧度  (2 * M_PI * 参数)
        return 2 * M_PI * 0.3;
    }
    if (option == iCarouselOptionTilt) {      //倾斜角度
        
    }
    return value;
}

#pragma mark -iCarouselDelegate
/**
 选中item
 @param index 下标
 */
- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"Tapped view number: %ld", index);
}

/**
 显示item
 */
- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel{
    NSLog(@"Index: %@", @(carousel.currentItemIndex));
}

@end
