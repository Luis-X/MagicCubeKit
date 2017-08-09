//
//  ProductOptionSaleTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductOptionSaleTableViewCell.h"
#import "ProductSaleTagView.h"

@implementation ProductOptionSaleTableViewCell{
    UILabel *_messageLabel;             //副标题
    ProductSaleTagView *_saleTagView;   //标签
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@synthesize salesArray = _salesArray;

- (void)setSalesArray:(NSArray *)salesArray{
    
    //重写Setter方法，加载一次控件
    if (salesArray.count > 0 && _flag == NO){
        _flag = YES;
        for (NSInteger i = 0; i  < salesArray.count; i++) {
            NSDictionary *dic = [salesArray objectAtIndex:i];
            NSString *title = [dic objectForKey:@"title"];
            NSString *message = [dic objectForKey:@"message"];
            [self loadingSaleViewWithTitle:title message:message index:i];
        }
    }
    _salesArray = salesArray;
    
}

- (void)loadingSaleViewWithTitle:(NSString *)title message:(NSString *)message index:(NSInteger)index{
    
    UIView *saleBackgroundView = [UIView new];
    [self.contentView addSubview:saleBackgroundView];
    [saleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset((5 + 30 * index) * HOME_IPHONE6_WIDTH);
        make.left.equalTo(self.contentView).offset(10 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(self.contentView).offset(-10 * HOME_IPHONE6_WIDTH);
        make.height.mas_equalTo(30 * HOME_IPHONE6_HEIGHT);
        if (2 == index) {
            make.bottom.equalTo(self.contentView).offset(-5 * HOME_IPHONE6_HEIGHT);
        }
    }];
    
    _saleTagView = [ProductSaleTagView new];
    _saleTagView.title = title;
    _saleTagView.fontSize = 12 * HOME_IPHONE6_HEIGHT;
    _saleTagView.height = 18 * HOME_IPHONE6_HEIGHT;
    [saleBackgroundView addSubview:_saleTagView];
    [_saleTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(saleBackgroundView);
        make.left.equalTo(saleBackgroundView);
    }];
    
    _messageLabel = [UILabel new];
    _messageLabel.text = message;
    _messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _messageLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    [saleBackgroundView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(saleBackgroundView);
        make.left.equalTo(_saleTagView.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
        make.right.lessThanOrEqualTo(saleBackgroundView);
    }];


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
