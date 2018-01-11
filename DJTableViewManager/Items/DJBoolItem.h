//
//  DJBoolItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/11.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@class DJBoolItem;
typedef void (^switchValueChangeHandler)(DJBoolItem *item);

@interface DJBoolItem : DJTableViewItem

@property (nonatomic, assign) BOOL value;
@property (nullable, nonatomic, copy) switchValueChangeHandler valueChangeHandler;

@property (nonatomic, assign) BOOL switchable;

+ (instancetype)itemWithTitle:(nullable NSString *)title value:(BOOL)value;
+ (instancetype)itemWithTitle:(nullable NSString *)title value:(BOOL)value switchValueChangeHandler:(nullable switchValueChangeHandler)valueChangeHandler;

- (instancetype)initWithTitle:(nullable NSString *)title value:(BOOL)value;
- (instancetype)initWithTitle:(nullable NSString *)title value:(BOOL)value switchValueChangeHandler:(nullable switchValueChangeHandler)valueChangeHandler;

@end

NS_ASSUME_NONNULL_END
