//
//  MagicScrollPage.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/19.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicScrollPage.h"
#import "MagicScrollPageRefreshHeader.h"
#import "MagicScrollPageRefreshFooter.h"

@interface MagicScrollPage ()
@property (nonatomic, strong) UIScrollView *topPageView;       //第一页
@property (nonatomic, strong) UIScrollView *bottomPageView;    //第二页
@end

@implementation MagicScrollPage{
    MagicScrollPageRefreshFooter *_footer;
    MagicScrollPageRefreshHeader *_header;
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
        [self createSJScrollViews];
    }
    return self;
    
}

/**
 上下拉分页
 
 @param frame           frame
 @param firstPageView   第一页
 @param secondPageView  第二页
 */
+ (instancetype)showScrollPageViewWithFrame:(CGRect)frame firstPage:(UIScrollView *)firstPageView secondPage:(UIScrollView *)secondPageView{
    
    MagicScrollPage *scrollPageView = [[MagicScrollPage alloc] initWithFrame:frame];
    scrollPageView.topPageView = firstPageView;
    scrollPageView.bottomPageView = secondPageView;
    [scrollPageView configureRefreshPageControl];
    scrollPageView.animationDuration = 0.3f;
    return scrollPageView;
    
}

//主框架
- (void)createSJScrollViews{
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), (CGRectGetHeight(self.frame) * 2));
    self.pagingEnabled = YES;
    self.scrollEnabled = NO;
}

//第一页
- (void)setTopPageView:(UIScrollView *)topPageView{
    if (_topPageView != topPageView) {
        _topPageView = topPageView;
        
        _topPageView.frame = self.bounds;
        //_topPageView.backgroundColor = [UIColor redColor];
        [self addSubview:_topPageView];
    }
}

//第二页
- (void)setBottomPageView:(UIScrollView *)bottomPageView{
    if (_bottomPageView != bottomPageView) {
        _bottomPageView = bottomPageView;
        
        _bottomPageView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), _topPageView.frame.size.height);
        //_bottomPageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_bottomPageView];
    }
}

#pragma mark -上下拉切换分页
- (void)configureRefreshPageControl{
    
    // 1.设置 (第一页) 上拉显示
    _footer = [MagicScrollPageRefreshFooter footerWithRefreshingBlock:^{
        [self moveToSecondPageView];
    }];
    _topPageView.mj_footer = _footer;
    
    
    // 2.设置 (第二页) 下拉显示
    _header = [MagicScrollPageRefreshHeader headerWithRefreshingBlock:^{
        [self moveToFirstPageView];
    }];
    _bottomPageView.mj_header = _header;
    
}

//切换至第一页
- (void)moveToFirstPageView{
    
    [UIView animateWithDuration:self.animationDuration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.contentOffset = CGPointZero;
    } completion:^(BOOL finished) {
        [_bottomPageView.mj_header endRefreshing];
    }];
    
}
//切换至第二页
- (void)moveToSecondPageView{
    
    [UIView animateWithDuration:self.animationDuration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.contentOffset = CGPointMake(0, CGRectGetHeight(_topPageView.frame));
    } completion:^(BOOL finished) {
        [_topPageView.mj_footer endRefreshing];
    }];
    
}


@end
