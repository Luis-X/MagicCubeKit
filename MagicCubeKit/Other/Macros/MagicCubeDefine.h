//
//  MagicCubeDefine.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

/*
 *读取本地图片
 */
#define Magic_LoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

#define Magic_Screen_height [UIScreen mainScreen].bounds.size.height
#define Magic_Screen_width [UIScreen mainScreen].bounds.size.width
