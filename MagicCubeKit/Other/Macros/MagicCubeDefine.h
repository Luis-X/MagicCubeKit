//
//  MagicCubeDefine.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

// LOG
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"😜%s [line: %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

// 资源
#define Magic_image(r, t)               [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:r ofType:t]]
#define Magic_bundle(r, t)              [[NSBundle mainBundle] pathForResource:r ofType:t]
#define Magic_imageNamed(n)             [UIImage imageNamed:[NSString stringWithFormat:@"%@",n]]

// 沙盒
#define Magic_path_temp                 NSTemporaryDirectory()
#define Magic_path_document             [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define Magic_path_cache                [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 屏幕
#define Magic_screen_width              [UIScreen mainScreen].bounds.size.width
#define Magic_screen_height             [UIScreen mainScreen].bounds.size.height

// 颜色
#define Magic_color_random              [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define Magic_color_RGB(r, g, b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Magic_color_RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define Magic_color_white_alpha(a)      [UIColor colorWithWhite:1.00 alpha:(a)]
#define Magic_color_black_alpha(a)      [UIColor colorWithWhite:0.00 alpha:(a)]

// 字体
#define Magic_font_system(s)            [UIFont systemFontOfSize:(s)]
#define Magic_font_boldSystem(s)        [UIFont boldSystemFontOfSize:(s)]

// 视图
#define Magic_keyWindow                 [UIApplication sharedApplication].keyWindow

// 通知
#define Magic_notice_add(n, f)          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
#define Magic_notice_post(n, o)         [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
#define Magic_notice_remove()           [[NSNotificationCenter defaultCenter] removeObserver:self]


// 功能
#define Magic_weakSelf(type)             __weak typeof(type) weak##type = type;             // 弱引用
#define Magic_strongSelf(type)           __strong typeof(type) type = weak##type;           // 强引用
#define Magic_FORMAT(f, ...)            [NSString stringWithFormat:f, ## __VA_ARGS__]       // 万能转换
