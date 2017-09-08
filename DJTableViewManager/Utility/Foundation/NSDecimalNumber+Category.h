//
//  NSDecimalNumber+Category.h
//  DJkit
//
//  Created by DennisDeng on 16/7/2.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (Category)

+ (NSDecimalNumber *)rounding:(double)value withScale:(short)scale mode:(NSRoundingMode)roundingMode;
+ (NSDecimalNumber *)roundingNumber:(NSDecimalNumber *)ouncesDecimal withScale:(short)scale mode:(NSRoundingMode)roundingMode;

+ (NSDecimalNumber *)decimalNumberWithFloat:(float)value;
+ (NSDecimalNumber *)decimalNumberWithDouble:(double)value;
+ (NSDecimalNumber *)decimalNumberWithBool:(BOOL)value;
+ (NSDecimalNumber *)decimalNumberWithInteger:(NSInteger)value NS_AVAILABLE(10_5, 2_0);
+ (NSDecimalNumber *)decimalNumberWithUnsignedInteger:(NSUInteger)value NS_AVAILABLE(10_5, 2_0);

/**
 *  Return a decimal number from float value, and rounds it off in the way specified by scale. The rounding mode is NSRoundPlain.
 *
 *  @param value Float value.
 *  @param scale The number of digits a rounded value should have after its decimal point.
 */
+ (NSDecimalNumber *)decimalNumberWithFloat:(float)value roundingScale:(short)scale;

/**
 *  Return a decimal number from float value, and rounds it off in the way specified by scale and roundingMode.
 *
 *  @param value Float value.
 *  @param scale The number of digits a rounded value should have after its decimal point.
 *  @param mode  The rounding mode to use. There are four possible values: NSRoundUp, NSRoundDown, NSRoundPlain, and NSRoundBankers.
 */
+ (NSDecimalNumber *)decimalNumberWithFloat:(float)value roundingScale:(short)scale roundingMode:(NSRoundingMode)mode;

/**
 *  Return a decimal number from double value, and rounds it off in the way specified by scale. The rounding mode is NSRoundPlain.
 *
 *  @param value Double value.
 *  @param scale The number of digits a rounded value should have after its decimal point.
 */
+ (NSDecimalNumber *)decimalNumberWithDouble:(double)value roundingScale:(short)scale;

/**
 *  Return a decimal number from double value, and rounds it off in the way specified by scale and roundingMode.
 *
 *  @param value Double value.
 *  @param scale The number of digits a rounded value should have after its decimal point.
 *  @param mode  The rounding mode to use. There are four possible values: NSRoundUp, NSRoundDown, NSRoundPlain, and NSRoundBankers.
 */
+ (NSDecimalNumber *)decimalNumberWithDouble:(double)value roundingScale:(short)scale roundingMode:(NSRoundingMode)mode;

#pragma mark - Round
/**
 *  Rounds a decimal number off in the way specified by scale. The rounding mode is NSRoundPlain.
 *
 *  @param scale The number of digits a rounded value should have after its decimal point.
 */
- (NSDecimalNumber *)roundToScale:(short)scale;

/**
 *  Rounds a decimal number off in the way specified by scale and roundingMode.
 *
 *  @param scale        The number of digits a rounded value should have after its decimal point.
 *  @param roundingMode The rounding mode to use. There are four possible values: NSRoundUp, NSRoundDown, NSRoundPlain, and NSRoundBankers.
 */
- (NSDecimalNumber *)roundToScale:(short)scale mode:(NSRoundingMode)roundingMode;


- (BOOL)isEqualToDecimalNumber:(NSDecimalNumber *)number;
- (BOOL)isGreaterThanDecimalnumber:(NSDecimalNumber *)number;
- (BOOL)isGreaterThanOrEqualToDecimalnumber:(NSDecimalNumber *)number;
- (BOOL)isLessThanDecimalnumber:(NSDecimalNumber *)number;
- (BOOL)isLessThanOrEqualToDecimalnumber:(NSDecimalNumber *)number;

@end

NS_ASSUME_NONNULL_END

