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

#import "NSDate+Category.h"

const long long SECONDS_IN_YEAR = 31557600;
const long long SECONDS_IN_COMMONYEAR = 31536000;
const long long SECONDS_IN_LEAPYEAR = 31622400;
const NSInteger SECONDS_IN_MONTH_28 = 2419200;
const NSInteger SECONDS_IN_MONTH_29 = 2505600;
const NSInteger SECONDS_IN_MONTH_30 = 2592000;
const NSInteger SECONDS_IN_MONTH_31 = 2678400;
const NSInteger SECONDS_IN_WEEK = 604800;
const NSInteger SECONDS_IN_DAY = 86400;
const NSInteger SECONDS_IN_HOUR = 3600;
const NSInteger SECONDS_IN_MINUTE = 60;
const NSInteger MILLISECONDS_IN_DAY = 86400000;

static const unsigned int allCalendarUnitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear;

@implementation NSDate (Category)

+ (void)load
{
    [NSDate currentCalendar];
}

+ (NSString *)stringFromDate:(NSDate *)aDate
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    return [dateFormater stringFromDate:aDate];
}

+ (NSString *)stringFromDate:(NSDate *)aDate formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:formatter];
    return [dateFormater stringFromDate:aDate];
}

+ (NSString *)stringFromTs:(NSTimeInterval)timestamp
{
    return [NSDate stringFromTs:timestamp formatter:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)stringFromTs:(NSTimeInterval)timestamp formatter:(NSString *)formatter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:formatter];
    return [dateFormater stringFromDate:date];
}

+ (NSString *)stringFromNow
{
    return [NSDate stringFromDate:[NSDate date]];
}

//+ (NSString *)mqStringFromTs:(NSTimeInterval)timestamp
//{
//    NSTimeInterval ts = timestamp/1000;
//    
//    return [NSDate stringFromTs:ts];
//}

+ (NSString *)hmStringDateFromDate:(NSDate *)aDate
{
    NSTimeInterval timestamp = [aDate timeIntervalSince1970];

    return [self hmStringDateFromTs:timestamp];
}

+ (NSString *)hmStringDateFromTs:(NSTimeInterval)timestamp
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSInteger past = now - timestamp;
    if (past <= 0)
    {
        return @"刚刚";
    }
    else if (past < 60)
    {
        return [NSString stringWithFormat:@"%ld秒前", (long)past];
    }
    else if(past < 3600)
    {
        NSInteger min = past/60;
        return [NSString stringWithFormat:@"%ld分钟前", (long)min];
    }
    else if (past < 86400)
    {
        NSInteger hour = past/3600;
        return [NSString stringWithFormat:@"%ld小时前", (long)hour];
    }
    else if (past < 86400*5)
    {
        NSInteger day = past/86400;
        return [NSString stringWithFormat:@"%ld天前", (long)day];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
}

