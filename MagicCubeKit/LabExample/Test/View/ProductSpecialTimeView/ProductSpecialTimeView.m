//
//  ProductSpecialTimeView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSpecialTimeView.h"

#define DATE_FORMATTER_ONE @"MM月dd日"
#define DATE_FORMATTER_TWO @"MM月dd日HH:mm"

#define DATE_VIEW_SIZE CGSizeMake(12, 18)
#define SELF_TIME_VIEW_SIZE 50

typedef enum : NSUInteger {
    ProductSpecialTimeStyleNone,        //清空
    ProductSpecialTimeStyleDay,         //按天数
    ProductSpecialTimeStyleHour,        //按小时
} ProductSpecialTimeStyle;

@implementation ProductSpecialTimeView{
    UIView *_cellBackgroundView;     //背景
    UILabel *_messageLabel;          //信息
    UILabel *_hourLabel;             //十位（时）
    UILabel *_subhourLabel;          //个位（时）
    UILabel *_unitHourLabel;         //单位（时）
    UILabel *_minuteLabel;           //十位（分）
    UILabel *_subminuteLabel;        //个位（分）
    UILabel *_unitMinuteLabel;       //单位（分）
    UILabel *_secondLabel;           //十位（秒）
    UILabel *_subsecondLabel;        //个位（秒）
    UILabel *_unitSecondLabel;       //单位（秒）
    UILabel *_millisecondLabel;      //（毫秒）
    dispatch_source_t _mainTimerSource;
    ProductSpecialTimeStyle timeStyle;
    DTTimePeriod *_timePeriod;
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
        [self initialData];
        [self createSubViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)initialData{
    timeStyle = ProductSpecialTimeStyleNone;
    _timePeriod = [DTTimePeriod new];
}

- (void)createSubViews{
    
    _cellBackgroundView = [UIView new];
  //_cellBackgroundView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_cellBackgroundView];
    
    _messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    _messageLabel.adjustsFontSizeToFitWidth = YES;
    [_cellBackgroundView addSubview:_messageLabel];
    
    _hourLabel = [self createBatchTimeLabel];
    _subhourLabel = [self createBatchTimeLabel];
    _minuteLabel = [self createBatchTimeLabel];
    _subminuteLabel = [self createBatchTimeLabel];
    _secondLabel = [self createBatchTimeLabel];
    _subsecondLabel = [self createBatchTimeLabel];
    _millisecondLabel = [self createBatchTimeLabel];
    _millisecondLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    
    _unitHourLabel = [self createBatchUnitLabel];
    _unitMinuteLabel = [self createBatchUnitLabel];
    _unitSecondLabel = [self createBatchUnitLabel];
}


/**
 批量创建TimeLabel
 */
- (UILabel *)createBatchTimeLabel{
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.backgroundColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 5;
    [_cellBackgroundView addSubview:timeLabel];
    return timeLabel;
    
}


/**
 批量创建UnitLabel
 */
- (UILabel *)createBatchUnitLabel{
    
    UILabel *unitLabel = [UILabel new];
    unitLabel.textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.00];
    [_cellBackgroundView addSubview:unitLabel];
    return unitLabel;
    
}

- (void)settingAutoLayout{
    
    [_cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cellBackgroundView);
        make.centerY.equalTo(_cellBackgroundView);
    }];
    
    if (ProductSpecialTimeStyleNone == timeStyle) {
        [self loadingAutoLayoutNoneStyle];
    }
    if (ProductSpecialTimeStyleDay == timeStyle) {
        [self loadingAutoLayoutDayStyle];
    }
    if (ProductSpecialTimeStyleHour == timeStyle) {
        [self loadingAutoLayoutHourStyle];
    }
    
}

/**
 清空样式
 */
- (void)loadingAutoLayoutNoneStyle{
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
    }];
    
    [_hourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_subhourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_unitHourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_minuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_subminuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_unitMinuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_subsecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_unitSecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_millisecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
}

/**
 按天数样式
 */
- (void)loadingAutoLayoutDayStyle{
    
    [self loadingAutoLayoutNoneStyle];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SELF_TIME_VIEW_SIZE);
    }];
    
    [_hourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_messageLabel.mas_right).offset(10);
    }];
    
    [_subhourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_hourLabel.mas_right).offset(2);
    }];
    
    [_unitHourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_subhourLabel.mas_right).offset(5);
    }];
    
    [_minuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_unitHourLabel.mas_right).offset(5);
    }];
    
    [_subminuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_minuteLabel.mas_right).offset(2);
        make.right.equalTo(_cellBackgroundView);
    }];

    
}


