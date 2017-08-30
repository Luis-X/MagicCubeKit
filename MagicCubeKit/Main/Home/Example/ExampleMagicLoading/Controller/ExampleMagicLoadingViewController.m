//
//  ExampleMagicLoadingViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/22.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicLoadingViewController.h"

@interface ExampleMagicLoadingViewController ()

@end

@implementation ExampleMagicLoadingViewController{
    UIImageView *_loadingImageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicLoading";
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
    
    _loadingImageView = [QuicklyUI quicklyUIImageViewAddTo:self.view];
    _loadingImageView.contentMode = 1;
    //_loadingImageView.backgroundColor = [UIColor orangeColor];
    [_loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
    }];
    
    _loadingImageView.animationImages = [self getBundleImageArrayWithBundleName:@"MVCommonUI" imageName:@"loading" Count:4]; //动画图片数组
    _loadingImageView.animationDuration = 0.4;                                                                               //动画时长
    _loadingImageView.animationRepeatCount = 0;                                                                              //动画重复
    [_loadingImageView startAnimating];
    
    /*
    [self startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endAnimation];
    });
    */
}

//开始动画
- (void)startAnimation{
    [self loadingViewOptionsAnimating:YES];
}

//结束动画
- (void)endAnimation{
    [self loadingViewOptionsAnimating:NO];
}

//加载动画
- (void)loadingViewOptionsAnimating:(BOOL)animating{
    
    if (!animating) {
        [_loadingImageView.layer removeAllAnimations];
        return;
    }
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [_loadingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

#pragma 文件处理
/**
 获取bundle中某些图片数组
 
 @param bundleName bundle名
 @param imageName  image名
 @param count      image数目(从0开始获取,返回有效图片)
 */
- (NSArray *)getBundleImageArrayWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName Count:(NSInteger)count{
    
    NSMutableArray *imageFilePathArr = [NSMutableArray array];
    NSString* bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    for (NSInteger i = 0; i < count; i++) {
        NSString *filePath = [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@%ld", imageName, i]];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (image) {
            [imageFilePathArr addObject:image];
        }
    }
    return imageFilePathArr;
    
}
@end
