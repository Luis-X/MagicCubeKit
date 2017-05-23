//
//  ExampleMagicImageDownloaderViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicImageDownloaderViewController.h"
#import "MagicImageDownloader.h"

@interface ExampleMagicImageDownloaderViewController ()

@end

@implementation ExampleMagicImageDownloaderViewController{
    NSArray *_allImageUrlArray;
    NSMutableArray *_allDownloadImageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicImageDownloader";
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
    _allImageUrlArray = @[
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490094635491&di=d49d4e8079b2b6f50505f4e2b8d9cb19&imgtype=0&src=http%3A%2F%2Fpic6.huitu.com%2Fres%2F20130116%2F84481_20130116142820494200_1.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490094635490&di=727f7c5c9d9b312bf93bf1f68878d58b&imgtype=0&src=http%3A%2F%2Fpic41.nipic.com%2F20140518%2F18521768_133448822000_2.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490094635490&di=e6774cfb73596b1ecb1717a6a612a24e&imgtype=0&src=http%3A%2F%2Fimg02.tooopen.com%2Fimages%2F20140504%2Fsy_60294738471.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490094635490&di=835595bfd3efc16dd7f5165cc41a9005&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130424%2F11588775_115415688157_2.jpg"];
    _allDownloadImageArray = [NSMutableArray array];
}

- (void)createMainView{
    
    UIButton *startButton = [QuicklyUI quicklyUIButtonAddTo:self.view backgroundColor:[UIColor clearColor] cornerRadius:5];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startButton setTitle:@" 批量下载保存到相册 " forState:UIControlStateNormal];
    startButton.layer.borderWidth = 2;
    startButton.layer.cornerRadius = 5;
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.height.mas_equalTo(50);
        
    }];
    [startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startButtonAction:(id)sender{
     NSLog(@"开始下载....");
     [self startDownloadImageWithURLStringArray:_allImageUrlArray];
}

- (void)startDownloadImageWithURLStringArray:(NSArray *)URLStringArray{
    
    [_allDownloadImageArray removeAllObjects];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t downloadImage = dispatch_group_create();
    
    for (NSString *urlString in URLStringArray) {
        
        NSLog(@"网络下载并保存到相册...");
        dispatch_group_async(downloadImage, queue, ^{
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *responseData = [NSData dataWithContentsOfURL:url];
            UIImage *resultImage = [UIImage imageWithData:responseData];
            [_allDownloadImageArray addObject:resultImage];
        });
        
    }
    
    dispatch_group_notify(downloadImage, dispatch_get_main_queue(), ^{
        
        NSLog(@"下载完成....");
        for (UIImage *image in _allDownloadImageArray) {
            [self loadImageFinished:image];
        }
        
    });
    
}

#pragma mark - 保存到相册
- (void)loadImageFinished:(UIImage *)image{
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存图片失败");
    }
    NSLog(@"保存图片成功!");
}

@end
