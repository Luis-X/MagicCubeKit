//
//  ProductConstant.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMPageController.h"
#import <DateTools.h>
#import <MJExtension.h>
#import <STPopup.h>
#import <JMRoundedCorner/JMRoundedCorner.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import "ParallaxHeaderView.h"
#import "DZNSegmentedControl.h"
#import "MagicScrollPage.h"
#import "ZYBannerView.h"
#import "MagicIconButton.h"
#import "SJHSlideMenuView.h"

@interface ProductConstant : NSObject
+ (ProductConstant *)shareManager;
- (STPopupController *)showPopViewControllerWithMagicVC:(UIViewController *)magicVC AddController:(UIViewController *)addController CornerRadius:(CGFloat)cornerRadius NavigationBarHidden:(BOOL)navigationBarHidden;
+ (void)setRichSignNumberWithLabel:(UILabel*)label BigSize:(CGFloat)bigSize SmallSize:(CGFloat)smallSize Color:(UIColor *)color;
@end
