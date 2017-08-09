//
//  HomeMainPageTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "HomeMainPageTableViewCell.h"
#import "SJIconTextButton.h"
#import "SJUIKit.h"
#import "MBSwitch.h"

#define FONT_PingFangSC_Light(s)   [UIFont fontWithName:@"FZY1JW--GB1-0" size:(s) * HOME_IPHONE6_WIDTH]
#define FONT_PingFangSC_Regular(s) [UIFont systemFontOfSize:(s) * HOME_IPHONE6_WIDTH]

#define NEW_PINK_COLOR [UIColor colorWithRed:0.98 green:0.44 blue:0.63 alpha:1.00]
#define NEW_GRAY_COLOR [UIColor colorWithRed:0.52 green:0.51 blue:0.51 alpha:1.00]
#define NEW_GRAY_COLOR2 [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00]
#define NEW_GRAY_COLOR3 [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.00]
#define NEW_BLACK_COLOR1 [UIColor colorWithRed:0.11 green:0.11 blue:0.17 alpha:1.00]
#define NEW_BLACK_COLOR2 [UIColor colorWithRed:0.14 green:0.15 blue:0.23 alpha:1.00]
#define NEW_BLACK_COLOR3 [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:1.00]

@implementation HomeMainPageTableViewCell{
    UIImageView *_mainGoodsImageView;       //商品图片(压缩/webp)
    UILabel *_titleNode;                    //标题
    UILabel *_goodsTimeTagNode;             //标签
    UILabel *_limitNode;                    //限量
    UILabel *_specialPriceNode;             //特卖价格
    UILabel *_normalPriceNode;              //平时价
    SJIconTextButton *_shareButtonNode;     //分享
    UIImageView *_bottomToolBarNode;        //底部工具条
    UILabel *_onLineCountNode;              //上架数目
    UILabel *_earningNode;                  //收益
    UILabel *_lineStatusNode;               //上下架状态
    MBSwitch *_lineSwitchButton;            //上下架开关
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    [self addBottomToolBarNode];
    [self addMainGoodsImageNode];
    [self addMainGoodsTagNode];
    [self addMainGoodsTitleNode];
    [self addMainOnLineCountNode];
    [self addMainPriceNode];
    
    [self addShareButtonNode];
    [self addEarningNode];
    [self addLineStatusNode];
}

#pragma mark -普通商品
//工具条
- (void)addBottomToolBarNode{
    
    _bottomToolBarNode = [SJUIKit imageViewAddView:self.contentView ClipsToBounds:NO ContentMode:2];
    [_bottomToolBarNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(Screen_width - 20, 38));
    }];
    
}

//商品图片
- (void)addMainGoodsImageNode{
    
    _mainGoodsImageView = [SJUIKit imageViewAddView:self.contentView ClipsToBounds:YES ContentMode:1];
    [_mainGoodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(_bottomToolBarNode.mas_top).offset(-10);
    }];
    [self addMainGoodsEmptyImageView];
    
}

//抢光了标签
- (void)addMainGoodsEmptyImageView{
    
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor colorWithWhite:1.00 alpha:0.80];
    [_mainGoodsImageView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainGoodsImageView);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GL_Sake"]];
    [backgroundView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(55);
        make.center.equalTo(backgroundView);
    }];
    
}



//标签、限量
- (void)addMainGoodsTagNode{
    
    _goodsTimeTagNode = [SJUIKit labelAddView:self.contentView TextColor:[UIColor whiteColor] Font:FONT_PingFangSC_Light(12)];
    _goodsTimeTagNode.textAlignment = NSTextAlignmentCenter;
    _goodsTimeTagNode.layer.backgroundColor = NEW_PINK_COLOR.CGColor;
    _goodsTimeTagNode.layer.cornerRadius = (22 / 2);
    [_goodsTimeTagNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 22));
        make.top.equalTo(_mainGoodsImageView);
        make.left.equalTo(_mainGoodsImageView.mas_right).offset(10);
    }];
    
    _limitNode = [SJUIKit labelAddView:self.contentView TextColor:NEW_BLACK_COLOR1 Font:FONT_PingFangSC_Light(12)];
    [_limitNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_goodsTimeTagNode);
        make.left.equalTo(_goodsTimeTagNode.mas_right).offset(25);
    }];
}


