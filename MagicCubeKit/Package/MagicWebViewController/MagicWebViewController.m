//
//  MagicWebViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/3.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicWebViewController.h"
#import <WebKit/WebKit.h>
#import "MagicWebView-WebP.h"

@interface MagicWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) UIProgressView *progressView;     //进度条
@property (nonatomic, strong) WKWebView *wkWebView;             //WKWebView网页
@end

@implementation MagicWebViewController{
    NSString *_requestURLString;         //初始化URLString
}

// 销毁
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[MagicWebViewWebPManager shareManager] unregisterMagicURLProtocolWebView:self.wkWebView];
}

- (instancetype)initWithRequestURL:(NSString *)url{
    self = [super init];
    if (self) {
        _requestURLString = MC_DECODE_UTF8(url);
        [self initialData];
    }
    return self;
}

// 默认值
- (void)initialData{
    _webTitleEnable = YES;
    _progressColor = [UIColor blueColor];
    _progressHeight = 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (MC_SYSTEM_VERSION < MC_IOS8) {
        NSLog(@"不支持iOS8以下机型");
        return;
    }
    
    [self customLeftNavigationBarButtonItem];
    [self customRightNavigationBarButtonItem];
    
    // 注册协议支持webP
    [[MagicWebViewWebPManager shareManager] registerMagicURLProtocolWebView:self.wkWebView];
    // 加载请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_requestURLString]];
    [self.wkWebView loadRequest:request];

}

#pragma mark - 懒加载
// WKWebView
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _wkWebView.backgroundColor = [UIColor whiteColor];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //监听进度
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

// 进度条
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, _progressHeight)];
        _progressView.backgroundColor = [UIColor clearColor];           // 背景色
        _progressView.progressTintColor = _progressColor;               // 已过度颜色
        _progressView.trackTintColor = [UIColor clearColor];            // 未过度颜色
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UI
- (void)loadingWebViewTitle{
    if (_webTitleEnable) {
        self.title = self.wkWebView.title;
    }
}

#pragma mark - WKNavigationDelegate
// 1、发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    self.progressView.hidden = NO;
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
    [self loadingWebViewTitle];
    NSLog(@"完成: %@",  webView.URL.description);
}

// 接收到服务器跳转请求
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

#pragma mark - WKUIDelegate
/*
 // 创建一个新的WebView
 - (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
 }
 */

/**
 Alert确认框
 
 @param webView             实现该代理的webview
 @param message             内容
 @param frame               主窗口
 @param completionHandler   消失回调
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}

/**
 Confirm确认框
 
 @param webView             实现该代理的webview
 @param message             内容
 @param frame               主窗口
 @param completionHandler   消失回调
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
}

/**
 TextInput输入框
 
 @param webView             实现该代理的webview
 @param prompt              提示
 @param defaultText         默认文本
 @param frame               主窗口
 @param completionHandler   消失回调
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
}



#pragma mark - WKScriptMessageHandler
// 接收到JS脚本调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}


#pragma mark - 加载进度
/**
 监听回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (object == self.wkWebView && [keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] ) {
        
        CGFloat newProgress = self.wkWebView.estimatedProgress;             //最新进度
        CGFloat oldProgress = self.progressView.progress;                   //显示进度
        
        [self.progressView setAlpha:1.0f];
        BOOL animated = (newProgress > oldProgress) ? YES : NO;
        [self.progressView setProgress:newProgress animated:animated];
        if (newProgress >= 1.0f) {
            //动画效果
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            }completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

#pragma mark - 导航栏
/**
 自定义导航栏Item
 */
- (UIBarButtonItem *)customNavigationBarButtonItemWithimageNamed:(NSString *)imageName action:(SEL)action{
    
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
    
}

// 返回按钮
- (void)customLeftNavigationBarButtonItem{
    self.navigationItem.leftBarButtonItem = [self customNavigationBarButtonItemWithimageNamed:@"h5_preNavi@2x.png"
                                                                                       action:@selector(webViewGoBack)];
}

// 菜单按钮
- (void)customRightNavigationBarButtonItem{
    self.navigationItem.rightBarButtonItem = [self customNavigationBarButtonItemWithimageNamed:@"h5_popovermenu_share@2x"
                                                                                        action:@selector(showMenuAlertView)];
}

// 关闭按钮(显示、隐藏)
- (void)configCloseButton{
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.titleLabel.font = MC_FONT_SYSTEM(16);
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(webViewClose) forControlEvents:UIControlEventTouchUpInside];
    [closeButton sizeToFit];
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    NSMutableArray *newArr = [NSMutableArray arrayWithObjects:self.navigationItem.leftBarButtonItem,colseItem, nil];
    self.navigationItem.leftBarButtonItems = newArr;
    
}

// 菜单
- (void)showMenuAlertView{
    
    NSString *url = self.wkWebView.URL.absoluteString;
    MagicActivity *activity0 = [MagicActivity activityWithTitle:@"Safari打开"
                                                          image:MC_IMAGE_NAMED(@"MagicWebViewUI.bundle/share_icon_safari")
                                                      highImage:MC_IMAGE_NAMED(@"MagicWebViewUI.bundle/share_icon_safari_high")];
    MagicActivity *activity1 = [MagicActivity activityWithTitle:@"复制链接"
                                                          image:MC_IMAGE_NAMED(@"MagicWebViewUI.bundle/share_icon_copy")
                                                      highImage:MC_IMAGE_NAMED(@"MagicWebViewUI.bundle/share_icon_copy_high")];
    MagicActivity *activity2 = [MagicActivity activityWithTitle:@"刷新"
                                                          image:MC_IMAGE_NAMED(@"MagicWebViewUI.bundle/share_icon_refresh")
                                                      highImage:MC_IMAGE_NAMED(@"MagicWebViewUI.bundle/share_icon_refresh_high")];
       NSArray *activitys = @[activity0, activity1, activity2];
    [MagicActivityViewController presentAddViewController:self topCustomView:nil activitys:activitys activityHeight:110 completion:^(NSInteger selectedIndex) {
        
        if (selectedIndex == 0) {
            [self webViewSafariUrl:url];
        }
        if (selectedIndex == 1) {
            [self webViewCopyUrl:url];
        }
        if (selectedIndex == 2) {
            [self webViewReload];
        }
        
    }];
    
}


#pragma mark - Action
/**
 返回
 */
- (void)webViewGoBack{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        if (self.navigationItem.leftBarButtonItems.count == 1) {
            [self configCloseButton];
        }
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 关闭
 */
- (void)webViewClose{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 Safari打开
 */
- (void)webViewSafariUrl:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

/**
 复制链接
 */
- (void)webViewCopyUrl:(NSString *)url{
    [[UIPasteboard generalPasteboard] setString:url];
    [QuicklyHUD showWindowsOnlyTextHUDText:@"已复制到剪切板"];
}

/**
 刷新
 */
- (void)webViewReload{
    [self.wkWebView reload];
}



@end
