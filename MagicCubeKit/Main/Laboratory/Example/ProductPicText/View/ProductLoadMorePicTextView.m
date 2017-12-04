//
//  ProductLoadMorePicTextView.m
//  DaRenShop
//
//  Created by LuisX on 2017/11/22.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "ProductLoadMorePicTextView.h"
#import "ProductLoadMorePicTextCollectionViewCell.h"
#import "MagicScrollPageRefreshHeader.h"
#import <MagicWebViewWebP/MagicWebViewWebPManager.h>

const CGFloat recommendViewHeight = 170;
const CGFloat recommendViewSpace = 10;
const CGFloat recommendItemWidth = 105;
const CGFloat recommendItemSpace = 5;
const CGFloat recommendTitleHeight = 40;

@interface ProductLoadMorePicTextView ()<UIWebViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) NSMutableArray *recommendDataArray;
@property (nonatomic, strong) NSMutableArray *picTextDataArray;
@end

@implementation ProductLoadMorePicTextView

- (instancetype)initWithFrame:(CGRect)frame productDetailModel:(ProductDetailModel *)productDetailModel picTextModel:(ProductLoadMorePicTextModel *)picTextModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.recommendDataArray = [NSMutableArray arrayWithArray:productDetailModel.recommend];
        self.picTextDataArray = [NSMutableArray arrayWithArray:picTextModel.itemPic.packageImages];
        [self createSubViewsWithPicTextModel:picTextModel];
    }
    return self;
}

- (void)createSubViewsWithPicTextModel:(ProductLoadMorePicTextModel *)picTextModel
{
    [self addSubview:self.scrollView];
    [[MagicWebViewWebPManager shareManager] registerMagicURLProtocolWebView:self.webView];
    [self.scrollView addSubview:self.webView];
    [self.scrollView addSubview:self.recommendLabel];
    [self.scrollView addSubview:self.collectionView];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    MC_SELF_WEAK(self)
    MagicScrollPageRefreshHeader *header = [MagicScrollPageRefreshHeader headerWithRefreshingBlock:^{
        [weakself.scrollView.mj_header endRefreshing];
        [weakself executeProductLoadMorePicTextViewGoTop];
    }];
    self.scrollView.mj_header = header;
}

#pragma mark -Lazy
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    }
    return _scrollView;
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel = [[UILabel alloc] init];
        _recommendLabel.text = @"   更多推荐";
        _recommendLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
        _recommendLabel.font = [UIFont systemFontOfSize:12];
        _recommendLabel.backgroundColor = [UIColor whiteColor];
    }
    return _recommendLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, recommendItemSpace);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(recommendItemWidth, recommendViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ProductLoadMorePicTextCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize resize = [self.webView sizeThatFits:CGSizeZero];
        self.webView.frame =  CGRectMake(0, 0, CGRectGetWidth(self.frame), resize.height);
        self.recommendLabel.frame = CGRectMake(0, CGRectGetMaxY(self.webView.frame) + recommendViewSpace, CGRectGetWidth(self.frame), recommendTitleHeight);
        self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.recommendLabel.frame), CGRectGetWidth(self.frame), recommendViewHeight);
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetMaxY(self.collectionView.frame) + recommendViewSpace);
    }
}

-(void)dealloc
{
    [[MagicWebViewWebPManager shareManager] unregisterMagicURLProtocolWebView:self.webView];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    self.scrollView = nil;
    self.webView = nil;
    self.collectionView = nil;
    self.recommendDataArray = nil;
    self.picTextDataArray = nil;
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return [self handleWebviewEventWithRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"商品详情web错误 %@", error);
}

- (BOOL)handleWebviewEventWithRequest:(NSURLRequest *)request
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"selectIndex="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *index = [url substringFromIndex:begin];
        [self executeProductLoadMorePicTextViewZoomImageWithIndexString:index];
        return NO;
    }
    return YES;
}

#pragma mark - CustomHTML

- (void)loadWebViewCustomHTMLWithImageUrls:(NSArray *)imageUrls
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self settingWebViewBodyWithImageUrlArray:imageUrls]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)settingWebViewBodyWithImageUrlArray:(NSArray *)imageUrlArray
{
    NSMutableString *body = [NSMutableString string];
    for (NSInteger i = 0; i < imageUrlArray.count; i++) {
        NSString *imgUrl = [NSString stringWithFormat:@"%@", [imageUrlArray objectAtIndex:i]];
        imgUrl = [self handlerImgUrlString:imgUrl];
        NSMutableString *html = [NSMutableString string];
        [html appendString:@"<div class=\"img-box\">"];
        NSString *onload = [NSString stringWithFormat:@"this.onclick = function() {window.location.href = 'selectIndex=' + %ld;}", i];
        [html appendFormat:@"<img onload=\"%@\" style=\"clear:both; display:block; margin:auto;\" width=\"100%%\" src=\"%@\">", onload, imgUrl];
        [html appendString:@"</div>"];
        [body appendString:html];
    }
    return body;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recommendDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductLoadMorePicTextCollectionViewCell *cell = (ProductLoadMorePicTextCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.productRecommendModel = [self.recommendDataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   ProductRecommend *productRecommendModel = [self.recommendDataArray objectAtIndex:indexPath.row];
   [self executeProductLoadMorePicTextViewPushProductWithSkuId:productRecommendModel.ID];
}


#pragma mark -ProductLoadMoreViewDelegate
- (void)executeProductLoadMorePicTextViewZoomImageWithIndexString:(NSString *)indexString
{
    if ([self.delegate respondsToSelector:@selector(productLoadMorePicTextViewZoomImageWithIndex:)]) {
        [self.delegate productLoadMorePicTextViewZoomImageWithIndex:[indexString integerValue]];
    }
}

- (void)executeProductLoadMorePicTextViewPushProductWithSkuId:(NSInteger)skuId
{
    if ([self.delegate respondsToSelector:@selector(productLoadMorePicTextViewPushProductWithSkuId:)]) {
        [self.delegate productLoadMorePicTextViewPushProductWithSkuId:[NSString stringWithFormat:@"%ld", skuId]];
    }
}

- (void)executeProductLoadMorePicTextViewGoTop
{
    if ([self.delegate respondsToSelector:@selector(productLoadMorePicTextViewGoTop)]) {
        [self.delegate productLoadMorePicTextViewGoTop];
    }
}


#pragma mark - Reload
- (void)reload{
    [self loadWebViewCustomHTMLWithImageUrls:self.picTextDataArray];
    [self.collectionView reloadData];
}

#pragma mark - IMGURL
- (NSString *)handlerImgUrlString:(NSString *)imgUrlString
{
    NSString *result = [NetworkManager httpsSchemeHandler:imgUrlString];
    // webp
    if ([result containsString:@"showjoy.com"] && ![result hasSuffix:@".webp"]) {
        result = [result stringByAppendingString:@".webp"];
    }
    return result;
}
@end
