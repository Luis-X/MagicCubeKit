//
//  ShareQRCodeImageView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/9.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ShareQRCodeImageView.h"

@implementation ShareQRCodeImageView

+ (UIImageView *)createMainViewWithBackgroundImage:(UIImage *)backgroundImage{
    
    UIImageView *backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    backgroudImageView.contentMode = 2;
    backgroudImageView.clipsToBounds = YES;
    [backgroudImageView setImage:backgroundImage];
    
    //日期
    UILabel *dateLabel = [UILabel new];
    dateLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    dateLabel.font = [UIFont systemFontOfSize:18];
    [backgroudImageView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroudImageView).offset(78);
        make.centerX.equalTo(backgroudImageView);
    }];
    
    //商品图
    UIImageView *imageView = [UIImageView new];
    [backgroudImageView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroudImageView).offset(150);
        make.size.mas_offset(CGSizeMake(300, 300));
        make.centerX.equalTo(backgroudImageView);
    }];
    
    //底部视图
    UIView *bottomBoxView = [UIView new];
    [backgroudImageView addSubview:bottomBoxView];
    [bottomBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backgroudImageView).offset(-28);
        make.size.mas_equalTo(CGSizeMake(290, 88));
        make.centerX.equalTo(backgroudImageView);
    }];
    
    //二维码
    UIImageView *qrCodeImageView = [UIImageView new];
    qrCodeImageView.backgroundColor = [UIColor redColor];
    [bottomBoxView addSubview:qrCodeImageView];
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(bottomBoxView);
        make.left.equalTo(bottomBoxView).offset(40);
    }];
    
    //右侧内容
    UIView *rightBoxView = [UIView new];
    [backgroudImageView addSubview:rightBoxView];
    [rightBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 75));
        make.centerY.equalTo(bottomBoxView);
        make.left.equalTo(qrCodeImageView.mas_right).offset(17);
    }];
    
    //价格
    UILabel *priceLabel = [UILabel new];
    [rightBoxView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(rightBoxView);
    }];
    
    //原价
    UILabel *originalPriceLabel = [UILabel new];
    originalPriceLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    originalPriceLabel.font = [UIFont systemFontOfSize:11];
    [rightBoxView addSubview:originalPriceLabel];
    [originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom);
        make.centerX.equalTo(rightBoxView);
    }];
    
    
    //店铺名
    UILabel *shopNameLabel = [UILabel new];
    shopNameLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    shopNameLabel.font = [UIFont boldSystemFontOfSize:12];
    [rightBoxView addSubview:shopNameLabel];
    [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(rightBoxView);
    }];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [backgroudImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomBoxView.mas_top).offset(-15);
        make.centerX.equalTo(backgroudImageView);
    }];
    
    //赋值
    titleLabel.text = @"[SKII]轻柔洁净口碑之选护肤面霜(预售)";
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3289587671,3747760651&fm=206&gp=0.jpg"]];
    priceLabel.text = @"¥4234.00";
    originalPriceLabel.text = @"达人店价 ¥469.00";
    if (originalPriceLabel.text.length) {
        NSMutableAttributedString *originalPriceLineString = [[NSMutableAttributedString alloc] initWithString:originalPriceLabel.text];
        [originalPriceLineString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, originalPriceLineString.length)];
        originalPriceLabel.attributedText = originalPriceLineString;
    }

    dateLabel.text = @"06月09日 10:00";
    shopNameLabel.text = @"小猫的杂货铺极限状态";
    [self setRichNumberWithLabel:priceLabel BigSize:36 SmallSize:15 Color:[UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00]];
    
    return backgroudImageView;
}

#pragma mark - 样式
+ (void)setRichNumberWithLabel:(UILabel*)label BigSize:(CGFloat)bigSize SmallSize:(CGFloat)smallSize Color:(UIColor *)color{
    
    if (label.text == nil) {
        //NSLog(@"过滤空数据");
        return;
    }
    
    NSArray *aimArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];      //生效字符
    NSString *flagString = @".";                                                            //分割标识
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSString *temp = nil;
    for(int i = 0; i < [attributedString length]; i++){
        
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        
        for (NSString *aimString in aimArray) {
            if([temp isEqualToString:aimString]){
                [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:bigSize]} range:NSMakeRange(i, 1)];
            }
        }
        
        if([temp isEqualToString:@"¥"] || [temp isEqualToString:flagString]){
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:smallSize]} range:NSMakeRange(i, 1)];
        }
        
        if ([temp isEqualToString:flagString]) {
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:smallSize]} range:NSMakeRange(i, (attributedString.length - i))];
            break;
        }
        
    }
    
    label.attributedText = attributedString;
    
}

@end
