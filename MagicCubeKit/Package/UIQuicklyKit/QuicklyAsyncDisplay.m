//
//  QuicklyAsyncDisplay.m
//  UIQuicklyKit
//
//  Created by LuisX on 2017/3/16.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "QuicklyAsyncDisplay.h"

@implementation QuicklyAsyncDisplay
#pragma mark - ASDisplayNode
+ (ASDisplayNode *)quicklyASDisplayNodeAddTo:(id)node{

    ASDisplayNode *displayNode = [ASDisplayNode new];
    [node addSubnode:displayNode];
    return displayNode;
    
}

+ (ASDisplayNode *)quicklyASDisplayNodeAddTo:(ASDisplayNode *)node backgroundColor:(UIColor *)backgroundColor{
    
    ASDisplayNode *displayNode = [self quicklyASDisplayNodeAddTo:node];
    displayNode.backgroundColor = backgroundColor;
    return displayNode;
    
}


#pragma mark - Node富文本
/**
 Node富文本

 @param text 文本
 @param textColor 文本颜色
 @param font 字体
 */
+ (NSAttributedString *)nodeAttributesStringText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font{

    //快速创建富文本
    NSDictionary *attributesDic = @{NSFontAttributeName: font, NSForegroundColorAttributeName : textColor};
    NSAttributedString *attributesString = [[NSAttributedString alloc] initWithString:text attributes:attributesDic];
    return attributesString;

}



#pragma mark - ASTextNode
+ (ASTextNode *)quicklyASTextNodeAddTo:(ASDisplayNode *)node{

    //只支持富文本显示
    ASTextNode *textNode = [ASTextNode new];
    [node addSubnode:textNode];
    return textNode;

}



#pragma mark - ASButtonNode
/**
 NodeButton(文本)

 @param addNode 添加View
 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param cornerRadius 圆角
 @param backgroundColor 背景颜色
 @param contentVerticalAlignment 内容竖直对齐方式
 @param contentHorizontalAlignment 内容水平对齐方式
 */
+ (ASButtonNode *)nodeButtonNodeAddNode:(ASDisplayNode *)addNode Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font CornerRadius:(CGFloat)cornerRadius BackgroundColor:(UIColor *)backgroundColor ContentVerticalAlignment:(ASVerticalAlignment)contentVerticalAlignment ContentHorizontalAlignment:(ASHorizontalAlignment)contentHorizontalAlignment{

    ASButtonNode *buttonNode = [ASButtonNode new];
    buttonNode.backgroundColor = backgroundColor;
    if (title) {
        [buttonNode setTitle:title withFont:font withColor:titleColor forState:ASControlStateNormal];
    }
    buttonNode.contentVerticalAlignment = contentVerticalAlignment;
    buttonNode.contentHorizontalAlignment = contentHorizontalAlignment;
    buttonNode.cornerRadius = cornerRadius;
    [addNode addSubnode:buttonNode];
    return buttonNode;

}

/**
 NodeButton(图文)

 @param addNode 添加View
 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param image 图片
 @param imageAlignment 图片对齐方式(前/后)
 @param cornerRadius 圆角
 @param backgroundColor 背景颜色
 @param contentVerticalAlignment 内容竖直对齐方式
 @param contentHorizontalAlignment 内容水平对齐方式
 */
+ (ASButtonNode *)nodeButtonNodeAddNode:(ASDisplayNode *)addNode Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font Image:(UIImage *)image ImageAlignment:(ASButtonNodeImageAlignment)imageAlignment CornerRadius:(CGFloat)cornerRadius BackgroundColor:(UIColor *)backgroundColor ContentVerticalAlignment:(ASVerticalAlignment)contentVerticalAlignment ContentHorizontalAlignment:(ASHorizontalAlignment)contentHorizontalAlignment{

    ASButtonNode *buttonNode = [ASButtonNode new];
    buttonNode.backgroundColor = backgroundColor;
    if (title) {
        [buttonNode setTitle:title withFont:font withColor:titleColor forState:ASControlStateNormal];
    }
    if (image) {
        [buttonNode setImage:image forState:ASControlStateNormal];
    }
    [buttonNode setImageAlignment:imageAlignment];
    buttonNode.contentVerticalAlignment = contentVerticalAlignment;
    buttonNode.contentHorizontalAlignment = contentHorizontalAlignment;
    buttonNode.cornerRadius = cornerRadius;
    [addNode addSubnode:buttonNode];
    return buttonNode;

}



#pragma mark - NodeImageView
/**
 NodeImageView(普通)

 @param addNode 添加View
 @param clipsToBounds 边界裁剪
 @param contentMode 显示方式(尽量使用枚举名称)
 */
+ (ASImageNode *)nodeImageNodeAddNode:(ASDisplayNode *)addNode ClipsToBounds:(BOOL)clipsToBounds ContentMode:(UIViewContentMode)contentMode{

    ASImageNode *imageNode = [ASImageNode new];
    //imageNode.backgroundColor = [UIColor grayColor];
    imageNode.clipsToBounds = clipsToBounds;
    imageNode.contentMode = contentMode;
    [addNode addSubnode:imageNode];
    return imageNode;

}



#pragma mark - ASNetworkImageNode
/**
 NodeImageView(网络)

 @param addNode 添加View
 @param clipsToBounds 边界裁剪
 @param contentMode 显示方式(尽量使用枚举名称)
 @param defaultImage 占位图
 */
+ (ASNetworkImageNode *)nodeNetworkImageNodeAddNode:(ASDisplayNode *)addNode ClipsToBounds:(BOOL)clipsToBounds ContentMode:(UIViewContentMode)contentMode DefaultImage:(UIImage *)defaultImage{

    //网络图片
    ASNetworkImageNode *networkImageNode = [ASNetworkImageNode new];
    //networkImageNode.backgroundColor = [UIColor grayColor];
    if (defaultImage) {
        networkImageNode.defaultImage = defaultImage;
    }
    networkImageNode.clipsToBounds = clipsToBounds;
    networkImageNode.contentMode = contentMode;
    [addNode addSubnode:networkImageNode];
    return networkImageNode;

}


@end
