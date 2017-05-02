//
//  SJBugVideoTool.m
//  DaRenShop
//
//  Created by LuisX on 2017/4/5.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "SJBugVideoTool.h"
#import "ReplayKitManager.h"
#import "SJBugVideoConstant.h"

#define animateDuration 0.3       //位置改变动画时间

typedef enum {
    SJDirectionLeft,
    SJDirectionRight,
    SJDirectionTop,
    SJDirectionBottom
}SJDirection;

@interface SJBugVideoTool ()<ReplayKitManagerDelegate>

@end

@implementation SJBugVideoTool{
    UIView *_backgroundView;                        //背景
    UIButton *_startButton;                         //开始/结束
    SJBugVideoTool *_bugVideoTool;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert + 1;  //如果想在 alert 之上，则改成 + 2
        self.rootViewController = [UIViewController new];
        [self makeKeyAndVisible];
        [self addSubview:[self createMainView]];
        [ReplayKitManager sharedManager].delegate = self;
    }
    return self;
    
}

+ (instancetype)show{
    SJBugVideoTool *tool = [[SJBugVideoTool alloc] initWithFrame:CGRectMake((SJ_Screen_Width - 100) / 2, (SJ_Screen_Height - 100) / 2, 100, 100)];
    BOOL show = [[NSUserDefaults standardUserDefaults] boolForKey:@"bugVideoShow"];       //是否开启
    tool.hidden = !show;
    return tool;
}

#pragma mark - UI相关
- (UIView *)createMainView{
    
    CGSize button_size = CGSizeMake(72, 43);
    
    //背景
    _backgroundView = [QuicklyUI quicklyUIViewAddTo:self];
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    //开始
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //_startButton.backgroundColor = [UIColor orangeColor];
    [self checkStartButtonStatus:_startButton.selected];
    [_backgroundView addSubview:_startButton];
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_backgroundView);
        make.size.mas_equalTo(button_size);
    }];
    [_startButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //拖拽
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(locationChange:)];
    pan.delaysTouchesBegan = NO;
    [self addGestureRecognizer:pan];
    return _backgroundView;
    
}

#pragma mark - RePlayKit
- (void)buttonAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self startBugVideo];
        return;
    }
    [self stopBugVideo];
    
}


/**
 开始录制
 */
- (void)startBugVideo{
    
    __weak typeof(self) weakSelf = self;
    [[ReplayKitManager sharedManager] startRecordingHandler:^(NSError *error) {
    
        if (error) {
            //关闭开关并停止录制
            weakSelf.hidden = YES;
            [QuicklyHUD showWindowsOnlyTextHUDText:@"已关闭录屏功能"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"bugVideoShow"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [weakSelf stopBugVideo];
        }else{
            [weakSelf checkStartButtonStatus:YES];
        }
        
    }];

}

/**
 结束录制
 */
- (void)stopBugVideo{
    
    [[ReplayKitManager sharedManager] stopRecording];
    [self checkStartButtonStatus:NO];
    
}


/**
 修改开关状态
 */
- (void)checkStartButtonStatus:(BOOL)status{
    
    _startButton.selected = status;
    NSString *title = status ? @"video_stop" : @"video_start";
    [_startButton setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    
}


#pragma mark - 悬浮
- (void)changBoundsabovePanPoint:(CGPoint)panPoint{
    
    CGFloat left = panPoint.x;
    CGFloat right = SJ_Screen_Width - panPoint.x;
    CGFloat top = panPoint.y;
    CGFloat bottom = SJ_Screen_Height - panPoint.y;
    // 计算四个距离最小的吸附方向
    SJDirection mini = SJDirectionLeft;
    CGFloat minDistance = left;
    if (right < minDistance) {
        minDistance = right;
        mini = SJDirectionRight;
    }
    if (top < minDistance) {
        minDistance = top;
        mini = SJDirectionTop;
    }
    if (bottom < minDistance) {
        mini = SJDirectionBottom;
    }
    
    //吸附
    switch (mini) {
        case SJDirectionLeft:{
            [UIView animateWithDuration:animateDuration animations:^{
                self.center = CGPointMake(self.frame.size.width / 2, self.center.y);
            }];
            break;
        }
        case SJDirectionRight:{
            [UIView animateWithDuration:animateDuration animations:^{
                self.center = CGPointMake(SJ_Screen_Width - self.frame.size.width / 2, self.center.y);
            }];
            break;
        }
        case SJDirectionTop:{
            [UIView animateWithDuration:animateDuration animations:^{
                self.center = CGPointMake(self.center.x, self.frame.size.height / 2);
            }];
            break;
        }
        case SJDirectionBottom:{
            [UIView animateWithDuration:animateDuration animations:^{
                self.center = CGPointMake(self.center.x, SJ_Screen_Height - self.frame.size.height / 2);
            }];
            break;
        }
        default:
            break;
    }

}

/**
 改变位置
 */
- (void)locationChange:(UIPanGestureRecognizer*)pan{
    
    CGPoint point = [pan locationInView:[UIApplication sharedApplication].keyWindow];
    if(pan.state == UIGestureRecognizerStateChanged){
        self.center = CGPointMake(point.x, point.y);
    }
    if(pan.state == UIGestureRecognizerStateEnded){
        [self changBoundsabovePanPoint:point];
    }
    
}


#pragma mark - ReplayKitManagerDelegate
//预览
- (void)replayKitDisplayRecordingContent:(RPPreviewViewController *)previewViewController{
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:previewViewController animated:YES completion:^{
        //NSLog(@"Display complete!");
    }];
    
}


@end
