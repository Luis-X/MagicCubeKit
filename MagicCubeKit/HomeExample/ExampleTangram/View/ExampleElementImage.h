//
//  ExampleElementImage.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TangramElementHeightProtocol.h"
#import <TMMuiLazyScrollView.h>
#import "TangramDefaultItemModel.h"
#import "TangramEasyElementProtocol.h"


@interface ExampleElementImage : UIView<TangramElementHeightProtocol,TMMuiLazyScrollViewCellProtocol,TangramEasyElementProtocol>

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSNumber *number;

@property (nonatomic, weak) TangramDefaultItemModel *tangramItemModel;

@property (nonatomic, weak) UIView<TangramLayoutProtocol> *atLayout;

@property (nonatomic, weak) TangramBus *tangramBus;


@end
