//
//  NSDecimalNumber+Category.m
//  DJkit
//
//  Created by DennisDeng on 16/7/2.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import "NSDecimalNumber+Category.h"


@implementation NSDecimalNumber (Category)

+ (NSDecimalNumber *)rounding:(double)value withScale:(short)scale mode:(NSRoundingMode)roundingMode
{
    NSDecimalNumber *ouncesDecimal;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:value];
    return [NSDecimalNumber roundingNumber:ouncesDecimal withScale:scale mode:roundingMode];
}

+ (NSDecimalNumber *)roundingNumber:(NSDecimalNumber *)ouncesDecimal withScale:(short)scale mode:(NSRoundingMode)roundingMode
{
    return [ouncesDecimal roundToScale:scale mode:roundingMode];
}

+ (NSDecimalNumber *)decimalNumberWithFloat:(float)value
{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithFloat:value];

    return decimalNumber;
}

+ (NSDecimalNumber *)decimalNumberWithFloat:(float)value roundingScale:(short)scale
{
    return [[[NSDecimalNumber alloc] initWithFloat:value] roundToScale:scale];
}

+ (NSDecimalNumber *)decimalNumberWithFloat:(float)value roundingScale:(short)scale roundingMode:(NSRoundingMode)mode
{
    return [[[NSDecimalNumber alloc] initWithFloat:value] roundToScale:scale mode:mode];
}

+ (NSDecimalNumber *)decimalNumberWithDouble:(double)value
{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithDouble:value];
    
    return decimalNumber;
}

+ (NSDecimalNumber *)decimalNumberWithDouble:(double)value roundingScale:(short)scale
{
    return [[[NSDecimalNumber alloc] initWithDouble:value] roundToScale:scale];
}

+ (NSDecimalNumber *)decimalNumberWithDouble:(double)value roundingScale:(short)scale roundingMode:(NSRoundingMode)mode
{
    return [[[NSDecimalNumber alloc] initWithDouble:value] roundToScale:scale mode:mode];
}

+ (NSDecimalNumber *)decimalNumberWithBool:(BOOL)value
{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithBool:value];
    
    return decimalNumber;
}

+ (NSDecimalNumber *)decimalNumberWithInteger:(NSInteger)value
{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithInteger:value];
    
    return decimalNumber;
}

+ (NSDecimalNumber *)decimalNumberWithUnsignedInteger:(NSUInteger)value
{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithUnsignedInteger:value];
    
    return decimalNumber;
}


#pragma mark - Round

- (NSDecimalNumber *)roundToScale:(short)scale
{
    return [self roundToScale:scale mode:NSRoundPlain];
}

- (NSDecimalNumber *)roundToScale:(short)scale mode:(NSRoundingMode)roundingMode
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    
    return [self decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
}


#pragma mark -
#pragma mark compare
// NSOrderedAscending, NSOrderedSame, NSOrderedDescending
- (BOOL)isEqualToDecimalNumber:(NSDecimalNumber *)number
{
    BOOL result = ([self compare:number] == NSOrderedSame);
    return result;
}

- (BOOL)isGreaterThanDecimalnumber:(NSDecimalNumber *)number
{
    BOOL result = ([self compare:number] == NSOrderedDescending);
    return result;
}

- (BOOL)isGreaterThanOrEqualToDecimalnumber:(NSDecimalNumber *)number
{
    BOOL result = ([self compare:number] != NSOrderedAscending);
    return result;
}

- (BOOL)isLessThanDecimalnumber:(NSDecimalNumber *)number
{
    BOOL result = ([self compare:number] == NSOrderedAscending);
    return result;
}

- (BOOL)isLessThanOrEqualToDecimalnumber:(NSDecimalNumber *)number
{
    BOOL result = ([self compare:number] != NSOrderedDescending);
    return result;
}

@end
