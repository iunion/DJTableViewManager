//
//  DJDatePicker.h
//  DJDatePicker
//
//  Created by DJ on 2017/8/24.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DJPickerStyle)
{
    PickerStyle_YearMonthDayHourMinute  = 0,    // 年月日时分
    PickerStyle_MonthDayHourMinute,             // 月日时分
    PickerStyle_YearMonthDay,                   // 年月日
    PickerStyle_MonthDay,                       // 月日
    PickerStyle_HourMinute                      // 时分(24)
};

typedef void(^DJDatePickerDoneBlock)(NSDate * _Nonnull date, BOOL isDone);

NS_ASSUME_NONNULL_BEGIN

@interface DJDatePicker : UIView

// 类型
@property (nonatomic, assign) DJPickerStyle pickerStyle;

// 格式化
// 文本颜色
@property (nullable, nonatomic, strong) UIColor *formateColor;
// 显示时间格式
@property (nullable, nonatomic, strong) NSString *formate;

// 年份
// 文本颜色
@property (nullable, nonatomic, strong) UIColor *yearColor;

// 滚轮
// 年-月-日-时-分 分栏文字颜色
@property (nullable, nonatomic, strong) UIColor *pickerLabelColor;
// 滚轮日期颜色
@property (nullable, nonatomic, strong) UIColor *pickerItemColor;

// 确定按钮
@property (nonatomic, assign) BOOL showDoneBtn;
// 确定按钮背景颜色
@property (nullable, nonatomic, strong) UIColor *doneBtnBgColor;
// 确定按钮文本颜色
@property (nullable, nonatomic, strong) UIColor *doneBtnTextColor;

// 滚动最大时间限制（默认2099）
@property (nonatomic, strong) NSDate *maxLimitDate;
// 滚动最小时间限制（默认0）
@property (nonatomic, strong) NSDate *minLimitDate;

@property (nullable, nonatomic, strong, readonly) NSDate *pickerDate;

@property (nullable, nonatomic, copy) DJDatePickerDoneBlock completeBlock;

// 默认滚动到当前时间
- (instancetype)initWithPickerStyle:(DJPickerStyle)pickerStyle completeBlock:(nullable DJDatePickerDoneBlock)completeBlock;

// 滚动到指定的的日期
- (instancetype)initWithPickerStyle:(DJPickerStyle)pickerStyle scrollToDate:(nullable NSDate *)scrollToDate completeBlock:(nullable DJDatePickerDoneBlock)completeBlock;

// 滚动到指定的时间位置
- (void)scrollToDate:(nullable NSDate *)date animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END


