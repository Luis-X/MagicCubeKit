//
//  AlbumModel.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumModel : NSObject
@property (nonatomic, strong) NSString *time;               //时间
@property (nonatomic, strong) NSString *orginPrice;         //原价
@property (nonatomic, strong) NSString *title;              //标题
@property (nonatomic, strong) NSString *price;              //价格
@property (nonatomic, strong) NSString *postFree;
@property (nonatomic, strong) NSString *image;              //图片
@end