/**
 按小时样式
 */
- (void)loadingAutoLayoutHourStyle{
    
    [self loadingAutoLayoutNoneStyle];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SELF_TIME_VIEW_SIZE);
    }];
    
    [_hourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_messageLabel.mas_right).offset(10);
    }];
    
    [_subhourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_hourLabel.mas_right).offset(2);
    }];
    
    [_unitHourLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_subhourLabel.mas_right).offset(5);
    }];
    
    [_minuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_unitHourLabel.mas_right).offset(5);
    }];
    
    [_subminuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_minuteLabel.mas_right).offset(2);
    }];
    
    [_unitMinuteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_subminuteLabel.mas_right).offset(5);
    }];
    
    [_secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_unitMinuteLabel.mas_right).offset(5);
    }];
    
    [_subsecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_secondLabel.mas_right).offset(2);
    }];
    
    [_unitSecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_subsecondLabel.mas_right).offset(5);
    }];
    
    [_millisecondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(DATE_VIEW_SIZE);
        make.centerY.equalTo(_cellBackgroundView);
        make.left.equalTo(_unitSecondLabel.mas_right).offset(5);
        make.right.equalTo(_cellBackgroundView);
    }];
    
}


- (void)setProductDetailModel:(ProductDetailModel *)productDetailModel{
    if (_productDetailModel != productDetailModel) {
        _productDetailModel = productDetailModel;
    }
    
    [self updateAllTimeWithStartTimeValue:_productDetailModel.skuCommission.startTime endTimeValue:_productDetailModel.skuCommission.endTime];
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
        [self clearAllTimerStatusText];
        timeStyle = ProductSpecialTimeStyleDay;
        NSString *startDateString = [self getDateStringWithTimeValue:startTimeValue formatter:DATE_FORMATTER_ONE];
        _messageLabel.text = [NSString stringWithFormat:@"特卖时间 %@", startDateString];
        _hourLabel.text = [NSString stringWithFormat:@"%ld", startDate.hour / 10];
        _subhourLabel.text = [NSString stringWithFormat:@"%ld", startDate.hour % 10];;
        _unitHourLabel.text = @":";
        _minuteLabel.text = [NSString stringWithFormat:@"%ld", startDate.minute / 10];;
        _subminuteLabel.text = [NSString stringWithFormat:@"%ld", startDate.minute % 10];
        [self settingAutoLayout];
    }
    
    //特卖（进行中）
    if ([nowDate isLaterThanOrEqualTo:startDate] && [nowDate isEarlierThanOrEqualTo:endDate]) {
        [self clearAllTimerStatusText];
        timeStyle = ProductSpecialTimeStyleHour;
        _messageLabel.text = @"距离结束仅剩";
        _hourLabel.text = [NSString stringWithFormat:@"%ld", (hours / 10)];
        _subhourLabel.text = [NSString stringWithFormat:@"%ld", (hours % 10)];
        _minuteLabel.text = [NSString stringWithFormat:@"%ld", (minutes / 10)];
        _subminuteLabel.text = [NSString stringWithFormat:@"%ld", (minutes % 10)];
        _secondLabel.text = [NSString stringWithFormat:@"%ld", (seconds / 10)];
        _subsecondLabel.text = [NSString stringWithFormat:@"%ld", (seconds % 10)];
        _millisecondLabel.text = [NSString stringWithFormat:@"%ld", milliseconds];
        _unitHourLabel.text = @":";
        _unitMinuteLabel.text = @":";
        _unitSecondLabel.text = @":";
        [self settingAutoLayout];
    }
    
    //特卖（已结束）
    if ([nowDate isLaterThan:endDate]) {
        [self recoverProductSpecialTimeStyleNone];
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

//清空数据
- (void)clearAllTimerStatusText{
    _messageLabel.text = nil;
    _hourLabel.text = nil;
    _subhourLabel.text = nil;
    _minuteLabel.text = nil;
    _subminuteLabel.text = nil;
    _secondLabel.text = nil;
    _subsecondLabel.text = nil;
    _millisecondLabel.text = nil;
    _unitHourLabel.text = nil;
    _unitMinuteLabel.text = nil;
    _unitSecondLabel.text = nil;
}


//恢复无内容样式
- (void)recoverProductSpecialTimeStyleNone{
    [self clearAllTimerStatusText];
    timeStyle = ProductSpecialTimeStyleNone;
    [self settingAutoLayout];
}
@end
