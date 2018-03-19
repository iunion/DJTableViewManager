//
//  DJSliderItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/3/19.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@class DJSliderItem;
typedef void (^sliderValueChangeHandler)(DJSliderItem *item);

@interface DJSliderItem : DJTableViewItem

// sliderValue： 0.0~1.0f
@property(nonatomic, assign) CGFloat sliderValue;
@property(nonatomic, assign) BOOL sliderable;
@property (nonatomic, assign) CGFloat sliderWidth;

@property (nonatomic, copy) sliderValueChangeHandler valueChangeHandler;

+ (instancetype)itemWithTitle:(nullable NSString *)title value:(CGFloat)value;
+ (instancetype)itemWithTitle:(nullable NSString *)title value:(CGFloat)value sliderValueChangeHandler:(nullable sliderValueChangeHandler)valueChangeHandler;

- (instancetype)initWithTitle:(nullable NSString *)title value:(CGFloat)value;
- (instancetype)initWithTitle:(nullable NSString *)title value:(CGFloat)value sliderValueChangeHandler:(nullable sliderValueChangeHandler)valueChangeHandler;

@end

NS_ASSUME_NONNULL_END
