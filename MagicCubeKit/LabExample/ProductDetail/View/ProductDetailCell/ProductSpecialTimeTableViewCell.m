//
//  ProductSpecialTimeTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/20.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSpecialTimeTableViewCell.h"

#define DATE_FORMATTER_ONE @"MM月dd日"
#define DATE_FORMATTER_TWO @"MM月dd日HH:mm"
#define DATE_VIEW_SIZE CGSizeMake(12 * HOME_IPHONE6_WIDTH, 18 * HOME_IPHONE6_HEIGHT)
#define SELF_TIME_VIEW_SIZE 50 * HOME_IPHONE6_HEIGHT

@interface ProductSpecialTimeTableViewCell ()
@property (nonatomic, assign)ProductSpecialTimeStyle style;
@end

@implementation ProductSpecialTimeTableViewCell{
    
    UIView *_timerStyleView;          //倒计时样式视图
    UILabel *_timer_messageLabel;          //信息
    UILabel *_timer_hourLabel;             //十位（时）
    UILabel *_timer_subhourLabel;          //个位（时）
    UILabel *_timer_unitHourLabel;         //单位（时）
    UILabel *_timer_minuteLabel;           //十位（分）
    UILabel *_timer_subminuteLabel;        //个位（分）
    UILabel *_timer_unitMinuteLabel;       //单位（分）
    UILabel *_timer_secondLabel;           //十位（秒）
    UILabel *_timer_subsecondLabel;        //个位（秒）
    UILabel *_timer_unitSecondLabel;       //单位（秒）
    UILabel *_timer_millisecondLabel;      //（毫秒）
    UIView *_dayStyleView;           //日期样式视图
    UILabel *_day_messageLabel;             //信息
    UILabel *_day_hourLabel;                //十位（时）
    UILabel *_day_subhourLabel;             //个位（时）
    UILabel *_day_unitHourLabel;            //单位（时）
    UILabel *_day_minuteLabel;              //十位（分）
    UILabel *_day_subminuteLabel;           //个位（分）
    dispatch_source_t _mainTimerSource;
    DTTimePeriod *_timePeriod;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self registerNSNotificationCenter];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initialData];
        [self createSubViews];
    }
    return self;
}

- (void)initialData{
    _timePeriod = [DTTimePeriod new];
}

- (void)createSubViews{
    [self createTimerStyleContentSubViews];
    [self createDayStyleContentSubViews];
}


/**
 小时样式
 */
- (void)createTimerStyleContentSubViews{
    
    _timerStyleView = [UIView new];
    _timerStyleView.hidden = YES;
    [self.contentView addSubview:_timerStyleView];
    
    _timer_messageLabel = [UILabel new];
    _timer_messageLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    _timer_messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    [_timerStyleView addSubview:_timer_messageLabel];
    
    _timer_hourLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_subhourLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_minuteLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_subminuteLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_secondLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_subsecondLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_millisecondLabel = [self createBatchTimeLabelAddView:_timerStyleView];
    _timer_millisecondLabel.layer.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00].CGColor;
    _timer_unitHourLabel = [self createBatchUnitLabelAddView:_timerStyleView];
    _timer_unitMinuteLabel = [self createBatchUnitLabelAddView:_timerStyleView];
    _timer_unitSecondLabel = [self createBatchUnitLabelAddView:_timerStyleView];

    [self loadingAutoLayoutHourStyle];
}

/**
 按小时样式
 */
- (void)loadingAutoLayoutHourStyle{
    
    [_timerStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [_timer_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timerStyleView);
        make.centerY.equalTo(_timerStyleView);
    }];
    
    [_timer_hourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_messageLabel.mas_right).offset(10 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_subhourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_hourLabel.mas_right).offset(2 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_unitHourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_subhourLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_minuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_unitHourLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_subminuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_minuteLabel.mas_right).offset(2 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_unitMinuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_subminuteLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_unitMinuteLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_subsecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_secondLabel.mas_right).offset(2 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_unitSecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_subsecondLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_timer_millisecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_timerStyleView);
        make.left.equalTo(_timer_unitSecondLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(_timerStyleView);
    }];
    
}

/**
 日期样式
 */
