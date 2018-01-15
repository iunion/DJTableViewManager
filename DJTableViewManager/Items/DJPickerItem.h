//
//  DJPickerItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJPickerItem : DJTableViewItem

@property (nonatomic, strong) NSArray *components;
@property (nullable, nonatomic, strong) NSArray *values;

@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) NSTextAlignment pickerTextAlignment;

@property (nullable, nonatomic, strong) UIColor *pickerValueColor;
@property (nullable, nonatomic, strong) UIFont *pickerValueFont;

@property (nullable, nonatomic, strong) UIColor *pickerPlaceholderColor;

@property (nullable, nonatomic, strong) NSString *defaultPickerText;
@property (nullable, nonatomic, strong, readonly) NSString *pickerText;

@property (nullable, nonatomic, copy) void (^onChange)(DJPickerItem *item);

@property (nullable, nonatomic, copy) NSString  * _Nullable (^formatPickerText)(DJPickerItem *item);

+ (instancetype)itemWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder components:(NSArray *)components;
+ (instancetype)itemWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder components:(NSArray *)components defaultPickerText:(nullable NSString *)defaultPickerText;
- (instancetype)initWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder components:(NSArray *)components;
- (instancetype)initWithTitle:(nullable NSString *)title placeholder:(nullable NSString *)placeholder components:(NSArray *)components defaultPickerText:(nullable NSString *)defaultPickerText;

@end

NS_ASSUME_NONNULL_END
