//
//  DJDateTimeItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"
#import "DJDatePicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJDateTimeItem : DJTableViewItem

@property (nullable, nonatomic, strong) NSDate *pickerDate;
@property (nullable, nonatomic, strong) NSDate *defaultPickerDate;

@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) NSTextAlignment pickerTextAlignment;

@property (nullable, nonatomic, strong) UIColor *pickerValueColor;
@property (nullable, nonatomic, strong) UIFont *pickerValueFont;

@property (nullable, nonatomic, strong) UIColor *pickerPlaceholderColor;

// DJDatePicker
@property (nonatomic, assign) DJPickerStyle pickerStyle;

// 格式化
// 文本颜色
@property (nonatomic, strong) UIColor *formateColor;
// 显示时间格式
@property (nonatomic, strong) NSString *formate;

// 年份
// 文本颜色
@property (nonatomic, strong) UIColor *bigYearColor;

// 滚轮
// 年-月-日-时-分 分栏文字颜色
@property (nonatomic, strong) UIColor *pickerLabelColor;
// 滚轮日期颜色
@property (nonatomic, strong) UIColor *pickerItemColor;

// 确定按钮
@property (nonatomic, assign) BOOL showDoneBtn;
// 确定按钮背景颜色
@property (nonatomic, strong) UIColor *doneBtnBgColor;
// 确定按钮文本颜色
@property (nonatomic, strong) UIColor *doneBtnTextColor;

// 滚动最大时间限制（默认2099）
@property (nonatomic, strong) NSDate *maxLimitDate;
// 滚动最小时间限制（默认0）
@property (nonatomic, strong) NSDate *minLimitDate;

@property (nullable, nonatomic, copy) void (^onChange)(DJDateTimeItem *item);

@property (nullable, nonatomic, copy) NSString  * _Nullable (^formatPickerText)(DJDateTimeItem *item);

+ (instancetype)itemWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder;
+ (instancetype)itemWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder defaultPickerDate:(nullable NSDate *)defaultPickerDate;

- (instancetype)initWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder;
- (instancetype)initWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder defaultPickerDate:(nullable NSDate *)defaultPickerDate;

@end

NS_ASSUME_NONNULL_END

