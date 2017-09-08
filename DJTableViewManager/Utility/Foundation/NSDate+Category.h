//
//  NSDate+Category.h
//  DJkit
//
//  Created by DennisDeng on 13-12-18.
//  Copyright (c) 2013年 DennisDeng. All rights reserved.
//

/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

//#define D_MINUTE 60
//#define D_HOUR 3600
//#define D_DAY 86400
//#define D_WEEK 604800
//#define D_YEAR 31556926

FOUNDATION_EXPORT const long long SECONDS_IN_YEAR;
FOUNDATION_EXPORT const long long SECONDS_IN_COMMONYEAR;
FOUNDATION_EXPORT const long long SECONDS_IN_LEAPYEAR;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_28;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_29;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_30;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_31;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_WEEK;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_DAY;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_HOUR;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MINUTE;
FOUNDATION_EXPORT const NSInteger MILLISECONDS_IN_DAY;


#define MAX_PREGMENT_DAYS   280

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Category)

+ (NSString *)stringFromDate:(NSDate *)aDate;
+ (NSString *)stringFromDate:(NSDate *)aDate formatter:(NSString *)formatter;
+ (NSString *)stringFromTs:(NSTimeInterval)timestamp;
+ (NSString *)stringFromTs:(NSTimeInterval)timestamp formatter:(NSString *)formatter;
+ (NSString *)stringFromNow;
//+ (NSString *)mqStringFromTs:(NSTimeInterval)timestamp;
+ (NSString *)hmStringDateFromDate:(NSDate *)aDate;
+ (NSString *)hmStringDateFromTs:(NSTimeInterval)timestamp;

+ (NSTimeInterval)timeIntervalFromString:(NSString *)dateString;
+ (NSTimeInterval)timeIntervalFromString:(NSString *)dateString withFormat:(NSString *)format;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

+ (NSCalendar *)currentCalendar;

+ (NSDate *)getCurrentDateWithSystemTimeZone;
+ (NSDate *)getCurrentDateWithTimeZone:(NSTimeZone *)timezone;

+ (NSString *)babyAgeWithDueDate:(NSDate *)dueDate;

/**
 * Returns the current date with the time set to midnight.
 */
+ (NSDate *)dateToday;


// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Comparing dates
+ (BOOL)isSameDayfirst:(NSTimeInterval)firstDate second:(NSTimeInterval)secondDate;
+ (BOOL)isSameDay:(NSDate *)date asDate:(NSDate *)compareDate;
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isSameDayAsDate:(NSDate *)aDate;

- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;

- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;
- (BOOL)isEarlierThanOrEqualTo:(NSDate *)aDate;
- (BOOL)isLaterThanOrEqualTo:(NSDate *)aDate;

- (BOOL)isInFuture;
- (BOOL)isInPast;

// Date roles
- (BOOL)isTypicallySunday;
- (BOOL)isTypicallyWorkday;
- (BOOL)isTypicallyWeekend;

- (BOOL)isLeapMonth;
// 闰年
- (BOOL)isInLeapYear;

// Date to String
- (NSString *)stringByFormatter:(NSString *)formatter;
- (NSString *)stringByDefaultFormatter;

// Adjusting dates
- (NSDate *)dateByAddingYears:(NSInteger)dYears;
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)dateByAddingWeeks:(NSInteger)dweeks;
- (NSDate *)dateBySubtractingWeeks:(NSInteger)dweeks;
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateByAddingSeconds:(NSInteger)dSeconds;
- (NSDate *)dateBySubtractingSeconds:(NSInteger)dSeconds;

// Date extremes
/*
 * Returns a copy of the date with the time set to 00:00:00 on the same day.
 */
- (NSDate *)dateAtStartOfDay;
/*
 * Returns a copy of the date with the time set to 23:59:59 on the same day.
 */
- (NSDate *)dateAtEndOfDay;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;

- (NSTimeInterval)secondsFromDate:(NSDate *)aDate;
- (NSInteger)minutesFromDate:(NSDate *)aDate;
- (NSInteger)hoursFromDate:(NSDate *)aDate;
- (NSInteger)daysFromDate:(NSDate *)aDate;
- (NSInteger)weeksFromDate:(NSDate *)aDate;
- (NSInteger)monthsFromDate:(NSDate *)aDate;
- (NSInteger)yearsFromDate:(NSDate *)aDate;

- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
// 接近的小时
- (NSInteger)nearestHour;
// hour(小时)
- (NSInteger)hour;
// minute(分钟)
- (NSInteger)minute;
// second(秒)
- (NSInteger)seconds;
// day(日期)
- (NSInteger)day;
// month(月份)
- (NSInteger)month;
// quarter(季度)
- (NSInteger)quarter;
// year(年份)
- (NSInteger)year;
// era(年份)
- (NSInteger)era;



// dayOfYear(本年第几天)
- (NSInteger)dayOfYear;

// weekday(星期)
// Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Friday:5, Saturday:6
- (NSInteger)weekday;
// weekOfMonth(本月第几周)
- (NSInteger)weekOfMonth;
// weekOfYear(本年第几周)
- (NSInteger)weekOfYear;
- (NSInteger)nthWeekday; // e.g. 2nd Tuesday of the month == 2
- (NSInteger)weekdayOrdinal;  // same as nthWeekday
- (NSInteger)yearForWeekOfYear;

// 本月天数
- (NSInteger)daysInMonth;
// 本年天数
- (NSInteger)daysInYear;


// Date to String
- (NSString *)stringWithDefaultFormat;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSString *)mqString;
- (NSString *)shortString;
- (NSString *)shortDateString;
- (NSString *)shortTimeString;
- (NSString *)mediumString;
- (NSString *)mediumDateString;
- (NSString *)mediumTimeString;
- (NSString *)longString;
- (NSString *)longDateString;
- (NSString *)longTimeString;

@end

NS_ASSUME_NONNULL_END
