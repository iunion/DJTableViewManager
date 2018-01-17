//
//  UIColor+Category.h
//  DJkit
//
//  Created by DennisDeng on 14-5-5.
//  Copyright (c) 2014年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
