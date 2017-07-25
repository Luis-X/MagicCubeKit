//
//  CommonTool.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

/**
 UICollectionView内容少可以滚动
 */
+ (void)alwaysBounceWithCollectionView:(UICollectionView *)collectionView{
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.alwaysBounceVertical = YES;
}


/**
 UITextField占位符

 @param textField textField
 @param textColor 文本颜色
 @param font      文本字体
 */
+ (void)placeholderWithTextField:(UITextField *)textField textColor:(UIColor *)textColor font:(UIFont *)font{
    
    [textField setValue:textColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
}


/**
 获取当前显示的控制器
 */
- (UIViewController *)getCurrentDisplayViewControllerFrom:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getCurrentDisplayViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]){
        return [self getCurrentDisplayViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    }
    
    if (vc.presentedViewController) {
        return [self getCurrentDisplayViewControllerFrom:vc.presentedViewController];
    }
    
    return vc;

}


/**
 cell点击效果
 */
- (void)deselectRowAnimationTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/**
 不满一屏去除多余单元格
 */
- (void)clearMoreRowTableView:(UITableView *)tableView{
    tableView.tableHeaderView = [UIView new];
    tableView.tableFooterView = [UIView new];
}

/**
 置顶tableView
 */
- (void)stickTableView:(UITableView *)tableView{
    [tableView setContentOffset:CGPointZero animated:YES];
    //[tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}


/**
 cell选中颜色
 */
- (void)tableViewCell:(UITableViewCell *)cell backgroudColor:(UIColor *)backgroundColor{
    
    UIView *view = [UIView new];
    view.backgroundColor = backgroundColor;
    [cell setSelectedBackgroundView:view];
    
}


/**
 分割线颜色
 */
- (void)tableView:(UITableView *)tableView separatorColor:(UIColor *)separatorColor{
    [tableView setSeparatorColor:separatorColor];
}


/**
 UIScrollView置底
 */
- (void)goBottomWithScrollView:(UIScrollView *)scrollView{
    CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.bounds.size.height);
    [scrollView setContentOffset:bottomOffset animated:YES];
}

/**
 获取视频第一帧图
 */
- (UIImage *)getVideoPreviewImageWithfilePath:(NSString *)filePath{
    
    NSURL *url = [NSURL URLWithString:filePath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 2);
    CGImageRef ref = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
    UIImage *result = [[UIImage alloc] initWithCGImage:ref];
    return result;
    
}


/**
 获取视频时长
 */
- (NSInteger)getVideoTimeWithfilePath:(NSString *)filePath{
    
    NSURL *url = [NSURL URLWithString:filePath];
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    CMTime time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    return seconds;
    
}


/**
 设置UIWebView透明
 */
- (void)backgroundClearColorWithUIWebView:(UIWebView *)webView{
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
}





@end
