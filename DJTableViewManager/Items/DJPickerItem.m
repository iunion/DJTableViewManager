//
//  DJPickerItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJPickerItem.h"

@implementation DJPickerItem

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder components:(NSArray *)components
{
    return [[self alloc] initWithTitle:title placeholder:placeholder components:components];
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder components:(NSArray *)components defaultPickerText:(NSString *)defaultPickerText
{
    return [[self alloc] initWithTitle:title placeholder:placeholder components:components defaultPickerText:defaultPickerText];
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder components:(NSArray *)components
{
    return [self initWithTitle:title placeholder:placeholder components:components defaultPickerText:nil];
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder components:(NSArray *)components defaultPickerText:(NSString *)defaultPickerText
{
    self = [self init];
    if (!self)
    {
        return nil;
    }

    self.title = title;
    self.placeholder = placeholder;
    self.components = components;
    
    self.defaultPickerText = defaultPickerText;

    return self;
}

- (instancetype)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.isShowHighlightBg = NO;
    
    self.pickerTextAlignment = NSTextAlignmentRight;
    
    self.pickerValueColor = [UIColor grayColor];
    self.pickerValueFont = [UIFont systemFontOfSize:14.0f];
    
    self.pickerPlaceholderColor = [UIColor lightGrayColor];

    return self;
}

@end
