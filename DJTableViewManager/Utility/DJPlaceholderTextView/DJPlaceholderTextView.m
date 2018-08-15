//
//  DJPlaceholderTextView.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/19.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJPlaceholderTextView.h"
#import "UILabel+Category.h"

#define DefaultMaxAutoHeight        80.0f
#define DefaultMinAutoHeight        20.0f
#define PlaceholderLabel_Offset     4.0f

@interface DJPlaceholderTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation DJPlaceholderTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        [self makePlaceholderLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self makePlaceholderLabel];
    }
    return self;
}

- (void)makePlaceholderLabel
{
    self.placeholder = @"";
    self.placeholderColor = [UIColor lightGrayColor];
    self.placeholderLineBreakMode = NSLineBreakByTruncatingTail;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    self.placeholderLabel = [[UILabel alloc] init];
    //self.placeholderLabel.font = self.font;
    self.placeholderLabel.font = [UIFont systemFontOfSize:12.0f];
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.placeholderLabel];
    
    self.autoHeight = NO;
    self.minAutoHeight = DefaultMinAutoHeight;
    self.maxAutoHeight = DefaultMaxAutoHeight;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setAttributePlaceholder:(NSAttributedString *)attributePlaceholder
{
    _attributePlaceholder = attributePlaceholder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderLineBreakMode:(NSLineBreakMode)placeholderLineBreakMode
{
    _placeholderLineBreakMode = placeholderLineBreakMode;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.minAutoHeight < frame.size.height)
    {
        self.minAutoHeight = frame.size.height;
    }

    if (self.maxAutoHeight < frame.size.height)
    {
        self.maxAutoHeight = frame.size.height;
    }
}

- (void)setMinAutoHeight:(CGFloat)minAutoHeight
{
    if (minAutoHeight < self.frame.size.height)
    {
        minAutoHeight = self.frame.size.height;
    }
    
    _minAutoHeight = minAutoHeight;
}

- (void)setMaxAutoHeight:(CGFloat)maxAutoHeight
{
    if (maxAutoHeight < self.frame.size.height)
    {
        maxAutoHeight = self.frame.size.height;
    }
    
    _maxAutoHeight = maxAutoHeight;
}

- (void)textChanged:(NSNotification *)notification
{
    if (self.autoHeight && self.hasText)
    {
        // 计算高度
        NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        
        if (currentHeight < self.minAutoHeight)
        {
            currentHeight = self.minAutoHeight;
        }
        else if (currentHeight > self.maxAutoHeight)
        {
            currentHeight = self.maxAutoHeight;
        }
        
        CGRect frame = self.frame;
        frame.size.height = currentHeight;
        self.frame = frame;
    }
    
    if (self.placeholder.length == 0)
    {
        return;
    }

    if (self.hasText != self.placeholderLabel.hidden)
    {
        self.placeholderLabel.hidden = self.hasText;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.placeholderLabel.hidden = self.hasText;
    if (!self.placeholderLabel.hidden)
    {
        if (self.font)
        {
            self.placeholderLabel.font = self.font;
        }
        else
        {
            self.placeholderLabel.font = [UIFont systemFontOfSize:12.0f];
        }
        self.placeholderLabel.lineBreakMode = self.placeholderLineBreakMode;
        self.placeholderLabel.textColor = self.placeholderColor;
        self.placeholderLabel.textAlignment = self.textAlignment;
        if (self.attributePlaceholder)
        {
            self.placeholderLabel.attributedText = self.attributePlaceholder;
        }
        else
        {
            self.placeholderLabel.text = self.placeholder;
        }

        // 边距
        CGFloat lineFragmentPadding =  self.textContainer.lineFragmentPadding;
        // self.contentInset
        UIEdgeInsets edgeInsets = self.textContainerInset;
        edgeInsets = UIEdgeInsetsMake(edgeInsets.top, edgeInsets.left+lineFragmentPadding, edgeInsets.bottom, edgeInsets.right+lineFragmentPadding);
        CGFloat width = self.frame.size.width - edgeInsets.left - edgeInsets.right;
        CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
        CGFloat height = [self.placeholderLabel sizeThatFits:maxSize].height;
        CGFloat maxHeight = self.frame.size.height - edgeInsets.top - edgeInsets.bottom;
        if (height>maxHeight)
        {
            height = maxHeight;
        }
        CGRect frame = CGRectMake(edgeInsets.left, edgeInsets.top, width, height);
        self.placeholderLabel.frame = frame;
    }
    
    [super drawRect:rect];
}


@end
