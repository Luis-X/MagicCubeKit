//
//  WebPageAlertManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/11/8.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "WebPageAlertManager.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface WebPageAlertManager()<WKNavigationDelegate>
@property (nonatomic, strong)WKWebView *wkWebView;
@property (nonatomic, strong)WebViewJavascriptBridge *bridge;
@end

@implementation WebPageAlertManager
+ (WebPageAlertManager *)shareManager
{
    static WebPageAlertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WebPageAlertManager alloc] init];
    });
    return manager;
}

- (void)showWebPageAlert
{
    NSString *requestURLString = @"http://shop.m.showjoy.net/activity/ctopic/47944.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURLString]];
    [self.wkWebView loadRequest:request];
    //使用WebViewJavascriptBridge
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    [_bridge registerHandler:@"shopc_close" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC方法: %@", data);
        responseCallback(@"OC success");
    }];
}

#pragma mark - LazyLoad
- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _wkWebView.backgroundColor = [UIColor whiteColor];
        _wkWebView.navigationDelegate = self;
        [MC_APP_WINDOW addSubview:_wkWebView];
    }
    return _wkWebView;
}

#pragma mark - WKNavigationDelegate
// 1、发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"请求: %@", webView.URL.description);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 2、页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始: %@",  webView.URL.description);
}

// 3、页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"失败");
}

// 3、接收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"响应: %@",  webView.URL.description);
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

// 4、内容开始返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"内容: %@",  webView.URL.description);
}

// 5、页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"完成: %@",  webView.URL.description);
}

// 接收到服务器跳转请求
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

@end
