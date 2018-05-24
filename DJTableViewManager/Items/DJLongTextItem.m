//
//  DJLongTextItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/20.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJLongTextItem.h"

@implementation DJLongTextItem

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    self = [super initWithTitle:title value:value placeholder:placeholder];
    
    if (self)
    {
        self.textViewTextContainerInset = UIEdgeInsetsZero;
        self.textViewPlaceholderLineBreakMode = NSLineBreakByTruncatingTail;
        self.textViewTextAlignment = NSTextAlignmentLeft;
        self.textViewSelectable = YES;
        
        self.textLabelTopGap = 8.0f;
        self.textViewTopGap = 8.0f;
        self.textViewLeftGap = 4.0f;
        
        self.showTextViewBorder = YES;
    }
    
    return self;
}

@end
