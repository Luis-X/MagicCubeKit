//
//  ProductLoadMorePicTextModel.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/12/4.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PicTextItem;
@class PicTextItemPic;
@class PicTextSpu;

@interface ProductLoadMorePicTextModel : NSObject
@property (nonatomic, strong) PicTextItem *item;
@property (nonatomic, strong) PicTextItemPic *itemPic;
@property (nonatomic, copy) NSString *pageName;
@end

@interface PicTextItemPic : NSObject
@property (nonatomic, strong) PicTextItem * item;
@property (nonatomic, strong) NSArray *packageImages;
@property (nonatomic, strong) PicTextSpu * spu;
@end

@interface PicTextSpu : NSObject
@property (nonatomic, copy) NSString *aliases;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, assign) NSInteger cateId;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, assign) NSInteger gmtCreate;
@property (nonatomic, assign) NSInteger gmtModified;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) NSInteger isDelete;
@property (nonatomic, assign) NSInteger isStop;
@property (nonatomic, assign) NSInteger isSuit;
@property (nonatomic, copy) NSString *seoDescription;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) NSInteger statusId;
@property (nonatomic, copy) NSString *zhName;
@end

@interface PicTextItem : NSObject
@property (nonatomic, copy) NSString *brandZhName;
@property (nonatomic, copy) NSString *cate;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger inventory;
@property (nonatomic, assign) BOOL isCanTry;
@property (nonatomic, copy) NSString *name;
@end
