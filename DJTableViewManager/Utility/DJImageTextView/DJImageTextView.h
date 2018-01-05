//
//  DJImageTextView.h
//  DJkit
//
//  Created by DennisDeng on 15/9/03.
//  Copyright (c) 2015年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DJImageTextViewType)
{
    DJImageTextViewType_ImageLeft,
    DJImageTextViewType_ImageRight
};

#define DJImageTextView_DefaultTextColor    [UIColor blackColor]


NS_ASSUME_NONNULL_BEGIN

@class DJImageTextView;

typedef void (^DJImageTextViewClicked)(DJImageTextView *imageTextView);

@interface DJImageTextView : UIView

@property (assign, nonatomic) DJImageTextViewType type;

@property (copy, nonatomic, nullable) NSString *imageName;
@property (copy, nonatomic, nullable) NSString *imageUrl;

@property (copy, nonatomic, nullable) NSString *text;
@property (copy, nonatomic, nullable) NSAttributedString *attributedText;

@property (strong, nonatomic, nullable) UIColor *textColor;
@property (strong, nonatomic, nullable) UIFont *textFont;

@property (assign, nonatomic) CGSize imageSize;

@property (assign, nonatomic) CGFloat imageTextGap;

@property (assign, nonatomic) CGFloat maxWidth;

@property (copy, nonatomic, nullable) DJImageTextViewClicked imageTextViewClicked;

@property (assign, nonatomic) BOOL adjustsFontSizeToFitWidth;


- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithText:(NSString *)text height:(CGFloat)height;
- (instancetype)initWithImage:(NSString *)image height:(CGFloat)height;
- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text height:(CGFloat)height gap:(CGFloat)gap;
- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text type:(DJImageTextViewType)type height:(CGFloat)height gap:(CGFloat)gap;
- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text type:(DJImageTextViewType)type textColor:(nullable UIColor *)textColor textFont:(nullable UIFont *)textFont height:(CGFloat)height gap:(CGFloat)gap;
- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text type:(DJImageTextViewType)type textColor:(nullable UIColor *)textColor textFont:(nullable UIFont *)textFont height:(CGFloat)height gap:(CGFloat)gap clicked:(nullable DJImageTextViewClicked)clicked;

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText;
- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText height:(CGFloat)height;
- (instancetype)initWithAttributedText:(nullable NSAttributedString *)attributedText image:(nullable NSString *)image;
- (instancetype)initWithAttributedText:(nullable NSAttributedString *)attributedText image:(nullable NSString *)image gap:(CGFloat)gap;
- (instancetype)initWithImage:(nullable NSString *)image attributedText:(nullable NSAttributedString *)attributedText height:(CGFloat)height gap:(CGFloat)gap;
- (instancetype)initWithImage:(nullable NSString *)image attributedText:(nullable NSAttributedString *)attributedText type:(DJImageTextViewType)type height:(CGFloat)height gap:(CGFloat)gap;
- (instancetype)initWithImage:(nullable NSString *)image attributedText:(nullable NSAttributedString *)attributedText type:(DJImageTextViewType)type height:(CGFloat)height gap:(CGFloat)gap clicked:(nullable DJImageTextViewClicked)clicked;

@end

NS_ASSUME_NONNULL_END
