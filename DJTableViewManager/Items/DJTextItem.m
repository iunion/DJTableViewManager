//
//  DJTextItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTextItem.h"

@implementation DJTextItem

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    self = [super initWithTitle:title value:value placeholder:placeholder];
    
    if (self)
    {
        self.textFieldSeparatorInset = UIEdgeInsetsZero;
    }
    
    return self;
}

@end
