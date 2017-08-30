//
//  MagicPhotoBrowserManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicPhotoBrowserManager.h"

@interface MagicPhotoBrowserManager ()<IDMPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *browserDataArray;
@property (nonatomic, strong) UILabel *browserPageView;
@end

@implementation MagicPhotoBrowserManager

+ (MagicPhotoBrowserManager *)shareManager{
    
    static MagicPhotoBrowserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MagicPhotoBrowserManager new];
        manager.browserDataArray = [NSMutableArray array];
    });
    return manager;
    
}

- (IDMPhotoBrowser *)showMagicPhotoBrowserAddControler:(UIViewController *)controller photos:(NSArray *)photos startIndex:(NSInteger)startIndex{
    
    [_browserDataArray removeAllObjects];
    for (id result in photos) {
        IDMPhoto *resultPhoto = nil;
        //UIImage类型
        if ([result isKindOfClass:[UIImage class]]) {
            resultPhoto = [IDMPhoto photoWithImage:(UIImage *)result];
        }
        if ([result isKindOfClass:[NSString class]]) {
            if ([(NSString *)result containsString:@"://"]) {
                //URLString类型
                resultPhoto = [IDMPhoto photoWithURL:[NSURL URLWithString:result]];
            }else{
                //FilePath类型
                resultPhoto = [IDMPhoto photoWithFilePath:result];
            }
        }
        //NSURL类型
        if ([result isKindOfClass:[NSURL class]]) {
            resultPhoto = [IDMPhoto photoWithURL:(NSURL *)result];
        }
        if (resultPhoto) {
            [_browserDataArray addObject:resultPhoto];
        }
    }
    
    if (_browserDataArray.count <= 0) {
        NSLog(@"浏览图片数据为空");
        return nil;
    }
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:_browserDataArray];
    [browser setInitialPageIndex:startIndex];
    //配置项
    browser.displayActionButton = NO;
    browser.displayArrowButton = NO;
    browser.displayCounterLabel = NO;
    browser.displayDoneButton = NO;
    browser.useWhiteBackgroundColor = YES;
    browser.autoHideInterface = NO;
    browser.usePopAnimation = NO;
    browser.forceHideStatusBar = NO;
    browser.disableVerticalSwipe = NO;
    browser.dismissOnTouch = YES;
    browser.delegate = self;
    
    //页码
    CGFloat page_size = 25 * HOME_IPHONE6_HEIGHT;
    CGFloat page_bottom_space = 35 * HOME_IPHONE6_HEIGHT;
    CGFloat page_font_size = 10 * HOME_IPHONE6_HEIGHT;
    
    _browserPageView = [[UILabel alloc] initWithFrame:CGRectMake((browser.view.frame.size.width - page_size) / 2,(browser.view.frame.size.height - page_size - page_bottom_space), page_size, page_size)];
    _browserPageView.font = [UIFont systemFontOfSize:page_font_size];
    _browserPageView.adjustsFontSizeToFitWidth = YES;
    _browserPageView.textColor = [UIColor whiteColor];
    _browserPageView.textAlignment = NSTextAlignmentCenter;
    _browserPageView.layer.cornerRadius = _browserPageView.bounds.size.width / 2;
    _browserPageView.layer.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00].CGColor;
    [browser.view addSubview:_browserPageView];
    [controller presentViewController:browser animated:YES completion:nil];
    return browser;
}

#pragma mark - IDMPhotoBrowserDelegate
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)index{
    _browserPageView.text = [NSString stringWithFormat:@"%ld/%ld", (index + 1), _browserDataArray.count];
}
@end
