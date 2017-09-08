//
//  NSNumber+Category.h
//  DJkit
//
//  Created by DennisDeng on 16/1/21.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Category)

// 0 --> 0.00
- (nullable NSString *)stringWithDecimalStyle;

// 0 --> 0
- (nullable NSString *)stringWithNormalDecimalStyle;

// 转换数字保留scale位小数
- (nullable NSString *)stringWithNoStyleDecimalScale:(short)scale;
- (nullable NSString *)stringWithNoStyleDecimalNozeroScale:(short)scale;
- (nullable NSString *)stringWithDecimalStyleDecimalScale:(short)scale;

- (nullable NSString *)stringWithNoStyleMaximumFractionDigits:(NSUInteger)maximumFractionDigits minimumFractionDigits:(NSUInteger)minimumFractionDigits;
- (nullable NSString *)stringWithDecimalStyleMaximumFractionDigits:(NSUInteger)maximumFractionDigits minimumFractionDigits:(NSUInteger)minimumFractionDigits;

- (nullable NSString *)stringWithNumberFormatUsePositiveFormat:(nullable NSString *)positiveFormat;

- (nullable NSString *)stringWithNumberFormat:(nullable NSNumberFormatter *)formatter;

@end
