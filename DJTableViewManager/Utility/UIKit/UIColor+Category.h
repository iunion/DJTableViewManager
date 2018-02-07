//
//  UIColor+Category.h
//  DJkit
//
//  Created by DennisDeng on 12-1-11.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (nullable UIColor *) colorWithHexString:(nullable NSString *)stringToConvert;
+ (nullable UIColor *) colorWithHexString:(nullable NSString *)stringToConvert alpha:(CGFloat)alpha;
+ (nullable UIColor *) colorWithHexString:(nullable NSString *)stringToConvert default:(nullable UIColor *)color;
+ (nullable UIColor *) colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha default:(nullable UIColor *)color;

+ (UIColor *) colorWithHex:(UInt32)hex;
+ (UIColor *) colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (UIColor *) randomColor;
+ (UIColor *) randomColorWithAlpha:(CGFloat)alpha;

// 从startColor过渡到endColor
// progress: 0~1.0
+ (UIColor *)startColor:(UIColor *)startColor endColor:(UIColor *)endColor progress:(CGFloat)progress;
+ (UIColor *)startColorHex:(UInt32)startColor endColorHex:(UInt32)endColor progress:(CGFloat)progress;
+ (UIColor *)startColorHex:(UInt32)startColor endColorHex:(UInt32)endColor startAlpha:(CGFloat)startAlpha endAlpha:(CGFloat)endAlpha progress:(CGFloat)progress;

@end



@interface UIColor (UIColor_Expanded)
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;

// With the exception of -alpha, these properties will function
// correctly only if this color is an RGB or white color.
// In these cases, canProvideRGBComponents returns YES.
@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) CGFloat hue;
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGFloat luminance;
@property (nonatomic, readonly) UInt32 rgbHex;

- (UIColor *)changeAlpha:(CGFloat)alpha;

- (BOOL)isLighterColor;
- (nullable UIColor *)lighterColor;
- (nullable UIColor *)darkerColor;

- (NSString *) colorSpaceString;
- (nullable NSArray *) arrayFromRGBAComponents;

// Bulk access to RGB and HSB components of the color
// HSB components are converted from the RGB components
- (BOOL) red:(nullable CGFloat *)r green:(nullable CGFloat *)g blue:(nullable CGFloat *)b alpha:(nullable CGFloat *)a;
- (BOOL) hue:(nullable CGFloat *)h saturation:(nullable CGFloat *)s brightness:(nullable CGFloat *)b alpha:(nullable CGFloat *)a;

// Return a grey-scale representation of the color
- (UIColor *) colorByLuminanceMapping;

// Arithmetic operations on the color
- (nullable UIColor *) colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (nullable UIColor *) colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (nullable UIColor *) colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (nullable UIColor *) colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (nullable UIColor *) colorByMultiplyingBy:(CGFloat)f;
- (nullable UIColor *) colorByAdding:(CGFloat)f;
- (nullable UIColor *) colorByLighteningTo:(CGFloat)f;
- (nullable UIColor *) colorByDarkeningTo:(CGFloat)f;

- (nullable UIColor *) colorByMultiplyingByColor:(UIColor *)color;
- (nullable UIColor *) colorByAddingColor:(UIColor *)color;
- (nullable UIColor *) colorByLighteningToColor:(UIColor *)color;
- (nullable UIColor *) colorByDarkeningToColor:(UIColor *)color;

// Related colors
- (UIColor *) contrastingColor; // A good contrasting color: will be either black or white
- (nullable UIColor *) complementaryColor; // A complementary color that should look good with this color
- (UIColor *)disableColor;
- (nullable NSArray*) triadicColors; // Two colors that should look good with this color
- (nullable NSArray*) analogousColorsWithStepAngle:(CGFloat)stepAngle pairCount:(int)pairs; // Multiple pairs of colors

// String representations of the color
- (nullable NSString *) stringFromColor;
- (NSString *) hexStringFromColor;

// Low level conversions between RGB and HSL spaces
+ (void) hue:(CGFloat)h saturation:(CGFloat)s brightness:(CGFloat)v toRed:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b;
+ (void) red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b toHue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)v;

@end

NS_ASSUME_NONNULL_END
