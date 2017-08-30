//
//  ProductSecondPageView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/22.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSecondPageView.h"
#import "ProductRecommendView.h"
@interface ProductSecondPageView ()<ProductRecommendViewDelegate, UIWebViewDelegate>

@end

@implementation ProductSecondPageView{
    ProductRecommendView *_productRecommendView;                 //更多推荐
    UIWebView *_webView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_width,  Screen_height - 64)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self addSubview:_webView];
    NSString *UrlString = [NSString stringWithFormat:@"https://shop.m.showjoy.com/shop/item/pictext/%ld.html", _productDetailModel.item.ID];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:UrlString]];
    [_webView loadRequest:request];
    
    _productRecommendView = [[ProductRecommendView alloc] initWithFrame:CGRectMake(0, _webView.frame.size.height, Screen_width, 211)];
    _productRecommendView.myDelegate = self;
    [self addSubview:_productRecommendView];
}

#pragma mark - ProductRecommendViewDelegate
- (void)productRecommendViewSelectedSkuId:(NSInteger)skuId{
    NSLog(@"%ld",skuId);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
    
    //获取内容实际高度（像素）
    //改变 webView 的高度
    _webView.frame = CGRectMake(0, 0, Screen_width,  webViewHeight);
    _productRecommendView.frame = CGRectMake(0, _webView.frame.size.height, Screen_width, 211);
    //改变 ScorllView 的高度
    self.contentSize = CGSizeMake(Screen_width, webViewHeight + 211 + 70);
    //关闭 webView 的滚动
    UIScrollView *tempView = (UIScrollView *)[_webView.subviews objectAtIndex:0];
    tempView.scrollEnabled = NO;
    NSLog(@"%f",webViewHeight);
    NSLog(@"结束加载");
}

#pragma mark -更新数据
- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    
    _productRecommendView.productDetailModel = _productDetailModel;
    
}

@end
