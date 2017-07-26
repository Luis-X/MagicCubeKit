//
//  BaseTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self baseBuildDefaultConfig];
        [self baseBuildSubViews];
    }
    return self;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 * 默认配置
 */
- (void)baseBuildDefaultConfig{
    
}

/*
 * 构建视图
 */
- (void)baseBuildSubViews{
    
}

/*
 * 加载数据
 *
 * @param data          数据源     需要判断id类型
 * @param indexPath     数据编号
 *
 */
- (void)baseLoadData:(id)data indexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark - 功能
/**
 * 选中颜色
 * @param backgroundColor   背景颜色
 */
- (void)baseSelectedBackgroudColor:(UIColor *)backgroundColor{
    
    UIView *view = [UIView new];
    view.backgroundColor = backgroundColor;
    [self setSelectedBackgroundView:view];
    
}
@end
