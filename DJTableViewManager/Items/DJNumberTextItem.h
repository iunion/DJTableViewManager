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

@interface DJNumberTextItem : DJTextItem

@property (strong, nonatomic) NSDecimalNumber *numberValue;

@property (copy, nonatomic) NSDecimalNumber *maxNumberValue;
@property (copy, nonatomic) NSDecimalNumber *minNumberValue;

@property (assign, nonatomic) BOOL showWithDecimalStyle;

+ (instancetype)itemWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue;
+ (instancetype)itemWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue placeholder:(NSString *)placeholder;
- (id)initWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue;
- (id)initWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue placeholder:(NSString *)placeholder;

@end
