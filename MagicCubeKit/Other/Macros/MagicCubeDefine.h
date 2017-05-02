//
//  MagicCubeDefine.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

//资源
#define Magic_image(file,type)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define Magic_bundle(file, type)        [[NSBundle mainBundle] pathForResource:file ofType:type]

//屏幕
#define Magic_screen_Width              [UIScreen mainScreen].bounds.size.width
#define Magic_screen_Height             [UIScreen mainScreen].bounds.size.height

//颜色
#define Magic_color_Random              [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define Magic_color_RGB(r, g, b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Magic_color_RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define Magic_color_white_alpha(a)      [UIColor colorWithWhite:1.00 alpha:(a)]
#define Magic_color_black_alpha(a)      [UIColor colorWithWhite:0.00 alpha:(a)]

//字体
#define Magic_font_system(a)            [UIFont systemFontOfSize:(a)]

//视图
#define Magic_keyWindow                 [UIApplication sharedApplication].keyWindow
