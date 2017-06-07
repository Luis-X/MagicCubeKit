//
//  ProductConstant.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/1.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <STPopup.h>
@interface ProductConstant : NSObject
+ (ProductConstant *)shareManager;
- (STPopupController *)showPopViewControllerWithMagicVC:(UIViewController *)magicVC AddController:(UIViewController *)addController CornerRadius:(CGFloat)cornerRadius NavigationBarHidden:(BOOL)navigationBarHidden;
@end
