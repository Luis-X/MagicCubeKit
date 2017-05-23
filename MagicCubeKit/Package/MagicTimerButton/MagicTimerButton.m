//
//  MagicTimerButton.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/23.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicTimerButton.h"

@implementation MagicTimerButton{
    dispatch_source_t _mainTimerSource;
}

- (void)setNormalTitle:(NSString *)normalTitle{
    if (_normalTitle != normalTitle) {
        _normalTitle = normalTitle;
        [self updateTimeButtonTitle:_normalTitle];
    }
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    if (_normalTitleColor != normalTitleColor) {
        _normalTitleColor = normalTitleColor;
        [self updateTimeButtonTitleColor:_normalTitleColor];
    }
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor{
    if (_normalBackgroundColor != normalBackgroundColor) {
        _normalBackgroundColor = normalBackgroundColor;
        [self updateTimeButtonBackgroundColor:_normalBackgroundColor];
    }
}

- (void)setNormalBorderColor:(UIColor *)normalBorderColor{
    if (_normalBorderColor != normalBorderColor) {
        _normalBorderColor = normalBorderColor;
        [self updateTimeButtonBorderColor:_normalBorderColor];
    }
}
- (void)setTitleFont:(UIFont *)titleFont{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
        self.titleLabel.font = _titleFont;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 倒计时核心
 
 @param duration 时长
 */
- (void)startTimeWithDuration:(NSInteger)duration{
    
    [self endTimer];
    __block NSInteger timeout = duration;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _mainTimerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_mainTimerSource, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_mainTimerSource, ^{
        if(timeout <= 0){
            //倒计时结束
            [self endTimer];
        }else{
            //倒计时中
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = NO;
                [self updateTimeButtonTitle:[NSString stringWithFormat:@"%@%ld%@", _timeRunningTitle, timeout, SJ_Time_Unit]];
                [self updateTimeButtonTitleColor:_timeRunningTitleColor];
                [self updateTimeButtonBackgroundColor:_timeRunningBackgroundColor];
                [self updateTimeButtonBorderColor:_timeRunningBorderColor];
            });
            timeout--;
        }
    });
    dispatch_resume(_mainTimerSource);
    
}


/**
 结束倒计时
 */
- (void)endTimer{
    
    if (_mainTimerSource) {
        dispatch_source_cancel(_mainTimerSource);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
            [self updateTimeButtonTitle:_normalTitle];
            [self updateTimeButtonTitleColor:_normalTitleColor];
            [self updateTimeButtonBackgroundColor:_normalBackgroundColor];
            [self updateTimeButtonBorderColor:_normalBorderColor];
        });
    }
    
}

/**
 标题
 */
- (void)updateTimeButtonTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

/**
 标题颜色
 */
- (void)updateTimeButtonTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

/**
 背景颜色
 */
- (void)updateTimeButtonBackgroundColor:(UIColor *)backgroundColor{
    [self setBackgroundColor:backgroundColor];
}

/**
 边框颜色
 */
- (void)updateTimeButtonBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}


/**
 开始计时
 */
- (void)start{
    [self startTimeWithDuration:_timeDuration];
}

/**
 结束计时
 */
- (void)end{
    [self startTimeWithDuration:0];
}
@end
