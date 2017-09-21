//
//  UILabel+Tool.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/9/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "UILabel+Tool.h"

@implementation UILabel (Tool)
/**
 行间距
 */
- (void)lineSpace:(CGFloat)lineSpace{
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:self.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:20];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];
    self.attributedText = attrString;
    
}
@end
