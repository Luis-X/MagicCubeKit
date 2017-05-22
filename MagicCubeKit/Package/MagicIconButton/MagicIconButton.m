//
//  MagicIconButton.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/19.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicIconButton.h"

@implementation MagicIconButton{
    UIColor *_originalColor;            //还原颜色
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
    if (self) {
        [self initailData];
        [self createSubViews];
        [self updateAllLayoutSubviews];
    }
    return self;
    
}

- (void)initailData{
    
    _buttonStyle = IconTextButtonStyleLeft;
    _iconSize = CGSizeMake(30, 30);
    _iconFontSize = 20;
    
}
- (void)createSubViews{
    
    //图片图标
    _iconImageView = [UIImageView new];
    //_iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_iconImageView];
    
    //字体图标
    _iconLabel = [UILabel new];
    _titleLabel.textColor = [UIColor blackColor];
    _iconLabel.font = [UIFont fontWithName:@"iconFont" size:_iconFontSize];
    [self addSubview:_iconLabel];
    
    //文本
    _titleLabel = [UILabel new];
    //_titleLabel.backgroundColor = [UIColor blueColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    
}

- (void)setButtonStyle:(IconTextButtonStyle)buttonStyle{
    
    if (_buttonStyle != buttonStyle) {
        _buttonStyle = buttonStyle;
        [self updateAllLayoutSubviews];
    }
    
}

- (void)setIconSize:(CGSize)iconSize{
    
    _iconSize = iconSize;
    [self updateAllLayoutSubviews];
    
}

- (void)setIconFontSize:(CGFloat)iconFontSize{
    
    _iconFontSize = iconFontSize;
    _iconLabel.font = [UIFont fontWithName:@"iconFont" size:_iconFontSize];
    [self updateAllLayoutSubviews];
    
}

- (void)setButtonEdges:(UIEdgeInsets)buttonEdges{
    
    _buttonEdges = buttonEdges;
    [self updateAllLayoutSubviews];
    
}

- (void)updateAllLayoutSubviews{
    
    switch (_buttonStyle) {
        case IconTextButtonStyleTop:{
            
            //NSLog(@"上");
            [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(_buttonEdges.top);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(_iconSize);
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-_buttonEdges.bottom);
                make.centerX.equalTo(self);
                make.width.lessThanOrEqualTo(self);
            }];
            
            [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.center.equalTo(_iconImageView);
                
            }];
            break;
        }
        case IconTextButtonStyleBottom:{
            
            //NSLog(@"下");
            [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-_buttonEdges.bottom);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(_iconSize);
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(_buttonEdges.top);
                make.centerX.equalTo(self);
                make.width.lessThanOrEqualTo(self);
            }];
            
            [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.center.equalTo(_iconImageView);
                
            }];
            break;
        }
        case IconTextButtonStyleLeft:{
            
            //NSLog(@"左");
            [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(_buttonEdges.left);
                make.size.mas_equalTo(_iconSize);
                
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-_buttonEdges.right);
                make.height.lessThanOrEqualTo(self);
            }];
            
            [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.center.equalTo(_iconImageView);
                
            }];
            break;
        }
        case IconTextButtonStyleRight:{
            
            //NSLog(@"右");
            [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-_buttonEdges.right);
                make.size.mas_equalTo(_iconSize);
                
            }];
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(_buttonEdges.left);
                make.height.lessThanOrEqualTo(self);
            }];
            
            [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.center.equalTo(_iconImageView);
                
            }];
            break;
        }
            
        default:
            break;
    }
    
}

//开始
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    _originalColor = _titleLabel.textColor;
    if (_enableHighlight) {
        [self updateTextColorWithColor:[UIColor blackColor]];
    }
    return YES;
    
}
//继续
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (_enableHighlight) {
        [self updateTextColorWithColor:[UIColor blackColor]];
    }
    return YES;
    
}
//结束
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (_enableHighlight) {
        [self updateTextColorWithColor:_originalColor];
    }
    
}

//更新改变状态颜色
- (void)updateTextColorWithColor:(UIColor *)color{
    
    _iconLabel.textColor = color;
    _titleLabel.textColor = color;
    
}

@end
