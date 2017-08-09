//
//  MagicWebViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/3.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagicWebViewController : UIViewController
- (instancetype)initWithRequestURL:(NSString *)url;

@property (nonatomic, assign) BOOL webTitleEnable;      //是否使用Web标题 （默认：YES）
@property (nonatomic, strong) UIColor *progressColor;   //进度条颜色
@property (nonatomic, assign) CGFloat progressHeight;   //进度条高度
@end
