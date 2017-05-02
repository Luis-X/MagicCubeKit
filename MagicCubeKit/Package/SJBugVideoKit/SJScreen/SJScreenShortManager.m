//
//  SJScreenShortManager.m
//  DaRenShop
//
//  Created by LuisX on 2017/4/18.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "SJScreenShortManager.h"
#import "SJResponseViewController.h"
#import "SJBugVideoConstant.h"

#define IMAGEVIEW_TAG 4000
#define Alertview_duration 0.30     //动画时长
#define Alertview_close_time 5.00   //自动关闭时长
#define Alertview_bottom_space 60   //距离底部距离

@interface SJScreenShortManager ()
@property (nonatomic, strong)UIView *shareAlertView;                //弹框
@end

@implementation SJScreenShortManager{
    UIImage *_mainShareViewImage;           //截屏图片
    CGSize alertview_size;
}

+ (SJScreenShortManager *)shareManager{
    
    static SJScreenShortManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [SJScreenShortManager new];
    });
    return manager;
}

/**
 截屏
 */
- (void)startScreenShort:(BOOL)open{
    
    if (open == NO) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(catchCurrentScreenShort:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
}

#pragma mark - 捕捉截屏
- (void)catchCurrentScreenShort:(NSNotification *)notice{
    
    _mainShareViewImage = [self getScreenshotImage];
    if (_mainShareViewImage) {
        alertview_size = CGSizeMake(325 * SJ_IPhone6_Width, 80);
        [[UIApplication sharedApplication].keyWindow addSubview:self.shareAlertView];
        [self showAlertView:YES];
    }
    
}

#pragma mark - 弹框
/**
 是否显示弹框
 */
- (void)showAlertView:(BOOL)show{
    
    CGFloat alertView_x = (SJ_Screen_Width - alertview_size.width) / 2;
    if (show) {
        self.shareAlertView.hidden = NO;
        [UIView animateWithDuration:Alertview_duration animations:^{
            self.shareAlertView.frame = CGRectMake(alertView_x, SJ_Screen_Height - alertview_size.height - (Alertview_bottom_space * SJ_IPhone6_Height), alertview_size.width, alertview_size.height);
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(Alertview_close_time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showAlertView:NO];
            });
        }];
    }else{
        [UIView animateWithDuration:Alertview_duration animations:^{
            self.shareAlertView.alpha = 0.00;
        } completion:^(BOOL finished) {
            self.shareAlertView.hidden = YES;
            self.shareAlertView.alpha = 1.00;
            self.shareAlertView.frame = CGRectMake(alertView_x, SJ_Screen_Height - alertview_size.height, alertview_size.width, alertview_size.height);
        }];
    }
    
}

#pragma 懒加载
- (UIView *)shareAlertView{
    
    if (!_shareAlertView) {
        _shareAlertView = [self createShareAlertView];
    }
    return _shareAlertView;
    
}
/**
 弹框
 */
- (UIView *)createShareAlertView{
    
    //UI配置
    NSArray *iconArray = @[@"share_wechat@2x.png", @"share_friend@2x.png", @"share_qq@2x", @"share_problem@2x.png"];
    CGFloat message_width = 30;
    CGFloat message_space = 20;
    NSInteger icon_number = iconArray.count;
    CGSize icon_size = CGSizeMake(50, 50);
    CGFloat icon_sum_width = alertview_size.width - (2 * message_space) - message_width;
    CGFloat icon_space = (icon_sum_width - (icon_size.width * icon_number)) / icon_number;
    
    UIView *shareView = [UIView new];
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.frame = CGRectMake((SJ_Screen_Width - alertview_size.width) / 2, SJ_Screen_Height, alertview_size.width, alertview_size.height);
    shareView.hidden = YES;
    shareView.layer.masksToBounds = YES;
    shareView.layer.cornerRadius = 10;
    
    UILabel *messageLabel = [QuicklyUI quicklyUILabelAddTo:shareView font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]];
    messageLabel.text = @"分\n享\n到";
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shareView);
        make.left.equalTo(shareView).offset(message_space);
        make.width.mas_equalTo(message_width);
    }];
    
    for (NSInteger i = 0; i < icon_number; i++) {
        UIImageView *icon = [UIImageView new];
        icon.contentMode = 1;
        icon.userInteractionEnabled = YES;
        icon.tag = IMAGEVIEW_TAG + i;
        NSString *icon_imageName = [NSString stringWithFormat:@"%@", [iconArray objectAtIndex:i]];
        [icon setImage:[UIImage imageNamed:icon_imageName]];
        [shareView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(icon_size);
            make.centerY.equalTo(shareView);
            make.left.equalTo(messageLabel.mas_right).offset(icon_space + ((icon_size.width + icon_space) * i));
        }];
        [icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAlertViewOptionAction:)]];
    }
    return shareView;
    
}

/**
 选项
 */
- (void)shareAlertViewOptionAction:(UIGestureRecognizer *)tap{
    
    NSInteger index = tap.view.tag - IMAGEVIEW_TAG;
    [self showAlertView:NO];
    if (index == 0) {
        NSLog(@"微信 %@", _mainShareViewImage);
        
    }
    if (index == 1) {
        NSLog(@"朋友圈 %@", _mainShareViewImage);
        
    }
    if (index == 2) {
        NSLog(@"QQ %@", _mainShareViewImage);
        
    }
    if (index == 3) {
        NSLog(@"反馈");
        SJResponseViewController *viewController = [SJResponseViewController new];
        viewController.screenShortImage = _mainShareViewImage;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:NULL];
    }
    
}

#pragma mark - 截屏
/**
 获取截屏
 */
- (UIImage *)getScreenshotImage{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

/**
 截屏
 */
- (NSData *)dataWithScreenshotInPNGFormat{
    
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;                   //检测横竖屏
    if (UIInterfaceOrientationIsPortrait(orientation)){
        imageSize = [UIScreen mainScreen].bounds.size;                                                             //竖屏
    }else{
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width); //横屏
    }
    //开始绘制图片
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]){
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft){
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }else if (orientation == UIInterfaceOrientationLandscapeRight){
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }else{
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(image);
}

@end
