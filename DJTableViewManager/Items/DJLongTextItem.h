//
//  DJLongTextItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/20.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJInputItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJLongTextItem : DJInputItem

// Data and values
//
@property (nullable, nonatomic, copy) NSAttributedString *attributedValue;


// TextView
//
@property (nonatomic, assign) UIEdgeInsets textViewTextContainerInset;

@property (nonatomic, strong) UIColor *textViewPlaceholderColor;
@property (nonatomic, assign) NSLineBreakMode textViewPlaceholderLineBreakMode;

@property (nullable, nonatomic, strong) UIFont *textViewFont;
@property (nullable, nonatomic, strong) UIColor *textViewTextColor;
@property (nonatomic, assign) NSTextAlignment textViewTextAlignment;

@property (nonatomic, assign) NSRange textViewSelectedRange;
@property (nonatomic, assign) BOOL textViewSelectable;

// Style for links
@property (nullable, nonatomic, copy) NSDictionary<NSString *, id> *textViewLinkTextAttributes;
// automatically resets when the selection changes
@property (nonatomic, copy) NSDictionary<NSString *, id> *textViewTypingAttributes;


// UI
//
@property (nonatomic, assign) CGFloat textLabelTopGap;
@property (nonatomic, assign) CGFloat textViewTopGap;
@property (nonatomic, assign) CGFloat textViewLeftGap;

@property (nonatomic, assign) BOOL showTextViewBorder;

@end

NS_ASSUME_NONNULL_END
