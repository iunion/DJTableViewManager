//
//  DJNumberTextItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/23.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTextItem.h"

// 整数位
#define DJNumberText_MaxNumberDigits   7
// 保留小数位
#define DJNumberText_MaxDecimalPlaces  2

NS_ASSUME_NONNULL_BEGIN

@interface DJNumberTextItem : DJTextItem

@property (nullable, nonatomic, strong) NSDecimalNumber *numberValue;

@property (nullable, nonatomic, copy) NSDecimalNumber *maxNumberValue;
@property (nullable, nonatomic, copy) NSDecimalNumber *minNumberValue;

@property (assign, nonatomic) BOOL showWithDecimalStyle;

+ (instancetype)itemWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue;
+ (instancetype)itemWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue placeholder:(nullable NSString *)placeholder;
- (id)initWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue;
- (id)initWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue placeholder:(nullable NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
