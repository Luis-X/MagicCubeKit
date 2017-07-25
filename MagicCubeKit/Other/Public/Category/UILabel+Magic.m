//
//  UILabel+Magic.m
//  
//
//  Created by LuisX on 2017/7/25.
//
//

#import "UILabel+Magic.h"

@implementation UILabel (Magic)

/**
 行间距
 */
- (void)magicLineSpace:(CGFloat)lineSpace{
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:self.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:20];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];
    self.attributedText = attrString;
    
}
@end
