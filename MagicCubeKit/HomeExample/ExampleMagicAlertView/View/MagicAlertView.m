//
//  MagicAlertView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicAlertView.h"

#define BUTTON_TAG 54321
#define ALERT_VIEW_SPACE 15     //间距
#define ALERT_BUTTON_HEIGHT 44  //按钮高度
#define ALERT_VIEW_WIDTH    [UIScreen mainScreen].bounds.size.width - 100    //宽度
//适配(宽*宽 高*高)
#define HOME_IPHONE6_HEIGHT [UIScreen mainScreen].bounds.size.height / 668
#define HOME_IPHONE6_WIDTH [UIScreen mainScreen].bounds.size.width / 375

@interface  MagicAlertView()
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)SelectedIndex chooseIndex;
@end

@implementation MagicAlertView{
    UIView *_backgroundView;
    UILabel *_titleLabel;
    UILabel *_messageLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithButtonTitles:(NSArray *)buttonTitles{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.30];
        [self createSubViewsButtonTitles:buttonTitles];
    }
    return self;
    
}

- (void)createSubViewsButtonTitles:(NSArray *)buttonTitles{
    
    _backgroundView = [UIView new];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.width.mas_equalTo(ALERT_VIEW_WIDTH);
        
    }];
    
    //标题
    _titleLabel = [UILabel new];
    //_titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16 * HOME_IPHONE6_HEIGHT];
    [_backgroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_backgroundView).offset(ALERT_VIEW_SPACE);
        make.centerX.equalTo(_backgroundView);
        
    }];
    
    //信息
    _messageLabel = [UILabel new];
    //_messageLabel.backgroundColor = [UIColor redColor];
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [_backgroundView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(_backgroundView).offset(ALERT_VIEW_SPACE);
        make.right.equalTo(_backgroundView).offset(-ALERT_VIEW_SPACE);
        
    }];
    
    //按钮
    [buttonTitles enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithRed:0.98 green:0.20 blue:0.31 alpha:1.00];
        if (idx == 1) {
            button.backgroundColor = [UIColor grayColor];
        }
        button.tag = BUTTON_TAG + idx;
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16 * HOME_IPHONE6_HEIGHT];
        [_backgroundView addSubview:button];
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat buttonWidth = ((ALERT_VIEW_WIDTH) / buttonTitles.count);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_messageLabel.mas_bottom).offset(ALERT_VIEW_SPACE);
            make.left.equalTo(_backgroundView).offset(buttonWidth * idx);
            make.height.mas_equalTo(ALERT_BUTTON_HEIGHT);
            make.width.mas_equalTo(buttonWidth);
            make.bottom.equalTo(_backgroundView);
            
        }];
        
    }];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlertView)]];
}
#pragma mark----实现类方法
+ (instancetype)showAlterViewWithTitle:(NSString *)title content:(NSString *)content ButtonTitles:(NSArray *)buttonTitles Index:(SelectedIndex)index{
    
    MagicAlertView *alterView = [[MagicAlertView alloc] initWithButtonTitles:buttonTitles];
    alterView.title = title;
    alterView.content = content;
    alterView.chooseIndex = index;
    [alterView showAddController:[UIApplication sharedApplication].keyWindow.rootViewController];
    return alterView;
    
}

#pragma mark--给属性重新赋值
-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
    _messageLabel.textColor = title == nil ? [UIColor blackColor] : [UIColor grayColor];
}

-(void)setContent:(NSString *)content{
    _messageLabel.text = content;
}


//添加窗口
- (void)showAddController:(UIViewController *)addController{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self animationWithView:_backgroundView duration:0.5];
    [addController.view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(addController.view);
        
    }];
    
}

//动画
- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = duration;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8f, 0.8f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
}

/**
 消失
 */
- (void)dismissAlertView{
    [self removeFromSuperview];
}

/**
 点击事件
 */
- (void)buttonClickAction:(UIButton *)button{
    
    [self dismissAlertView];
    if (self.chooseIndex) {
        self.chooseIndex(button.tag - BUTTON_TAG);
    }
    
}


#pragma mark - Button样式自定义
- (void)customButtonColor:(UIColor *)color index:(NSInteger)index{
    UIButton *button = [_backgroundView viewWithTag:(BUTTON_TAG + index)];
    button.backgroundColor = color;
}
@end