+ (NSTimeInterval)timeIntervalFromString:(NSString *)dateString
{
    return [NSDate timeIntervalFromString:dateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSTimeInterval)timeIntervalFromString:(NSString *)dateString withFormat:(NSString *)format
{
    NSDate *date = [self dateFromString:dateString withFormat:format];
    return [date timeIntervalSince1970];
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    return [NSDate dateFromString:dateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:format];
    NSDate *destDate = [dateFormatter dateFromString:dateString];

    //NSLog(@"%@", destDate);

    return destDate;
}

+ (NSString *)babyAgeWithDueDate:(NSDate *)dueDate
{
    if (!dueDate || [dueDate timeIntervalSince1970] == 0)
    {
        return @"";
    }

    NSDate *currentDay = [[NSDate date] dateAtStartOfDay];

    NSInteger pregancyDays = [dueDate daysAfterDate:currentDay] ;
    if (pregancyDays > MAX_PREGMENT_DAYS+1)
    {
        return @"备孕中";
    }
    else if (pregancyDays > 0 && pregancyDays <= MAX_PREGMENT_DAYS)
    {
        pregancyDays = MAX_PREGMENT_DAYS - pregancyDays;
        
        NSMutableString *pregnancyText = [NSMutableString stringWithCapacity:0];

        [pregnancyText appendString:@"孕"];

        NSInteger weekNum = (pregancyDays)/7;
        NSInteger dayNum = (pregancyDays)%7;
        if (weekNum > 0)
        {
            [pregnancyText appendFormat:@"%ld周", (long)weekNum];
            if (dayNum > 0)
            {
                [pregnancyText appendFormat:@"%ld天", (long)dayNum];
            }
        }
        else
        {
            if (dayNum > 0)
            {
                [pregnancyText appendFormat:@"%ld天", (long)dayNum];
            }
            else
            {
                return @"怀孕了";
            }
        }

        return pregnancyText;
    }
    else
    {
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
//        
//        NSDateComponents* comp1 = [calendar components:unitFlags fromDate:dueDate];
//        NSDateComponents* comp2 = [calendar components:unitFlags fromDate:currentDay];
//        NSInteger years = comp2.year - comp1.year;
//        NSInteger months = comp2.month - comp1.month;
//        NSInteger days = comp2.day - comp1.day;

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateCom = [calendar components:(NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[dueDate dateAtStartOfDay] toDate:[[NSDate date] dateAtStartOfDay] options:0];
        
        NSInteger years = [dateCom year];
        NSInteger months = [dateCom month];
        NSInteger days = [dateCom day];

        NSString *babyAge = @"";

        if (years > 0)
        {
            if (months > 0)
            {
                if (days > 0)
                {
                    babyAge = [NSString stringWithFormat:@"%ld岁%ld个月%ld天", (long)years, (long)months, (long)days];
                }
                else if (days == 0)
                {
                    babyAge = [NSString stringWithFormat:@"%ld岁%ld个月", (long)years, (long)months];
                }
            }
            else
            {
                if (days > 0)
                {
                    babyAge = [NSString stringWithFormat:@"%ld岁%ld天", (long)years, (long)days];
                }
                else if (days == 0)
                {
                    babyAge = [NSString stringWithFormat:@"%ld岁", (long)years];
                }
            }
        }
        else if (years == 0)
        {
            if (months > 0)
            {
                if (days > 0)
                {
                    babyAge = [NSString stringWithFormat:@"%ld个月%ld天", (long)months, (long)days];
                }
                else if (days == 0)
                {
                    babyAge = [NSString stringWithFormat:@"%ld个月", (long)months];
                }
            }
            else if (months == 0)
            {
//                if (days == 0)
//                {
//                    babyAge = @"宝宝出生";
//                }
//                else
//                {
//                    babyAge = [NSString stringWithFormat:@"%ld天", (long)days];
//                }
                babyAge = [NSString stringWithFormat:@"出生%ld天",(long)days+1];
            }
        }

        return babyAge;
    }
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    return [NSDate dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDate *nsDate = nil;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    components.year   = year;
    components.month  = month;
    components.day    = day;
    components.hour   = hour;
    components.minute = minute;
    components.second = second;
    
    nsDate = [[NSDate currentCalendar] dateFromComponents:components];
    
    return nsDate;
}

//+ (NSDate*)dateWithToday
//{
//    return [[NSDate date] dateAtMidnight];
//}
//
//- (NSDate*)dateAtMidnight
//{
//	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//	NSDateComponents *comps = [gregorian components:
//                               (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)
//                                           fromDate:[NSDate date]];
//	NSDate *midnight = [gregorian dateFromComponents:comps];
//	[gregorian release];
//	return midnight;
//}

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *)currentCalendar
{
//    static NSCalendar *sharedCalendar = nil;
//    if (!sharedCalendar)
//        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
//    return sharedCalendar;
    
    static NSCalendar *sharedCalendar = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    });
    
    return sharedCalendar;
}

+ (NSDate *)getCurrentDateWithSystemTimeZone
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];

    NSDate *localeDate = [date dateByAddingTimeInterval:interval];  

    NSLog(@"%@", localeDate);
    
    return localeDate;
}

+ (NSDate *)getCurrentDateWithTimeZone:(NSTimeZone *)timezone
{
    NSDate *date = [NSDate date];
    NSInteger interval = [timezone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];  
    
    NSLog(@"%@", localeDate);
    
    return localeDate;
}

#pragma mark - Relative Dates

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateToday
{
    return [NSDate dateWithDaysFromNow:0];
}

+ (NSDate *)dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECONDS_IN_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SECONDS_IN_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECONDS_IN_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SECONDS_IN_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

/*
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [calendar setTimeZone:GTMzone];
    NSDateComponents *components1 = [calendar components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [calendar components:DATE_COMPONENTS fromDate:aDate];
    //NSLog(@"%d, %d -- %d, %d -- %d, %d", [components1 year], [components2 year], [components1 month], [components2 month], [components1 day], [components2 day]);
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}
*/

+ (BOOL)isSameDayfirst:(NSTimeInterval)firstDate second:(NSTimeInterval)secondDate
{
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:firstDate];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:secondDate];
    return [date1 isSameDayAsDate:date2];
}

+ (BOOL)isSameDay:(NSDate *)date asDate:(NSDate *)compareDate
{
    return [date isSameDayAsDate:compareDate];
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
        (components1.month == components2.month) && 
        (components1.day == components2.day));
}

- (BOOL)isSameDayAsDate:(NSDate *)aDate
    {
    return [self isEqualToDateIgnoringTime:aDate];
}

- (BOOL)isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (abs((int)[self timeIntervalSinceDate:aDate]) < SECONDS_IN_WEEK);
}

- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECONDS_IN_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SECONDS_IN_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL)isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL)isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL)isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
	return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
	return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isEarlierThanOrEqualTo:(NSDate *) aDate
{
    return ([self compare:aDate] != NSOrderedDescending);
}

- (BOOL)isLaterThanOrEqualTo:(NSDate *) aDate
{
    return ([self compare:aDate] != NSOrderedAscending);
}

