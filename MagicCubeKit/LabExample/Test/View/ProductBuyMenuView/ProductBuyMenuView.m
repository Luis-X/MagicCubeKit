//
//  ProductBuyMenuView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductBuyMenuView.h"

#define OptionButton_Tag        3000
#define OptionButton_Icon_Tag   3100
#define OptionButton_Title_Tag  3200
#define OptionButton_Tag_Tag    3300

#define OptionButton_Width 50 * HOME_IPHONE6_WIDTH

@implementation ProductBuyMenuView{
    UIView *_operationView;      //操作视图
    UIButton *_buyButton;        //立即购买
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    UIImageView *bgImageView = [UIImageView new];
    [bgImageView setImage:[UIImage imageNamed:@"productDetailMenu@2x.png"]];
    //bgImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(95 * HOME_IPHONE6_HEIGHT);
    }];
    
    [self createOptionViewWithOptions:@[@{@"icon":@"\U0000e6ee", @"title":@"客服"},
                                        @{@"icon":@"", @"title":@""},
                                        @{@"icon":@"\U0000e6e3", @"title":@"购物袋"}]];
    [self createOperationView];
    [self updateOptionsGoodsOnOffButton];
    
}


/**
 选项视图
 */
- (void)createOptionViewWithOptions:(NSArray *)options{
    
    for (NSInteger i = 0; i < options.count; i++) {
        NSDictionary *dic = [options objectAtIndex:i];
        [self createOptionButtonWithIndex:i data:dic];
    }

}

/**
 选项按钮
 */
- (void)createOptionButtonWithIndex:(NSInteger)index data:(NSDictionary *)data{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor orangeColor];
    button.tag = OptionButton_Tag + index;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8 * HOME_IPHONE6_HEIGHT);
        make.bottom.equalTo(self).offset(-8 * HOME_IPHONE6_HEIGHT);
        make.left.equalTo(self).offset(index * OptionButton_Width + 10 * HOME_IPHONE6_WIDTH);
        make.width.mas_equalTo(OptionButton_Width);
    }];
    [button addTarget:self action:@selector(subButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *iconLabel = [UILabel new];
    iconLabel.tag = OptionButton_Icon_Tag + index;
    iconLabel.text = [data objectForKey:@"icon"];
    iconLabel.font = [UIFont fontWithName:@"iconfont" size:18 * HOME_IPHONE6_WIDTH];
    iconLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    [button addSubview:iconLabel];
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button);
    }];
    
    UILabel *textLabel = [UILabel new];
    textLabel.tag = OptionButton_Title_Tag + index;
    textLabel.text = [data objectForKey:@"title"];
    textLabel.font = [UIFont systemFontOfSize:10 * HOME_IPHONE6_WIDTH];
    textLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    [button addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.bottom.equalTo(button);
    }];
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.tag = OptionButton_Tag_Tag + index;
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont systemFontOfSize:8 * HOME_IPHONE6_WIDTH];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    tagLabel.layer.masksToBounds = YES;
    tagLabel.layer.cornerRadius = 5 * HOME_IPHONE6_HEIGHT;
    tagLabel.hidden = YES;
    [button addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button).offset(-3 * HOME_IPHONE6_HEIGHT);
        make.right.equalTo(button).offset(-8 * HOME_IPHONE6_WIDTH);
        make.size.mas_equalTo(CGSizeMake(17 * HOME_IPHONE6_WIDTH, 10 * HOME_IPHONE6_HEIGHT));
    }];

}

/**
 操作视图
 */
- (void)createOperationView{
    
    _operationView = [UIView new];
    //_operationView.backgroundColor = [UIColor redColor];
    [self addSubview:_operationView];
    [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(192 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(self).offset(-5 * HOME_IPHONE6_WIDTH);
    }];
    
    
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //_buyButton.backgroundColor = [UIColor orangeColor];
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_WIDTH];
    [_operationView addSubview:_buyButton];
    [_buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_operationView);
    }];
    
    [self updateOperationStatusLayout:ProductBuyMenuStatusNormal];
    
}

#pragma mark - Action
- (void)subButtonHandler:(UIButton *)button{
    
    NSInteger index = button.tag - OptionButton_Tag;
    
    if (0 == index) {
        [self executeProductBuyMenuViewSelectedType:ProductBuyMenuTypeService];
    }
    if (1 == index) {
        [self executeProductBuyMenuViewSelectedType:ProductBuyMenuTypeOnOff];
    }
    if (2 == index) {
        [self executeProductBuyMenuViewSelectedType:ProductBuyMenuTypeCart];
    }
    
}

- (void)buyButtonAction:(id)sender{
    
    [self executeProductBuyMenuViewSelectedType:ProductBuyMenuTypeBuy];
    
}


/**
 执行代理方法
 */
- (void)executeProductBuyMenuViewSelectedType:(ProductBuyMenuType)type{
    
    if ([self.delegate respondsToSelector:@selector(productBuyMenuViewSelectedType:)]) {
        [self.delegate productBuyMenuViewSelectedType:type];
    }
    
}

#pragma mark - Update
- (void)setCurrentStatus:(ProductBuyMenuStatus)currentStatus{
    [self updateOperationStatusLayout:currentStatus];
}

/**
 更新状态
 */
- (void)updateOperationStatusLayout:(ProductBuyMenuStatus)currentStatus{
    
    //文案,背景
    if (currentStatus == ProductBuyMenuStatusNoInventory) {
        [_buyButton setTitle:@"求补货" forState:UIControlStateNormal];
        _buyButton.enabled = NO;
    }else{
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyButton.enabled = YES;
    }
    
    //样式
    if (currentStatus == ProductBuyMenuStatusNoInventory) {
        [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(_operationView);
        }];
    }else{
        [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100 * HOME_IPHONE6_WIDTH);
        }];
    }
    
}

- (void)setIsSelectByGoods:(BOOL)isSelectByGoods{
    _isSelectByGoods = isSelectByGoods;
    [self updateOptionsGoodsOnOffButton];
}

- (void)setCartAmount:(NSInteger)cartAmount{
    _cartAmount = cartAmount;
    [self updateOptionsShopCartTag];
}


/**
 更新上下架状态
 */
- (void)updateOptionsGoodsOnOffButton{
    
    NSInteger optionIndex = 1;
    UILabel *textLabel = [self viewWithTag:OptionButton_Title_Tag + optionIndex];
    if (textLabel) {
       textLabel.text = self.isSelectByGoods ? @"已上架" : @"未上架";;
    }
    UILabel *iconLabel = [self viewWithTag:OptionButton_Icon_Tag + optionIndex];
    if (iconLabel) {
        iconLabel.text = self.isSelectByGoods ? @"\U0000e6f1" : @"\U0000e6ea";
    }
    
}

/**
 更新购物车总数
 */
- (void)updateOptionsShopCartTag{
    
    NSInteger optionIndex = 2;
    UILabel *tagLabel = [self viewWithTag:OptionButton_Tag_Tag + optionIndex];
    if (_cartAmount <= 99) {
        tagLabel.text = [NSString stringWithFormat:@"%ld", _cartAmount];
    }else{
        tagLabel.text = @"99+";
    }
    tagLabel.hidden = (_cartAmount > 0) ? NO : YES;
    
}
@end
