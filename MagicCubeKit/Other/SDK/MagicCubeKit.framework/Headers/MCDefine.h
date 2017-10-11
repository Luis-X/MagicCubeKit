//
//  MCDefine.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/25.
//  Copyright © 2017年 LuisX. All rights reserved.
//
//
//======================================================
//              __          _     _  __
//             / /   __  __(_)___| |/ /
//            / /   / / / / / ___/   /
//           / /___/ /_/ / (__  )   |
//          /_____/\__,_/_/____/_/|_|
//
//======================================================



/* 调试日志 */
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"😜%s [line: %d] \n📒" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

/* 路径 */
#define MC_PATH(n,t)            [[NSBundle mainBundle] pathForResource:(n) ofType:(t)]                                     //文件路径
#define MC_PATH_PNG(n)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:(n)] ofType:@"png"]  //png路径
#define MC_PATH_JPG(n)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:(n)] ofType:@"jpg"]  //jpg路径

/* 图片 */
#define MC_IMAGE_NAMED(n)       [UIImage imageNamed:(n)]                                                                     //图片名
#define MC_IMAGE_FILE(n,t)      [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(n) ofType:(t)]]     //图片文件
#define MC_IMAGE_FILE_PNG(n)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(n) ofType:@"png"]]  //png文件
#define MC_IMAGE_FILE_JPG(n)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(n) ofType:@"jpg"]]  //jpg文件

/* 沙盒 */
#define MC_BOX_TEMP             NSTemporaryDirectory()                                                                         //临时区
#define MC_BOX_DOCUMENT         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]  //内容区
#define MC_BOX_CACHE            [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]    //缓存区

/* 屏幕 */
#define MC_SCREEN_W             [UIScreen mainScreen].bounds.size.width   //宽
#define MC_SCREEN_W_SCALE       (MC_SCREEN_W / 375)                       //宽比 (iPhone6)
#define MC_SCREEN_H             [UIScreen mainScreen].bounds.size.height  //高
#define MC_SCREEN_H_SCALE       (MC_SCREEN_H / 667)                       //高比（iPhone6）
#define MC_SCREEN_SCALE         [[UIScreen mainScreen] scale]             //屏幕的分辨率 (1:普通 2:Retian)

/* 控件 */
#define MC_STATUS_BAR_H         (20.f)   //状态栏
#define MC_NAVIGATION_BAR_H     (44.f)   //导航栏
#define MC_TAB_BAR_H            (49.f)   //标签栏
#define MC_TABLEVIEW_CELL_H     (44.f)   //普通cell
#define MC_EN_KEYBOARD_H        (216.f)  //英文键盘
#define MC_CN_KEYBOARD_H        (252.f)  //中文键盘

/* 设备 */
#define MC_DEVICE_IPHONE        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)            //iPhone
#define MC_DEVICE_IPAD          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)              //iPad
#define MC_DEVICE_IPOD          ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])  //iPod

/* 型号 */
#define MC_IS_IPHONE4           ([[UIScreen mainScreen] bounds].size.height == 480)  //480
#define MC_IS_IPHONE5           ([[UIScreen mainScreen] bounds].size.height == 568)  //568
#define MC_IS_IPHONE6           ([[UIScreen mainScreen] bounds].size.height == 667)  //667
#define MC_IS_IPHONE_PLUS       ([[UIScreen mainScreen] bounds].size.height == 736)  //736

/* 系统 */
#define MC_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define MC_IOS6  (MC_SYSTEM_VERSION >= 6.0  && MC_SYSTEM_VERSION < 7)
#define MC_IOS7  (MC_SYSTEM_VERSION >= 7.0  && MC_SYSTEM_VERSION < 8.0)
#define MC_IOS8  (MC_SYSTEM_VERSION >= 8.0  && MC_SYSTEM_VERSION < 9.0)
#define MC_IOS9  (MC_SYSTEM_VERSION >= 9.0  && MC_SYSTEM_VERSION < 10.0)
#define MC_IOS10 (MC_SYSTEM_VERSION >= 10.0 && MC_SYSTEM_VERSION < 11.0)
#define MC_IOS11 (MC_SYSTEM_VERSION >= 11.0 && MC_SYSTEM_VERSION < 12.0)

/* 颜色 */
#define MC_COLOR_RGB(r,g,b)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]             //RGB
#define MC_COLOR_RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]             //RGBA
#define MC_COLOR_RANDOM          MC_COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))  //随机
#define MC_COLOR_CLEAR           [UIColor clearColor]                                                                     //透明
#define MC_COLOR_WHITE_A(a)      [UIColor colorWithWhite:1.0f alpha:(a)]                                                  //透明白
#define MC_COLOR_BLACK_A(a)      [UIColor colorWithWhite:0.0f alpha:(a)]                                                  //透明黑

/* 字体 */
#define MC_FONT(n,s)             [UIFont fontWithName:(n) size:(s)]  //自定义
#define MC_FONT_SYSTEM(s)        [UIFont systemFontOfSize:(s)]       //普通
#define MC_FONT_SYSTEM_BOLD(s)   [UIFont boldSystemFontOfSize:(s)]   //加粗

/* 通知 */
#define MC_NOTICE_ADD(n, f)      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:(n) object:nil]  //添加
#define MC_NOTICE_POST(n, o)     [[NSNotificationCenter defaultCenter] postNotificationName:(n) object:(o)]                         //发送
#define MC_NOTICE_REMOVE()       [[NSNotificationCenter defaultCenter] removeObserver:self]                                         //删除

/** LOCAL */
#define MC_LOCAL_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  //版本号
#define MC_LOCAL_BUILD_VERSION   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]             //构建版本号
#define MC_LOCAL_DISPLAY_NAME    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]            //名称
#define MC_LOCAL_LANGUAGE        [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]                         //语言
#define MC_LOCAL_COUNTRY         [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]                          //国家

/** APP */
#define MC_APP                   [UIApplication sharedApplication]              //应用
#define MC_APP_WINDOW            [UIApplication sharedApplication].keyWindow    //窗口
#define MC_APP_DELEGATE          [UIApplication sharedApplication].delegate     //代理

/* 其他 */
#define MC_SELF_WEAK(type)       __weak typeof(type) weak##type = type;         //弱引用
#define MC_SELF_STRONG(type)     __strong typeof(type) type = weak##type;       //强引用
#define MC_STRING_FORMAT(f, ...) [NSString stringWithFormat:f, ## __VA_ARGS__]  //万能转换

/* 编码 */
#define MC_ENCODE_UTF8(s)      [(s) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]         //编码
#define MC_DECODE_UTF8(s)      [(s) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]      //解码

/*
 *判断是真机还是模拟器
 */
#if TARGET_OS_IPHONE
//真机
#endif

#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

/*
 *使用ARC和不使用ARC
 */
#if __has_feature(objc_arc)
//ARC
#else
//MRC
#endif


