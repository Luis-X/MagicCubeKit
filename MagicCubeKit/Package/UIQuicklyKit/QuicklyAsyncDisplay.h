//
//  QuicklyAsyncDisplay.h
//  UIQuicklyKit
//
//  Created by LuisX on 2017/3/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIQuicklyKit.h"

@interface QuicklyAsyncDisplay : NSObject
/*
 *
 * AsyncDisplayKit
 *
 */
// ASDisplayNode
+ (ASDisplayNode *)quicklyASDisplayNodeAddTo:(id)node;
+ (ASDisplayNode *)quicklyASDisplayNodeAddTo:(ASDisplayNode *)node backgroundColor:(UIColor *)backgroundColor;

// ASTextNode
+ (NSAttributedString *)nodeAttributesStringText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;
+ (ASTextNode *)quicklyASTextNodeAddTo:(ASDisplayNode *)node;

// ASButtonNode
+ (ASButtonNode *)quicklyASButtonNodeAddTo:(ASDisplayNode *)node title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor verticalAlignment:(ASVerticalAlignment)vertical horizontalAlignment:(ASHorizontalAlignment)horizontal;
+ (ASButtonNode *)quicklyASButtonNodeAddTo:(ASDisplayNode *)node title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image imageAlignment:(ASButtonNodeImageAlignment)imageAlignment cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor verticalAlignment:(ASVerticalAlignment)vertical horizontalAlignment:(ASHorizontalAlignment)horizontal;

// ASImageNode
+ (ASImageNode *)quicklyASImageNodeAddTo:(ASDisplayNode *)node clipsToBounds:(BOOL)clips contentMode:(UIViewContentMode)mode;

// ASNetworkImageNode
+ (ASNetworkImageNode *)quicklyASNetworkImageNodeAddTo:(ASDisplayNode *)node clipsToBounds:(BOOL)clips contentMode:(UIViewContentMode)mode defaultImage:(UIImage *)defaultImage;
@end
