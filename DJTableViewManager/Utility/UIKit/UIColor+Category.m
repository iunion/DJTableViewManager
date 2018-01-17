//
//  UIColor+Category.m
//  DJkit
//
//  Created by DennisDeng on 14-5-5.
//  Copyright (c) 2014年 DennisDeng. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)hex
{
	return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)randomColor
{
    return [UIColor randomColorWithAlpha:1.0f];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha
{
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

@end
