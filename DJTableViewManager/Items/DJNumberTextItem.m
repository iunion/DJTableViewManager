//
//  DJNumberTextItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/23.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJNumberTextItem.h"

@implementation DJNumberTextItem

+ (instancetype)itemWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue
{
    return [[self alloc] initWithTitle:title numberValue:numberValue];
}

+ (instancetype)itemWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue placeholder:(NSString *)placeholder
{
    return [[self alloc] initWithTitle:title numberValue:numberValue placeholder:placeholder];
}

- (instancetype)initWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue
{
    return [self initWithTitle:title numberValue:numberValue placeholder:nil];
}

- (instancetype)initWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue placeholder:(NSString *)placeholder
{
    //NSString *value = [numberValue stringWithNormalDecimalStyle];
    NSString *value = [numberValue stringWithNoStyleDecimalScale:DJNumberText_MaxDecimalPlaces];
    self.showWithDecimalStyle = NO;
    return [self initWithTitle:title value:value placeholder:placeholder];
}

- (void)setNumberValue:(NSDecimalNumber *)numberValue
{
    //self.value = [numberValue stringWithNormalDecimalStyle];
    self.value = [numberValue stringWithNoStyleDecimalScale:DJNumberText_MaxDecimalPlaces];
}

- (NSDecimalNumber *)numberValue
{
    return [NSDecimalNumber decimalNumberWithString:self.value];
}

- (void)setMinNumberValue:(NSDecimalNumber *)minNumberValue
{
    if (!minNumberValue)
    {
        return;
    }
    
    if ([minNumberValue isEqualToNumber:_minNumberValue])
    {
        return;
    }
    
    if (self.maxNumberValue)
    {
        if ([minNumberValue compare:self.maxNumberValue] == NSOrderedDescending)
        {
            minNumberValue = self.maxNumberValue;
        }
    }
    
    _minNumberValue = minNumberValue;
}

- (void)setMaxNumberValue:(NSDecimalNumber *)maxNumberValue
{
    if (!maxNumberValue)
    {
        return;
    }
    
    if ([maxNumberValue isEqualToNumber:_maxNumberValue])
    {
        return;
    }
    
    if (self.minNumberValue)
    {
        if ([maxNumberValue compare:self.minNumberValue] == NSOrderedAscending)
        {
            maxNumberValue = self.minNumberValue;
        }
    }
    
    _maxNumberValue = maxNumberValue;
}

@end
