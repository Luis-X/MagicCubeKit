//
//  ProductConstant.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductConstant.h"

@implementation ProductConstant{
    STPopupController *_stpopupController;
}

+ (ProductConstant *)shareManager{
    
    static ProductConstant *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ProductConstant new];
    });
    return manager;
    
}

- (STPopupController *)showPopViewControllerWithMagicVC:(UIViewController *)magicVC AddController:(UIViewController *)addController CornerRadius:(CGFloat)cornerRadius NavigationBarHidden:(BOOL)navigationBarHidden{
    
    STPopupController *mainSTPopupVC = [[STPopupController alloc] initWithRootViewController:magicVC];
    //样式(中心,底部)
    mainSTPopupVC.style = STPopupStyleBottomSheet;
    //动画效果
    mainSTPopupVC.transitionStyle = STPopupTransitionStyleSlideVertical;
    //透明
    mainSTPopupVC.containerView.backgroundColor = [UIColor clearColor];
    //设置圆角
    mainSTPopupVC.containerView.layer.cornerRadius = 0;
    mainSTPopupVC.backgroundView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.80];
    //隐藏导航栏
    if (navigationBarHidden) {
        mainSTPopupVC.navigationBarHidden = YES;
    }
    [mainSTPopupVC presentInViewController:addController];
    [mainSTPopupVC.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopupController)]];
    _stpopupController = mainSTPopupVC;
    return mainSTPopupVC;
}


/**
 点击背景消失
 */
- (void)dismissPopupController{
    [_stpopupController dismiss];
}

/**
 特殊金额样式（¥缩小，其余放大）
 */
+ (void)setRichSignNumberWithLabel:(UILabel*)label BigSize:(CGFloat)bigSize SmallSize:(CGFloat)smallSize Color:(UIColor *)color{
    
    if (label.text == nil) {
        //NSLog(@"过滤空数据");
        return;
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSString *temp = nil;
    for(int i = 0; i < [attributedString length]; i++){
        
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        
        if([temp isEqualToString:@"¥"] || [temp isEqualToString:@"¥"] ||[temp isEqualToString:@"￥"]){
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:smallSize]} range:NSMakeRange(i, 1)];
        }else{
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:bigSize]} range:NSMakeRange(i, 1)];
        }
    }
    
    label.attributedText = attributedString;
    
}

#pragma mark -文本计算
/**
 根据高度获取高度
 
 @param text    文本
 @param height  高度
 @param font    字体
 */
+ (CGFloat)getTextWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font{
    //1,设置内容大小  其中高度一定要与item一致,宽度度尽量设置大值
    CGSize size = CGSizeMake(MAXFLOAT, height);
    //2,设置计算方式
    //3,设置字体大小属性   字体大小必须要与label设置的字体大小一致
    NSDictionary *attributeDic = @{NSFontAttributeName: font};
    CGRect frame = [text boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil];
    //4.添加间距
    return frame.size.width;
}
@end
