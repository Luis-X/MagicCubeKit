//
//  MagicPhotoBrowserManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDMPhotoBrowser.h>

@interface MagicPhotoBrowserManager : NSObject
+ (MagicPhotoBrowserManager *)shareManager;
/**
 打开图片浏览
 
 @param controller      在哪个视图控制器显示
 @param photos          photo数据（支持:UIImage、URLString、filePath、NSURL）
 @param startIndex      开始下标
 */
- (IDMPhotoBrowser *)showMagicPhotoBrowserAddControler:(UIViewController *)controller photos:(NSArray *)photos startIndex:(NSInteger)startIndex;
@end
