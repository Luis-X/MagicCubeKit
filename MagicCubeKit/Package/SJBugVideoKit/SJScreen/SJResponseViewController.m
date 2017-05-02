//
//  SJResponseViewController.m
//  DaRenShop
//
//  Created by LuisX on 2017/4/18.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import "SJResponseViewController.h"
#import "SJResponeInfo.h"
#import <sys/utsname.h>
#import "SJBugVideoConstant.h"

#define Network_send_address @"https://oapi.dingtalk.com/robot/send?access_token=41faca47336e7e2fe44a2d5d2a7549eed05511515e0d4c0bce8a7c81e60e6297"
#define Network_send_pic_address @"https://file.showjoy.com/saveFile/"
#define TextView_max_height 300.0f
#define TextView_min_height 50.0f
#define TextView_placeholder  @"您遇到的问题..."
@interface SJResponseViewController ()<UITextViewDelegate>

@end

@implementation SJResponseViewController{
    UIView *_topToolView;
    UITextView *_mainTextView;
    SJResponeInfo *_sjResponeInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initailData];
    [self createMainViews];
}

- (void)initailData{
    
    _sjResponeInfo = [SJResponeInfo new];
    
}

- (void)createMainViews{
    
    [self createTopToolBar];
    [self createContentView];
    
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

/**
 导航栏
 */
- (void)createTopToolBar{
    
    _topToolView = [QuicklyUI quicklyUIViewAddTo:self.view backgroundColor:[UIColor blackColor]];
    [_topToolView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(64);
        
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"取消" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_topToolView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_topToolView).offset(10);
        make.left.equalTo(_topToolView).offset(10);
        
    }];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_topToolView addSubview:sendButton];
    [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_topToolView).offset(10);
        make.right.equalTo(_topToolView).offset(-10);
        
    }];
    
    UILabel *titleLabel = [QuicklyUI quicklyUILabelAddTo:_topToolView font:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor]];
    titleLabel.text = @"问题反馈";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(_topToolView).offset(10);
        make.centerX.equalTo(_topToolView);
        
    }];

    UIView *blackLine = [QuicklyUI quicklyUIViewAddTo:_topToolView backgroundColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00]];
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(_topToolView);
        make.height.mas_equalTo(1);
        
    }];
}


/**
 内容视图
 */
- (void)createContentView{
    
    _mainTextView = [UITextView new];
    _mainTextView.backgroundColor = [UIColor clearColor];
    _mainTextView.text = TextView_placeholder;
    _mainTextView.frame = CGRectMake(15, 80, SJ_Screen_Width - (2 * 15), TextView_min_height);
    _mainTextView.font = [UIFont systemFontOfSize:16];
    _mainTextView.delegate = self;
    [self.view addSubview:_mainTextView];
    
    UIImageView *mainImageView = [QuicklyUI quicklyUIImageViewAddTo:self.view];
    mainImageView.userInteractionEnabled = YES;
    [mainImageView setImage:_screenShortImage];
    [mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_mainTextView.mas_bottom).offset(20);
        make.left.equalTo(_mainTextView);
        make.size.mas_equalTo(CGSizeMake(SJ_Screen_Width / 4, SJ_Screen_Height / 4));
        
    }];
    [mainImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainImageViewAction)]];

}

#pragma mark - Action
/**
 取消
 */
- (void)closeButtonAction{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/**
 发送
 */
- (void)sendButtonAction{
    
    if (_mainTextView.text.length <= 0 || [_mainTextView.text isEqualToString:TextView_placeholder]) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"请说明您遇到的问题!"];
        return;
    }
    
    [self uploadImage:_screenShortImage addController:self handler:^(BOOL success) {
        if (success) {
            [self networkSendProblemTitle:@"iOS问题反馈" Message:[self settingSendProblemInfomation]];
        }
    }];
    
}

/**
 放大图片
 */
- (void)mainImageViewAction{
    
    NSLog(@"放大图片：%@", _screenShortImage);
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <= TextView_min_height) {
        size.height = TextView_min_height;
        textView.scrollEnabled = NO;
    }
    if (size.height >= TextView_max_height) {
        size.height = TextView_max_height;
        textView.scrollEnabled = YES;
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:TextView_placeholder]) {
        textView.text = @"";
    }
    
}

