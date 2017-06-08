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

#define OptionButton_Width 50

@implementation ProductBuyMenuView{
    UIView *_topLine;            //顶部线
    UIView *_operationView;      //操作视图
    UIButton *_buyButton;        //立即购买
    UIButton *_addCartButton;    //加入购物车
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
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    [self createTopLine];
    [self createOptionViewWithOptions:@[@{@"icon":@"\U0000e659", @"title":@"客服"},
                                        @{@"icon":@"", @"title":@""},
                                        @{@"icon":@"\U0000e643", @"title":@"购物车"}]];
    [self createOperationView];
    [self updateOptionsGoodsOnOffButton];
    
}


/**
 分割线
 */
- (void)createTopLine{
    
    _topLine = [UIView new];
    _topLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    [self addSubview:_topLine];
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
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
    //        button.backgroundColor = [UIColor redColor];
    button.tag = OptionButton_Tag + index;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(index * OptionButton_Width);
        make.width.mas_equalTo(OptionButton_Width);
    }];
    [button addTarget:self action:@selector(subButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *iconLabel = [UILabel new];
    iconLabel.tag = OptionButton_Icon_Tag + index;
    iconLabel.text = [data objectForKey:@"icon"];
    iconLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    iconLabel.textColor = [UIColor colorWithHexString:@"#605F65"];
    [button addSubview:iconLabel];
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button).offset(5);
    }];
    
    UILabel *textLabel = [UILabel new];
    textLabel.tag = OptionButton_Title_Tag + index;
    textLabel.text = [data objectForKey:@"title"];
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [UIColor colorWithHexString:@"#605F65"];
    [button addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.bottom.equalTo(button).offset(-5);
    }];
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.tag = OptionButton_Tag_Tag + index;
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont systemFontOfSize:8];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.backgroundColor = [UIColor flatRedColor];
    tagLabel.hidden = YES;
    tagLabel.layer.borderWidth = 1;
    tagLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    [button addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button).offset(3);
        make.right.equalTo(button).offset(-3);
        make.size.mas_equalTo(CGSizeMake(20, 15));
        tagLabel.layer.masksToBounds = YES;
        tagLabel.layer.cornerRadius = 15 / 2;
    }];

}

/**
 操作视图
 */
- (void)createOperationView{
    
    _operationView = [UIView new];
    //    _operationView.backgroundColor = [UIColor greenColor];
    [self addSubview:_operationView];
    [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(3 * OptionButton_Width);
        make.right.equalTo(self);
    }];
    
    
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.backgroundColor = [UIColor colorWithHexString:@"#FCBD33"];
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_operationView addSubview:_buyButton];
    [_buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.left.bottom.equalTo(_operationView);
    }];

    
    _addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addCartButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_operationView addSubview:_addCartButton];
    [_addCartButton addTarget:self action:@selector(addCartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.right.bottom.equalTo(_operationView);
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

- (void)addCartButtonAction:(id)sender{
    
    [self executeProductBuyMenuViewSelectedType:ProductBuyMenuTypeAdd];
    
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
    [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    if (currentStatus == ProductBuyMenuStatusNoInventory) {
        
        [_addCartButton setTitle:@"暂时无货" forState:UIControlStateNormal];
        _addCartButton.backgroundColor = [UIColor flatGrayColor];
        
    }else{
        
        [_addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addCartButton.backgroundColor = [UIColor colorWithHexString:@"#F03337"];
        
    }
    
    //样式
    if (currentStatus == ProductBuyMenuStatusNoAdd) {
        
        [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_operationView.mas_left);
        }];
        
        [_addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_operationView);
        }];
        
    }else{
        
        [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_operationView.mas_centerX);
        }];
        
        [_addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_operationView.mas_centerX);
        }];
        
    }
    
}

- (void)setIsOnByGoods:(BOOL)isOnByGoods{
    _isOnByGoods = isOnByGoods;
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
       textLabel.text = self.isOnByGoods ? @"已上架" : @"未上架";;
    }
    UILabel *iconLabel = [self viewWithTag:OptionButton_Icon_Tag + optionIndex];
    if (iconLabel) {
        iconLabel.text = self.isOnByGoods ? @"\U0000e60b" : @"\U0000e617";
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
