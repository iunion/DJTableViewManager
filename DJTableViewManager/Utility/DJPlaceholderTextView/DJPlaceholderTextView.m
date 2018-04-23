//
//  DJPlaceholderTextView.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/19.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJPlaceholderTextView.h"
#import "UILabel+Category.h"

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
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
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

- (void)textChanged:(NSNotification *)notification
{
    if (self.placeholder.length == 0)
    {
        return;
    }
    
    self.placeholderLabel.hidden = self.hasText;
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
        self.placeholderLabel.text = self.placeholder;

        // self.contentInset
        UIEdgeInsets edgeInsets = self.textContainerInset;
        edgeInsets = UIEdgeInsetsMake(edgeInsets.top, edgeInsets.left+PlaceholderLabel_Offset, edgeInsets.bottom, edgeInsets.right+PlaceholderLabel_Offset);
        CGFloat width = self.frame.size.width - edgeInsets.left - edgeInsets.right;
        CGFloat height = [self.placeholderLabel labelSizeToFitWidth:width].height;
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