//标题
- (void)addMainGoodsTitleNode{
    _titleNode = [SJUIKit labelAddView:self.contentView TextColor:NEW_BLACK_COLOR2 Font:[UIFont systemFontOfSize:15]];
    _titleNode.numberOfLines = 2;
    [_titleNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsTimeTagNode.mas_bottom).offset(5);
        make.left.equalTo(_mainGoodsImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
}


//上架数目
- (void)addMainOnLineCountNode{
    
    _onLineCountNode = [SJUIKit labelAddView:self.contentView TextColor:NEW_GRAY_COLOR2 Font:FONT_PingFangSC_Light(12.5)];
    [_onLineCountNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_mainGoodsImageView);
        make.left.equalTo(_mainGoodsImageView.mas_right).offset(10);
    }];
    
}

//特卖价、平时价
- (void)addMainPriceNode{
    
    _specialPriceNode = [SJUIKit labelAddView:self.contentView TextColor:NEW_BLACK_COLOR3 Font:FONT_PingFangSC_Light(12.5)];
    [_specialPriceNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_onLineCountNode.mas_top).offset(-10);
        make.left.equalTo(_mainGoodsImageView.mas_right).offset(10);
    }];
    
    _normalPriceNode = [SJUIKit labelAddView:self.contentView TextColor:NEW_GRAY_COLOR3 Font:FONT_PingFangSC_Light(12.5)];
    [_normalPriceNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_onLineCountNode.mas_top).offset(-10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
}


#pragma mark - 底部工具栏
//分享
- (void)addShareButtonNode{
    
    _shareButtonNode = [[SJIconTextButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    _shareButtonNode.titleLabel.text = @"分享";
    _shareButtonNode.iconLabel.text = @"\U0000e6f3";
    _shareButtonNode.titleLabel.textColor = NEW_GRAY_COLOR;
    _shareButtonNode.iconLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    _shareButtonNode.buttonStyle = IconTextButtonStyleRight;
    _shareButtonNode.iconFontSize = 12;
    _shareButtonNode.titleLabel.font = [UIFont systemFontOfSize:12];
    [_bottomToolBarNode addSubview:_shareButtonNode];
    [_shareButtonNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomToolBarNode).offset(-10);
        make.centerY.equalTo(_bottomToolBarNode);
        make.size.mas_equalTo(_shareButtonNode.frame.size);
    }];
    
}

//收益
- (void)addEarningNode{
    _earningNode = [SJUIKit labelAddView:_bottomToolBarNode TextColor:NEW_GRAY_COLOR Font:FONT_PingFangSC_Light(12.5)];
    [_earningNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_bottomToolBarNode);
    }];
}


//上下架状态
- (void)addLineStatusNode{
    
    _lineStatusNode = [SJUIKit labelAddView:_bottomToolBarNode TextColor:NEW_GRAY_COLOR Font:[UIFont systemFontOfSize:10]];
    [_lineStatusNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomToolBarNode).offset(20);
        make.centerY.equalTo(_bottomToolBarNode);
    }];
    
    _lineSwitchButton  = [[MBSwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 24)];
    _lineSwitchButton.thumbTintColor = [UIColor whiteColor];                                         //按钮颜色
    [_lineSwitchButton setTintColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00]];    //边框颜色
    [_lineSwitchButton setOnTintColor:NEW_PINK_COLOR];                                               //开启颜色
    [_lineSwitchButton setOffTintColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00]]; //关闭颜色
    //[switchButton addTarget:self action:@selector(upDownChangeSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [_bottomToolBarNode addSubview:_lineSwitchButton];
    [_lineSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lineStatusNode);
        make.left.equalTo(_lineStatusNode.mas_right).offset(5);
        make.size.mas_equalTo(_lineSwitchButton.frame.size);
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

- (void)setSkuModel:(Skus *)skuModel{
    if (_skuModel != skuModel) {
        _skuModel = skuModel;
        [self loadingDataWithSkuModel:skuModel];
    }
}


/**
 加载数据
 */