// Thanks, markrickert
- (BOOL)isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles

- (BOOL)isTypicallySunday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if (components.weekday == 1)
        return YES;
    return NO;
}

- (BOOL)isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

+ (BOOL)isLeapYear:(NSInteger)year
{
    if (year%400 == 0)
    {
        return YES;
    }
    else if (year%100 == 0)
    {
        return NO;
    }
    else if (year%4 == 0)
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)isLeapMonth
{
    return [[[NSDate currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

/**
 *  Returns whether the receiver falls in a leap year.
 *
 *  @return NSInteger
 */
- (BOOL)isInLeapYear
{
    NSInteger year = self.year;
    
    return [NSDate isLeapYear:year];
}


#pragma mark Adjusting  Date to String
- (NSString *)stringByFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:formatter];

    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringByDefaultFormatter
{
    return [self stringByFormatter:@"yyyy年MM月dd日"];
}


#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *)dateByAddingYears:(NSInteger)dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingYears:(NSInteger)dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *)dateByAddingMonths:(NSInteger)dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}
    
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

- (NSDate *)dateByAddingWeeks:(NSInteger) dweeks
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setWeekOfYear:dweeks];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingWeeks:(NSInteger) dweeks
{
    return [self dateByAddingWeeks:-dweeks];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *)dateByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SECONDS_IN_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SECONDS_IN_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)dateByAddingSeconds:(NSInteger) dSeconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + dSeconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingSeconds:(NSInteger)dSeconds
{
    return [self dateByAddingSeconds: (dSeconds * -1)];
}


#pragma mark - Extremes

- (NSDate *)dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *)dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SECONDS_IN_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SECONDS_IN_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SECONDS_IN_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SECONDS_IN_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SECONDS_IN_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SECONDS_IN_DAY);
}

- (NSTimeInterval)secondsFromDate:(NSDate *)aDate
{
    return [self timeIntervalSinceDate:aDate];
}

- (NSInteger)minutesFromDate:(NSDate *)aDate
{
    return [self minutesAfterDate:aDate];
}

- (NSInteger)hoursFromDate:(NSDate *)aDate
{
    return [self hoursAfterDate:aDate];
}

- (NSInteger)daysFromDate:(NSDate *)aDate
{
    NSDate *earliest = [self earlierDate:aDate];
    NSDate *latest = (earliest == self) ? aDate : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitDay fromDate:earliest toDate:latest options:0];
    return multiplier*components.day;
}

- (NSInteger)weeksFromDate:(NSDate *)aDate
{
//    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
//    return (NSInteger) (ti / SECONDS_IN_WEEK);
    
    NSDate *earliest = [self earlierDate:aDate];
    NSDate *latest = (earliest == self) ? aDate : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:earliest toDate:latest options:0];
    return multiplier*components.weekOfYear;
}

- (NSInteger)monthsFromDate:(NSDate *)aDate
{
    NSDate *earliest = [self earlierDate:aDate];
    NSDate *latest = (earliest == self) ? aDate : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:earliest toDate:latest options:0];
    return multiplier*(components.month + 12*components.year);
}

- (NSInteger)yearsFromDate:(NSDate *)aDate
{
    NSDate *earliest = [self earlierDate:aDate];
    NSDate *latest = (earliest == self) ? aDate : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:earliest toDate:latest options:0];
    return multiplier*components.year;
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}


#pragma mark - Decomposing Dates

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SECONDS_IN_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.minute;
}

- (NSInteger)seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.second;
}

- (NSInteger)day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.day;
}

- (NSInteger)month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.month;
}

- (NSInteger)quarter
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.quarter;
}

- (NSInteger)year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.year;
}

- (NSInteger)era
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.era;
}

- (NSInteger)dayOfYear
{
    NSCalendar *calendar = [NSDate currentCalendar];
    return [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
}

- (NSInteger)weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)weekOfMonth
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger)weekOfYear
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)weekdayOrdinal
{
    NSDateComponents *components = [[NSDate currentCalendar] components:allCalendarUnitFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)yearForWeekOfYear
{
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;

    NSDateComponents *components = [[NSDate currentCalendar] components:unitFlags fromDate:self];
    return components.yearForWeekOfYear;
}

- (NSInteger)daysInMonth
{
    NSCalendar *calendar = [NSDate currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:self];
    return days.length;
}

/**
 *  Returns how many days are in the year of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)daysInYear
{
    if ([self isInLeapYear])
    {
        return 366;
    }
    
    return 365;
}


#pragma mark - String Properties

- (NSString *)stringWithDefaultFormat
{
    return [self stringWithFormat:@"yyyy年MM月dd日"];
}

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.locale = [NSLocale currentLocale]; // Necessary?
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = dateStyle;
    dateFormatter.timeStyle = timeStyle;
    //formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [dateFormatter stringFromDate:self];
}

- (NSString *)mqString
{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}


@end
