//
//  ProductSpecialTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/6.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSpecialTableViewCell.h"


#define DATE_FORMATTER_ONE @"MM月dd日HH点"
#define DATE_FORMATTER_TWO @"MM月dd日HH:mm"

@implementation ProductSpecialTableViewCell{
    UIView *_cellBackgroundView;     //背景
    UIButton *_tagButton;            //标签
    UILabel *_messageLabel;          //信息
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)createSubViews{

    _cellBackgroundView = [UIView new];
    _cellBackgroundView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, Magic_screen_Width, 44) andColors:@[[UIColor colorWithHexString:@"#F13390"], [UIColor colorWithHexString:@"#F03558"]]];
    
    [self.contentView addSubview:_cellBackgroundView];

    
    _tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tagButton setTitle:@"限时特卖" forState:UIControlStateNormal];
    [_tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _tagButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _tagButton.layer.masksToBounds = YES;
    _tagButton.layer.cornerRadius = 26 / 2;
    _tagButton.backgroundColor = [UIColor colorWithHexString:@"#FFE9E9"];
    [_cellBackgroundView addSubview:_tagButton];

    
    _messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.adjustsFontSizeToFitWidth = YES;
    //_messageLabel.backgroundColor = [UIColor redColor];
    [_cellBackgroundView addSubview:_messageLabel];
    
}

- (void)settingAutoLayout{
    
    [_cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
    [_tagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cellBackgroundView).offset(15);
        make.size.mas_equalTo(CGSizeMake(69, 26 ));
        make.centerY.equalTo(_cellBackgroundView);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tagButton);
        make.left.greaterThanOrEqualTo(_tagButton.mas_right).offset(5);
        make.right.equalTo(_cellBackgroundView).offset(-15);
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

- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    
    NSString *startTime = [self getDateStringWithTimeValue:_productDetailModel.skuCommission.startTime formatter:DATE_FORMATTER_TWO];
    NSString *message = [NSString stringWithFormat:@"%@开抢！特卖价格：¥%.2f", startTime, _productDetailModel.price];
    _messageLabel.text = message;
}

/**
 根据13位时间戳返回日期
 */
- (NSString *)getDateStringWithTimeValue:(NSTimeInterval)timeValue formatter:(NSString *)formatter{
    
    if (timeValue <= 0) {
        return nil;
    }
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timeValue / 1000];
    return [timeDate formattedDateWithFormat:formatter];
    
}
@end
