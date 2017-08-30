//
//  ExampleElementText.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TangramElementHeightProtocol.h"
#import <TMMuiLazyScrollView.h>

@interface ExampleElementText : UIView<TangramElementHeightProtocol, TMMuiLazyScrollViewCellProtocol>
@property (nonatomic, strong) NSString *text;
@end
