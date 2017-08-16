//
//  SJIconTextButton.m
//  DaRenShop
//
//  Created by LuisX on 2016/11/9.
//  Copyright © 2016年 YunRuo. All rights reserved.
//

#import "SJIconTextButton.h"

@implementation SJIconTextButton{
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
    _iconLabelSize = CGSizeZero;
    
}
- (void)createSubViews{
    
    //图片图标
    _iconImageView = [UIImageView new];
    //_iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_iconImageView];
    
    //字体图标
    _iconLabel = [UILabel new];
    _iconLabel.textColor = [UIColor blackColor];
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

- (void)setIconLabelSize:(CGSize)iconLabelSize{
    _iconLabelSize = iconLabelSize;
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
            
            if (_iconLabelSize.width > 0 && _iconLabelSize.height > 0) {
                [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_iconImageView);
                    make.centerX.equalTo(_iconImageView);
                    make.size.mas_equalTo(_iconLabelSize);
                }];
            }
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
            if (_iconLabelSize.width > 0 && _iconLabelSize.height > 0) {
                [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_iconImageView);
                    make.centerX.equalTo(_iconImageView);
                    make.size.mas_equalTo(_iconLabelSize);
                }];
            }

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
            if (_iconLabelSize.width > 0 && _iconLabelSize.height > 0) {
                [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_iconImageView);
                    make.centerX.equalTo(_iconImageView);
                    make.size.mas_equalTo(_iconLabelSize);
                }];
            }

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
            if (_iconLabelSize.width > 0 && _iconLabelSize.height > 0) {
                [_iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_iconImageView);
                    make.centerX.equalTo(_iconImageView);
                    make.size.mas_equalTo(_iconLabelSize);
                }];
            }

            break;
        }
            
        default:
            break;
    }
    
}

@end
