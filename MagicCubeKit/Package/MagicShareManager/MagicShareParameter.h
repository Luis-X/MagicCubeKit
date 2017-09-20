//
//  MagicShareParameter.h
//  DaRenShop
//
//  Created by LuisX on 2017/9/18.
//  Copyright © 2017年 YunRuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicShareParameter : NSObject
@property (nonatomic, copy) NSString *share_title;         //标题
@property (nonatomic, copy) NSString *share_des;           //描述
@property (nonatomic, copy) NSString *share_thumbImageUrl; //预览图
@property (nonatomic, copy) NSString *share_webpageUrl;    //链接
@end
