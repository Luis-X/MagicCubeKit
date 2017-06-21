//
//  ProductOnlineStatusTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductOnlineStatusTableViewCell.h"
#define MORE_TAG_VIEW_TAG 4000

@implementation ProductOnlineStatusTableViewCell{
    UIView *_onLineStatisticsView;              //上架统计视图
    UIView *_onLineBackgroundView;              //上架背景
    UILabel *_onLineIconLabel;                  //上架icon
    UILabel *_onLineCountLabel;                 //上架数目
    UIView *_tagBackgroundView;                 //标签
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
    
    _tagBackgroundView = [UIView new];
    [self.contentView addSubview:_tagBackgroundView];
    
    _onLineStatisticsView = [UIView new];
    _onLineStatisticsView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self.contentView addSubview:_onLineStatisticsView];
    
    _onLineBackgroundView = [UIView new];
    [_onLineStatisticsView addSubview:_onLineBackgroundView];
    
    _onLineIconLabel = [UILabel new];
    _onLineIconLabel.font = [UIFont fontWithName:@"iconfont" size:12 * HOME_IPHONE6_HEIGHT];
    _onLineIconLabel.text = @"\U0000e6f1";
    _onLineIconLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    [_onLineStatisticsView addSubview:_onLineIconLabel];
    
    _onLineCountLabel = [UILabel new];
    _onLineCountLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    _onLineCountLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    [_onLineStatisticsView addSubview:_onLineCountLabel];
    
}

#pragma mark -多标签相关
// 获取标签Label（防止重复创建）
- (UILabel *)getMoreTagLabelWithTag:(NSInteger)tag{
    
    UILabel *aimTagLabel = [_tagBackgroundView viewWithTag:tag];
    if (aimTagLabel == nil) {
        UILabel *createTagLabel = [UILabel new];
        createTagLabel.textAlignment = NSTextAlignmentCenter;
        createTagLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
        createTagLabel.font = [UIFont systemFontOfSize:10 * HOME_IPHONE6_HEIGHT];
        [createTagLabel jm_setImageWithCornerRadius:(23 / 2) * HOME_IPHONE6_HEIGHT borderColor:[UIColor clearColor] borderWidth:0 backgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]];
        createTagLabel.tag = tag;
        [_tagBackgroundView addSubview:createTagLabel];
        return createTagLabel;
    }else{
        return aimTagLabel;
    }
    
}

//更新标签
- (void)updateMoreTagLabelWithArray:(NSArray *)array{
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *text = [array objectAtIndex:i];
        CGFloat width = [self settingCollectionViewItemWidthBoundingWithText:text];
        UILabel *layoutTagLabel = [self getMoreTagLabelWithTag:(MORE_TAG_VIEW_TAG + i)];       //当前的label
        UILabel *lastLabel = [_tagBackgroundView viewWithTag:(MORE_TAG_VIEW_TAG + i - 1)];     //前一个label
        layoutTagLabel.text = text;
        
        //动态约束
        [layoutTagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tagBackgroundView);
            make.height.mas_equalTo(23 * HOME_IPHONE6_HEIGHT);
            make.width.mas_equalTo(width);
            if (lastLabel) {
                make.left.equalTo(lastLabel.mas_right).offset(10 * HOME_IPHONE6_WIDTH);
            }else{
                make.left.equalTo(_tagBackgroundView);
            }
            if (array.count == (i + 1)) {//最后label
                make.right.equalTo(_tagBackgroundView);
                make.bottom.equalTo(_tagBackgroundView);
            }
        }];
    }
    
}



- (void)settingAutoLayout{
    
    [_tagBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 * HOME_IPHONE6_HEIGHT);
        make.centerX.equalTo(self.contentView);
        make.width.mas_lessThanOrEqualTo(Magic_screen_Width - 20 * HOME_IPHONE6_WIDTH);
    }];
    
    [_onLineStatisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagBackgroundView.mas_bottom).offset(25 * HOME_IPHONE6_HEIGHT);
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(32 * HOME_IPHONE6_HEIGHT);
    }];
    
    [_onLineBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_onLineStatisticsView);
        make.centerX.equalTo(_onLineStatisticsView);
    }];
    
    [_onLineIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_onLineBackgroundView);
        make.left.equalTo(_onLineBackgroundView);
    }];
    
    [_onLineCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_onLineIconLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
        make.centerY.equalTo(_onLineBackgroundView);
        make.right.equalTo(_onLineBackgroundView);
    }];

}

#pragma mark -更新数据
- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    _onLineCountLabel.text = [self checkGoodsShelvesCountWithShelvesCount:_productDetailModel.item.ID];
    NSString *byStages = [NSString stringWithFormat:@"%@", _productDetailModel.byStages];
    NSArray  *array = @[byStages, @"税率11.9%", @"5元优惠券可用"];
    [self updateMoreTagLabelWithArray:array];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//计算文字宽度
- (CGFloat)settingCollectionViewItemWidthBoundingWithText:(NSString *)text{
    //1,设置内容大小  其中高度一定要与item一致,宽度度尽量设置大值
    CGSize size = CGSizeMake(MAXFLOAT, 23 * HOME_IPHONE6_HEIGHT);
    //2,设置计算方式
    //3,设置字体大小属性   字体大小必须要与label设置的字体大小一致
    NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:10 * HOME_IPHONE6_HEIGHT]};
    CGRect frame = [text boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil];
    //4.添加间距
    return frame.size.width + 20 * HOME_IPHONE6_WIDTH;
}

//检查上架数量
- (NSString *)checkGoodsShelvesCountWithShelvesCount:(CGFloat)shelvesCount{
    
    if (shelvesCount < 10000) {
        return [NSString stringWithFormat:@"已被%.f位店主上架", shelvesCount];
    }
    
    return [NSString stringWithFormat:@"已被%.1f万位店主上架", (shelvesCount / 10000)];
    
}
@end