- (void)loadingDataWithSkuModel:(Skus *)skuModel{
    _mainGoodsImageView.image = [UIImage imageNamed:@"productDetailLogo@2x.png"];
    _goodsTimeTagNode.text = [self checkGoodsSaleNowStatusWithSkusModel:skuModel];
    [self updateGoodsSaleNowStatusBackgroundColorWithTagType:skuModel.tagType];
    _limitNode.text = [self checkGoodsLimitInventoryWithSkusModel:skuModel];
    _titleNode.text = [NSString stringWithFormat:@"[%@]%@", skuModel.brandName, skuModel.skuName];
    _onLineCountNode.text = [self checkGoodsShelvesCountWithShelvesCount:skuModel.shelvesCount];
    _specialPriceNode.text = [NSString stringWithFormat:@"特卖价: ¥%.2f", skuModel.price];
    _normalPriceNode.text = [NSString stringWithFormat:@"平时:¥%.2f", skuModel.originalPrice];
    _earningNode.text = [NSString stringWithFormat:@"收益:¥%.2f", skuModel.commission];
    [self checkGoodsStatusWithSelected:skuModel.isSelect];
    [self checkGoodsInventoryIsEmptyWithInventory:skuModel.inventory];
}

#pragma mark -业务相关
//标签处理
- (NSString *)checkGoodsSaleNowStatusWithSkusModel:(Skus *)skusModel{
    
    if (skusModel.tagType == -1) {
        return skusModel.tag;
    }
    return [NSString stringWithFormat:@"%@ %@", skusModel.time, skusModel.tag];
    
}

//标签背景
- (void)updateGoodsSaleNowStatusBackgroundColorWithTagType:(NSInteger)tagType{
    
    switch (tagType) {
        case -1:    //已结束
            //_goodsTimeTagNode.backgroundColor = COLOR_GRAY_BACKGROUND;
            break;
            
        case 1:     //未开枪
            //_goodsTimeTagNode.backgroundColor = COLOR_RED_QIAN_TEXT;
            break;
            
        case 2:     //抢购中
            _goodsTimeTagNode.backgroundColor = NEW_PINK_COLOR;
            break;
            
        default:    //默认
            _goodsTimeTagNode.backgroundColor = NEW_PINK_COLOR;
            break;
    }
    
}

//检查限量
- (NSString *)checkGoodsLimitInventoryWithSkusModel:(Skus *)skusModel{
    
    if (skusModel.limitInventory > 0) {
        return [NSString stringWithFormat:@"限量%ld", skusModel.limitInventory];
    }
    return @"";
}

//检查库存是否为0
- (void)checkGoodsInventoryIsEmptyWithInventory:(NSInteger)inventory{
    
    if (inventory <= 0 ) {
        [self addMainGoodsEmptyImageView];
    }
    
}

//检查上架数量
- (NSString *)checkGoodsShelvesCountWithShelvesCount:(CGFloat)shelvesCount{
    
    if (shelvesCount < 10000) {
        return [NSString stringWithFormat:@"已被%.f位店主上架", shelvesCount];
    }
    return [NSString stringWithFormat:@"已被%.1f万位店主上架", (shelvesCount / 10000)];
    
}

//检查商品上架状态
- (void)checkGoodsStatusWithSelected:(BOOL)selected{
    
    if (selected) {
        [_lineSwitchButton setOn:YES];
        _lineStatusNode.text = @"已上架";
        _lineStatusNode.textColor = NEW_GRAY_COLOR;
        
    }else{
        [_lineSwitchButton setOn:NO];
        _lineStatusNode.text = @"未上架";
        _lineStatusNode.textColor = NEW_GRAY_COLOR;
    }
    
}


#pragma mark -点击事件相关
//上下架切换
- (void)upDownChangeSwitchAction:(UISwitch *)sender{
    
    [self checkGoodsStatusWithSelected:_lineSwitchButton.on];
    if (sender.isOn) {
        
        //////////上架操作//////////
        //NSLog(@"首页上架%@", _skuModel.skuId);
        _skuModel.isSelect = YES;
        //[self.delegate homeTableViewNodeToOnlineEventWithSkuId:_skuModel.skuId CellIndexPath:_cellIndexPath];
        
    }else{
        
        //////////下架操作//////////
        //NSLog(@"首页下架%@", _skuModel.skuId);
        _skuModel.isSelect = NO;
        //[self.delegate homeTableViewNodeToOfflineEventWithSkuId:_skuModel.skuId CellIndexPath:_cellIndexPath];
        
    }
    
}

//分享
- (void)homeGoodsShareAction:(id)sender{
    
    //NSLog(@"首页分享 %@", _skuModel.skuId);
    //[self.delegate homeTableViewNodeShareEventWithSkuId:_skuModel.skuId CellIndexPath:_cellIndexPath];
    
}


@end
