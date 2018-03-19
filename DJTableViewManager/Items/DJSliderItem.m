//
//  DJSliderItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/3/19.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJSliderItem.h"

@implementation DJSliderItem

+ (instancetype)itemWithTitle:(nullable NSString *)title value:(CGFloat)value
{
    return [[self alloc] initWithTitle:title value:value sliderValueChangeHandler:nil];
}

+ (instancetype)itemWithTitle:(nullable NSString *)title value:(CGFloat)value sliderValueChangeHandler:(nullable sliderValueChangeHandler)valueChangeHandler
{
    return [[self alloc] initWithTitle:title value:value sliderValueChangeHandler:valueChangeHandler];
}

- (instancetype)initWithTitle:(nullable NSString *)title value:(CGFloat)value
{
    return [self initWithTitle:title value:value sliderValueChangeHandler:nil];
}

- (instancetype)initWithTitle:(nullable NSString *)title value:(CGFloat)value sliderValueChangeHandler:(nullable sliderValueChangeHandler)valueChangeHandler
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    //self.isShowSelectBg = NO;
    self.isShowHighlightBg = NO;
    
    self.title = title;
    self.sliderValue = value;

    self.sliderable = YES;
    self.valueChangeHandler = valueChangeHandler;
    
    self.sliderWidth = (UI_SCREEN_WIDTH - 40.0f) * 0.5f;

    return self;
}

@end