#pragma mark - Network
/**
 上传图片

 @param image 图片
 @param controller 视图控制器
 @param finish 完成回调
 */
- (void)uploadImage:(UIImage*)image addController:(UIViewController *)controller handler:(void (^)(BOOL success))finish{
  
    if(controller){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        hud.labelText = @"请稍后...";
    }
    //1. 图片存放地址
    NSString * url = Network_send_pic_address;
    //2. 图片名称自定义
    NSString *imageName = [[NSDate date] formattedDateWithFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
    //3. 图片二进制文件
    NSData *imageData = UIImagePNGRepresentation(image);
    //NSLog(@"文件大小: %ld k", (long)(imageData.length / 1024));
    //4. 发起网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", nil];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:controller.view animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *isSuccess = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]];
            if ([isSuccess isEqualToString:@"1"]) {
                _sjResponeInfo.contentPicUrl = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"data"]];
                finish(YES);
            }
        }else{
            finish(NO);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finish(NO);
        [MBProgressHUD hideAllHUDsForView:controller.view animated:YES];
        [QuicklyHUD showWindowsOnlyTextHUDText:@"请检查您的网络是否顺畅!"];
        
    }];
    
}

/**
 上传信息
 */
- (void)networkSendProblemTitle:(NSString *)title Message:(NSString *)message{
    
    NSDictionary *dic = @{@"msgtype" : @"markdown",
                          @"markdown" : @{@"title" : title, @"text" : message}};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:Network_send_address parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *errcode = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errcode"]];
            if ([errcode isEqualToString:@"0"]) {
                [QuicklyHUD showWindowsOnlyTextHUDText:@"反馈成功!"];
                [self closeButtonAction];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"请检查您的网络是否顺畅!"];
    }];
}

/**
 设置发送信息（markdown）
 */
- (NSString *)settingSendProblemInfomation{
    
    [self getCurrentDeviceInfomation];
    NSString *title = @"**【问题描述】**<br/>";
    NSString *message = [NSString stringWithFormat:@"*%@*<br/>", _mainTextView.text];
    NSString *picUrl = [NSString stringWithFormat:@"![screenShort](%@)<br/>", _sjResponeInfo.contentPicUrl];
    NSString *subTitle = @"**重要参数信息**<br/>";
    NSString *userInfo = [NSString stringWithFormat:@"userId: %@<br/>", _sjResponeInfo.userId];
    NSString *phoneInfo = [NSString stringWithFormat:@"设备型号: %@<br/>设备系统: %@<br/>", _sjResponeInfo.phoneType, _sjResponeInfo.phoneSystem];
    NSString *appInfo = [NSString stringWithFormat:@"App名称: %@<br/>App版本: %@<br/>App构建: %@<br/>", _sjResponeInfo.appName, _sjResponeInfo.appVersion, _sjResponeInfo.appBuild];
    NSString *result = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", title, message, picUrl, subTitle, userInfo, phoneInfo, appInfo];
    //NSLog(@"信息markdown: %@", result);
    return result;
    
}

#pragma mark - 设备信息
/**
 获取设备信息
 */
- (void)getCurrentDeviceInfomation{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    _sjResponeInfo.appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    _sjResponeInfo.appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _sjResponeInfo.appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    _sjResponeInfo.phoneType = [NSString stringWithFormat:@"%@", [self deviceModelName]];
    _sjResponeInfo.phoneSystem = [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    
}

/**
 设备内部版本号转换
 参考:https://www.theiphonewiki.com/wiki/Models
 */
- (NSString *)deviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";

    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceModel isEqualToString:@"iPad4,4"] || [deviceModel isEqualToString:@"iPad4,5"] || [deviceModel isEqualToString:@"iPad4,6"]){
        return @"iPad mini 2";
    }
    if ([deviceModel isEqualToString:@"iPad4,7"] || [deviceModel isEqualToString:@"iPad4,8"] || [deviceModel isEqualToString:@"iPad4,9"]){
        return @"iPad mini 3";
    }
    
    //模拟器
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}

@end
