//
//  DJSegmentItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/17.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJSegmentItem.h"

@implementation DJSegmentItem

+ (instancetype)itemWithTitle:(nullable NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    return [[self alloc] initWithTitle:title segmentedItems:segmentedItems selectedSegmentIndex:selectedSegmentIndex segmentValueChangeHandler:nil];
}

+ (instancetype)itemWithTitle:(nullable NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex segmentValueChangeHandler:(nullable segmentValueChangeHandler)valueChangeHandler
{
    return [[self alloc] initWithTitle:title segmentedItems:segmentedItems selectedSegmentIndex:selectedSegmentIndex segmentValueChangeHandler:valueChangeHandler];
}

- (instancetype)initWithTitle:(NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    return [self initWithTitle:title segmentedItems:segmentedItems selectedSegmentIndex:selectedSegmentIndex segmentValueChangeHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title segmentedItems:(NSArray *)segmentedItems selectedSegmentIndex:(NSInteger)selectedSegmentIndex segmentValueChangeHandler:(segmentValueChangeHandler)valueChangeHandler
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    //self.isShowSelectBg = NO;
    self.isShowHighlightBg = NO;
    
    self.title = title;

    self.segmentedItems = segmentedItems;
    self.selectedSegmentIndex = selectedSegmentIndex;
    
    self.segmentable = YES;
    self.valueChangeHandler = valueChangeHandler;
    
    return self;
}

//UISegmentedControlNoSegment

@end
