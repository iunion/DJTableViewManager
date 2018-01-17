//
//  DJDateTimeItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJDateTimeItem.h"

@implementation DJDateTimeItem

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    return [[self alloc] initWithTitle:title placeholder:placeholder defaultPickerDate:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder defaultPickerDate:(NSDate *)defaultPickerDate
{
    return [[self alloc] initWithTitle:title placeholder:placeholder defaultPickerDate:defaultPickerDate];
}

- (instancetype)initWithTitle:(nullable NSString *)title placeholder:(NSString *)placeholder
{
    return [self initWithTitle:title placeholder:placeholder defaultPickerDate:nil];
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder defaultPickerDate:(NSDate *)defaultPickerDate
{
    self = [self init];
    if (!self)
    {
        return nil;
    }
    
    self.title = title;
    self.placeholder = placeholder;

    self.defaultPickerDate = defaultPickerDate;

    return self;
}

- (instancetype)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.isShowHighlightBg = NO;
    
    self.pickerTextAlignment = NSTextAlignmentRight;
    
    self.pickerValueColor = [UIColor grayColor];
    self.pickerValueFont = [UIFont systemFontOfSize:14.0f];
    
    self.pickerPlaceholderColor = [UIColor lightGrayColor];
    
    self.formateColor = RGBColor(233, 233, 233, 0.8);
    
    self.bigYearColor = RGBColor(233, 233, 233, 0.8);
    
    self.pickerLabelColor = RGBColor(247, 133, 51, 1);
    self.pickerItemColor = [UIColor blackColor];
    
    self.showDoneBtn = YES;
    self.doneBtnBgColor = RGBColor(247, 133, 51, 1);
    self.doneBtnTextColor = [UIColor whiteColor];

    self.maxLimitDate = [NSDate dateFromString:@"2099-12-31 23:59" withFormat:@"yyyy-MM-dd HH:mm"];
    self.minLimitDate = [NSDate dateFromString:@"0001-01-01 00:00" withFormat:@"yyyy-MM-dd HH:mm"];

    return self;
}

@end