- (void)createDayStyleContentSubViews{
    
    _dayStyleView = [UIView new];
    _dayStyleView.hidden = YES;
    [self.contentView addSubview:_dayStyleView];
    
    _day_messageLabel = [UILabel new];
    _day_messageLabel.font = [UIFont systemFontOfSize:14 * HOME_IPHONE6_HEIGHT];
    _day_messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    [_dayStyleView addSubview:_day_messageLabel];
    
    _day_hourLabel = [self createBatchTimeLabelAddView:_dayStyleView];
    _day_subhourLabel = [self createBatchTimeLabelAddView:_dayStyleView];
    _day_minuteLabel = [self createBatchTimeLabelAddView:_dayStyleView];
    _day_subminuteLabel = [self createBatchTimeLabelAddView:_dayStyleView];
    _day_unitHourLabel = [self createBatchUnitLabelAddView:_dayStyleView];
    
    [self loadingAutoLayoutDayStyle];
}

/**
 按天数样式
 */
- (void)loadingAutoLayoutDayStyle{
    
    [_dayStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [_day_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dayStyleView);
        make.centerY.equalTo(_dayStyleView);
    }];
    
    [_day_hourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_dayStyleView);
        make.left.equalTo(_day_messageLabel.mas_right).offset(10 * HOME_IPHONE6_WIDTH);
    }];
    
    [_day_subhourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_dayStyleView);
        make.left.equalTo(_day_hourLabel.mas_right).offset(2 * HOME_IPHONE6_WIDTH);
    }];
    
    [_day_unitHourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dayStyleView);
        make.left.equalTo(_day_subhourLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_day_minuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_dayStyleView);
        make.left.equalTo(_day_unitHourLabel.mas_right).offset(5 * HOME_IPHONE6_WIDTH);
    }];
    
    [_day_subminuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_dayStyleView);
        make.left.equalTo(_day_minuteLabel.mas_right).offset(2 * HOME_IPHONE6_WIDTH);
        make.right.equalTo(_dayStyleView);
    }];
    
    
}



/**
 批量创建TimeLabel
 */
- (UILabel *)createBatchTimeLabelAddView:(UIView *)addView{
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.layer.cornerRadius = 5 * HOME_IPHONE6_HEIGHT;
    timeLabel.layer.backgroundColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00].CGColor;
    [addView addSubview:timeLabel];
    return timeLabel;
    
}


/**
 批量创建UnitLabel
 */
- (UILabel *)createBatchUnitLabelAddView:(UIView *)addView{
    
    UILabel *unitLabel = [UILabel new];
    unitLabel.text = @":";
    unitLabel.font = [UIFont systemFontOfSize:12 * HOME_IPHONE6_HEIGHT];
    unitLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    [addView addSubview:unitLabel];
    return unitLabel;
    
}

/**
 更新样式
 */
- (void)updateProductSpecialTimeStyle:(ProductSpecialTimeStyle)style{
    
    if (_style != style) {
        _style = style;
        if (ProductSpecialTimeStyleNone == style) {
            _timerStyleView.hidden = YES;
            _dayStyleView.hidden = YES;
        }
        if (ProductSpecialTimeStyleDay == style) {
            _timerStyleView.hidden = YES;
            _dayStyleView.hidden = NO;
        }
        if (ProductSpecialTimeStyleHour == style) {
            _timerStyleView.hidden = NO;
            _dayStyleView.hidden = YES;
        }
    }
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -更新数据
- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    
}

/**
 更新倒计时
 
 @param startTimeValue 开始时间戳
 @param endTimeValue 结束时间戳
 */
