//
//  SJHSlideMenu.m
//  SJHSlideMenuViewDemo
//
//  Created by yzq on 16/6/16.
//  Copyright © 2016年 yzq. All rights reserved.
//

#import "SJHSlideMenu.h"

@interface SJHSlideMenu ()

@property (strong, nonatomic) NSMutableArray *mMArrBtn;

@property (assign, nonatomic) CGFloat btnSpace;

@end

@implementation SJHSlideMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _mMArrBtn = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self initContent];
}

#pragma mark - Action

- (void)clickToSwithType:(UIButton *)btn
{
    if (btn.selected) {
        return;
    }else{
        
        self.selectedIndex = btn.tag;
        
        if ([self.delegate respondsToSelector:@selector(sjHSlideMenuDidSelect:)]) {
            [self.delegate sjHSlideMenuDidSelect:btn.tag];
        }
    }
}

#pragma mark - Init

- (void)initContent
{
    _btnSpace = (CGRectGetWidth(self.frame)-_xOffset*2-_btnSize.width*[_arrTitles count])/([_arrTitles count]-1);
    
    for (int i = 0; i < [_arrTitles count]; i++) {
        UIButton *mBtn = [[UIButton alloc] initWithFrame:CGRectMake(_xOffset+(_btnSize.width+_btnSpace)*i, 0, _btnSize.width, _btnSize.height)];
        mBtn.titleLabel.font = _menuFont;
        [mBtn setTitleColor:_menuSelectedColor forState:UIControlStateSelected];
        [mBtn setTitleColor:_menuNormalColor forState:UIControlStateNormal];
        [mBtn setTitle:[_arrTitles objectAtIndex:i] forState:UIControlStateNormal];
        [mBtn setTitle:[_arrTitles objectAtIndex:i] forState:UIControlStateSelected];
        mBtn.tag = i;
        [mBtn addTarget:self action:@selector(clickToSwithType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mBtn];
        
        [_mMArrBtn addObject:mBtn];
    }
    
    UIView * mviewLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height-1, self.frame.size.width-20, 1)];
    mviewLine.backgroundColor=_menuSlideBottomColor;
    [self addSubview:mviewLine];
    
    _mViewCurrent = [[UIView alloc] initWithFrame:[self getCurrentViewFrameForIndex:0]];
    _mViewCurrent.backgroundColor = _menuSlideColor;
    [self addSubview:_mViewCurrent];
    
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    for (UIButton *mBtn in _mMArrBtn) {
        mBtn.selected = NO;
    }
    
    [[_mMArrBtn objectAtIndex:selectedIndex] setSelected:YES];
}

#pragma mark - Util
/**
 *  计算滑动线的Frame
 *
 *  @param index 下标
 *
 *  @return 滑动线在index的Frame
 */
- (CGRect)getCurrentViewFrameForIndex:(NSInteger)index
{
    return CGRectMake(_xOffset+(_btnSize.width+_btnSpace)*index+10, _btnSize.height, _btnSize.width-20, 2);
}

@end
