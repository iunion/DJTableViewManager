//
//  UILabel+Category.h
//  DJkit
//
//  Created by DennisDeng on 15/7/20.
//  Copyright (c) 2015年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Category)

+ (instancetype)labelWithFrame:(CGRect)frame text:(nullable NSString *)text fontSize:(CGFloat)fontSize color:(nullable UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines;
+ (instancetype)labelWithFrame:(CGRect)frame text:(nullable NSString *)text fontSize:(CGFloat)fontSize color:(nullable UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(nullable UIColor *)txtShadowColor;


- (CGSize)attribSizeToFitWidth:(CGFloat)width;
- (CGSize)attribSizeToFitHeight:(CGFloat)height;
- (CGSize)attribSizeToFit:(CGSize)maxSize;

// 以下不支持attributedText带属性计算，只支持普通text
- (CGSize)labelSizeToFitWidth:(CGFloat)width;
- (CGSize)labelSizeToFitHeight:(CGFloat)height;
- (CGSize)labelSizeToFit:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END