- (void)updateAllTimeWithStartTimeValue:(NSTimeInterval)startTimeValue endTimeValue:(NSTimeInterval)endTimeValue{
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startTimeValue / 1000];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTimeValue / 1000];
    NSDate *nowDate = [NSDate date];
    //NSLog(@"开始：%@", [self getDateStringWithTimeValue:startTimeValue formatter:DATE_FORMATTER_TWO]);
    //NSLog(@"结束：%@", [self getDateStringWithTimeValue:endTimeValue formatter:DATE_FORMATTER_TWO]);
    
    _timePeriod.StartDate = nowDate;
    _timePeriod.EndDate = endDate;
    BOOL isMoment = _timePeriod.isMoment;            //是否开始时间和结束时间相同
    
    double  durationInDays    = [_timePeriod durationInDays];     //相差日
    double  durationInHours   = [_timePeriod durationInHours];    //相差时
    double  durationInMinutes = [_timePeriod durationInMinutes];  //相差分
    double  durationInSeconds = [_timePeriod durationInSeconds];  //相差秒
    double  durationInMilliseconds = durationInSeconds * 10;
    
    NSInteger days = durationInDays;
    NSInteger includeHours = (days * 24);                                   //重复时
    NSInteger hours = durationInHours - includeHours;
    NSInteger includeMinutes = (includeHours + hours) * 60;                 //重复分
    NSInteger minutes = durationInMinutes - includeMinutes;
    NSInteger includeSeconds = (includeMinutes + minutes) * 60;             //重复秒
    NSInteger seconds = durationInSeconds - includeSeconds;
    NSInteger includeMilliseconds = (includeSeconds + seconds) * 10;        //重复毫秒
    NSInteger milliseconds = durationInMilliseconds - includeMilliseconds;
    
    NSLog(@"⏳%ld日%ld时%ld分%ld秒%ld", days, hours, minutes, seconds, milliseconds);
    
    //特卖（未开始）
    if ([nowDate isEarlierThan:startDate]) {
        [self updateProductSpecialTimeStyle:ProductSpecialTimeStyleDay];
        NSString *startDateString = [self getDateStringWithTimeValue:startTimeValue formatter:DATE_FORMATTER_ONE];
        _day_messageLabel.text = [NSString stringWithFormat:@"特卖时间 %@", startDateString];
        _day_hourLabel.text = [NSString stringWithFormat:@"%ld", startDate.hour / 10];
        _day_subhourLabel.text = [NSString stringWithFormat:@"%ld", startDate.hour % 10];;
        _day_minuteLabel.text = [NSString stringWithFormat:@"%ld", startDate.minute / 10];;
        _day_subminuteLabel.text = [NSString stringWithFormat:@"%ld", startDate.minute % 10];
    }
    
    //特卖（进行中）
    if ([nowDate isLaterThanOrEqualTo:startDate] && [nowDate isEarlierThanOrEqualTo:endDate]) {
        [self updateProductSpecialTimeStyle:ProductSpecialTimeStyleHour];
        _timer_messageLabel.text = @"距离结束仅剩";
        NSInteger amountHours = (hours + includeHours);
        if (amountHours > 99) {
            amountHours = 99;
        }
        _timer_hourLabel.text = [NSString stringWithFormat:@"%ld", (amountHours / 10)];
        _timer_subhourLabel.text = [NSString stringWithFormat:@"%ld", (amountHours % 10)];
        _timer_minuteLabel.text = [NSString stringWithFormat:@"%ld", (minutes / 10)];
        _timer_subminuteLabel.text = [NSString stringWithFormat:@"%ld", (minutes % 10)];
        _timer_secondLabel.text = [NSString stringWithFormat:@"%ld", (seconds / 10)];
        _timer_subsecondLabel.text = [NSString stringWithFormat:@"%ld", (seconds % 10)];
        _timer_millisecondLabel.text = [NSString stringWithFormat:@"%ld", milliseconds];
    }
    //特卖（已结束）
    if ([nowDate isLaterThan:endDate]) {
        [self updateProductSpecialTimeStyle:ProductSpecialTimeStyleNone];
         [self executeProductSpecialTimeTableViewCellCurrentTimerStatus:ProductSpecialTimeStatusSaleEnd];
    }
    
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

#pragma mark - 倒计时相关
- (void)dealloc {
    [self removeNSNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NOTIFICATION_TIME_CELL
                                               object:nil];
}

- (void)removeNSNotificationCenter{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TIME_CELL object:nil];
}

- (void)notificationCenterEvent:(id)sender{
    
    if (self.m_isDisplayed) {
        [self updateAllTimeWithStartTimeValue:_productDetailModel.skuCommission.startTime endTimeValue:_productDetailModel.skuCommission.endTime];
    }
    
}

/**
 执行代理方法
 */
- (void)executeProductSpecialTimeTableViewCellCurrentTimerStatus:(ProductSpecialTimeStatus)status{
    
    if ([self.delegate respondsToSelector:@selector(productSpecialTimeTableViewCellCurrentTimerStatus:)]) {
        [self.delegate productSpecialTimeTableViewCellCurrentTimerStatus:status];
    }
    
}
@end
