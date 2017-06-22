//
//  SJHSlideMenuView.m
//  SJHSlideMenuViewDemo
//
//  Created by yzq on 16/6/16.
//  Copyright © 2016年 yzq. All rights reserved.
//

#import "SJHSlideMenuView.h"

#import "SJHSlideMenu.h"

@interface SJHSlideMenuView ()<SJHSlideMenuDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) SJHSlideMenu *sjHSlideMenu;

@property (strong, nonatomic) UIScrollView *mScrollView;

@end

@implementation SJHSlideMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self initMenu];
    
    [self initScrollView];
    
    [self initConfig];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //需要移动的距离
    CGFloat XNeedOffset = scrollView.contentOffset.x*(_sjHSlideMenu.frame.size.width-_sjHSlideMenu.xOffset*2-_sjHSlideMenu.btnSize.width)/(scrollView.frame.size.width*([_arrContent count]-1));
    
    CGRect frameCurrentView = [_sjHSlideMenu getCurrentViewFrameForIndex:0];
    frameCurrentView.origin.x += XNeedOffset;
    _sjHSlideMenu.mViewCurrent.frame = frameCurrentView;
    
    CGFloat fPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    int iPage = fPage;
    if (fPage-iPage == 0) {
        _sjHSlideMenu.selectedIndex = iPage;
    }
}

#pragma mark - SJHSlideMenuDelegate

- (void)sjHSlideMenuDidSelect:(NSInteger)index
{
    [_mScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*index, 0) animated:YES];
}

#pragma mark - Init

- (void)initData
{
    _selectedIndex = 0;
    _menuFont = [UIFont systemFontOfSize:16.0f];
    _menuNormalColor = UIColorFromRGB(0xdddddd);
    _menuSelectedColor = UIColorFromRGB(0x22222e);
    _menuSlideColor = UIColorFromRGB(0x22222e);
}

- (void)initMenu
{
    if (_sjHSlideMenu) {
        [_sjHSlideMenu removeFromSuperview];
    }
    
    _sjHSlideMenu = [[SJHSlideMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), _menuHeight)];
    _sjHSlideMenu.xOffset = _xOffset;
    _sjHSlideMenu.btnSize = _btnSize;
    _sjHSlideMenu.arrTitles = _arrTitles;
    _sjHSlideMenu.delegate = self;
    _sjHSlideMenu.menuFont = _menuFont;
    _sjHSlideMenu.menuNormalColor = _menuNormalColor;
    _sjHSlideMenu.menuSelectedColor = _menuSelectedColor;
    _sjHSlideMenu.menuSlideColor = _menuSlideColor;
    _sjHSlideMenu.menuSlideBottomColor=_menuSlideBottomColor;
    [self addSubview:_sjHSlideMenu];
}

- (void)initScrollView
{
    if (_mScrollView) {
        [_mScrollView removeFromSuperview];
    }
    
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _menuHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-_menuHeight)];
    _mScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*[_arrContent count], CGRectGetHeight(self.frame)-_menuHeight);
    _mScrollView.showsVerticalScrollIndicator = NO;
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.pagingEnabled = YES;
    _mScrollView.delegate = self;
    [self addSubview:_mScrollView];
    
    for (int i = 0; i < [_arrContent count]; i++) {
        
        UIView *mView = [_arrContent objectAtIndex:i];
        
        CGRect tempFrame = mView.frame;
        tempFrame.origin = CGPointMake(CGRectGetWidth(self.frame)*i, 0);
        mView.frame = tempFrame;
        
        [_mScrollView addSubview:mView];
    }
}

- (void)initConfig
{
    [self sjHSlideMenuDidSelect:_selectedIndex];
    _sjHSlideMenu.selectedIndex=_selectedIndex;
}

@end
