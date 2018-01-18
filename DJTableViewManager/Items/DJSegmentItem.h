//
//  DJSegmentItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/17.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@class DJSegmentItem;
typedef void (^segmentValueChangeHandler)(DJSegmentItem *item);

@interface DJSegmentItem : DJTableViewItem

// items can be NSStrings or UIImages
@property (nonatomic, strong) NSArray *segmentedItems;

@property(nonatomic, assign) BOOL segmentable;
// items can be NSNumbers, index of segmentedItems
@property (nullable, nonatomic, copy) NSArray *disableItems;

@property(nonatomic, assign) BOOL momentary;
// ignored in momentary mode. returns last segment pressed. default is UISegmentedControlNoSegment until a segment is pressed
@property(nonatomic, assign) NSInteger selectedSegmentIndex;

@property (nullable, nonatomic, strong) UIColor *tintColor;

@property (nullable, nonatomic, copy) segmentValueChangeHandler valueChangeHandler;

+ (instancetype)itemWithTitle:(nullable NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex;
+ (instancetype)itemWithTitle:(nullable NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex segmentValueChangeHandler:(nullable segmentValueChangeHandler)valueChangeHandler;

- (instancetype)initWithTitle:(nullable NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex;
- (instancetype)initWithTitle:(nullable NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex segmentValueChangeHandler:(nullable segmentValueChangeHandler)valueChangeHandler;

@end

NS_ASSUME_NONNULL_END
