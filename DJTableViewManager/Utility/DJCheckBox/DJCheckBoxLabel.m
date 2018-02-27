//
//  DJCheckBoxLabel.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/9.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJCheckBoxLabel.h"
#import "UIView+Size.h"
#import "UIColor+Category.h"

#define DJCheckboxDefaultGap 6.0f

@interface DJCheckBoxLabel ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@interface DJCheckBox ()

- (void)placeCheckBoxView;

@end

@implementation DJCheckBoxLabel

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, DJCheckboxDefaultWidth, DJCheckboxDefaultWidth)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame checkWidth:DJCheckboxDefaultWidth];
}

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth
{
    return [self initWithFrame:frame checkWidth:checkWidth useGesture:NO];
}

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth useGesture:(BOOL)useGesture
{
    return [self initWithFrame:frame checkWidth:checkWidth labelText:nil useGesture:NO];
}

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth labelText:(nullable NSString *)labelText useGesture:(BOOL)useGesture
{
    return [self initWithFrame:frame checkWidth:checkWidth labelText:labelText checkBoxGap:DJCheckboxDefaultGap useGesture:NO];
}

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth labelText:(NSString *)labelText checkBoxGap:(CGFloat)checkBoxGap useGesture:(BOOL)useGesture
{
    self = [super initWithFrame:frame checkWidth:checkWidth useGesture:useGesture];
    if (self)
    {
        [self setupTextLabel];
        
        self.checkBoxGap = checkBoxGap;
        self.labelText = labelText;
        
        self.labelTextCheckedColor = [UIColor blackColor];
        self.labelTextUnCheckedColor = [UIColor blackColor];
        self.labelTextMixedColor = [UIColor blackColor];
        
        self.labelTextAlignment = NSTextAlignmentLeft;
        self.labelTextFont = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

- (void)setupTextLabel
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    NSLog(@"textLabel11: %@", NSStringFromCGRect(self.textLabel.bounds));
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    textLabel.adjustsFontSizeToFitWidth = YES;
    textLabel.minimumScaleFactor = 0.5f;
    self.textLabel = textLabel;
    [self addSubview:textLabel];
}

- (void)setCheckState:(DJCheckBoxState)checkState
{
    [super setCheckState:checkState];
    
    self.textLabel.textColor = self.labelTextColor;
    if (self.labelAttrText)
    {
        self.textLabel.attributedText = self.labelAttrText;
    }
}

- (void)placeCheckBoxView
{
    [super placeCheckBoxView];
    
    self.textLabel.frame = self.bounds;
    self.textLabel.width = self.width-self.checkWidth-self.checkBoxGap;
    
    switch (self.horizontallyType)
    {
        case DJCheckBoxHorizontallyType_Left:
            self.textLabel.left = self.checkWidth+self.checkBoxGap;
            break;
            
        case DJCheckBoxHorizontallyType_Right:
            self.textLabel.left = 0;
            break;
            
        default:
            self.textLabel.left = self.checkWidth+self.checkBoxGap;
            break;
    }
 }

- (void)setCheckBoxGap:(CGFloat)checkBoxGap
{
    if (checkBoxGap < 0)
    {
        checkBoxGap = 0;
    }
    
    _checkBoxGap = checkBoxGap;
    
    [self placeCheckBoxView];
}

- (void)setLabelText:(NSString *)labelText
{
    _labelText = labelText;
    
    self.labelUnCheckedAttrText = nil;
    self.labelCheckedAttrText = nil;
    self.labelMixedAttrText = nil;
    self.textLabel.text = labelText;
}

- (void)setLabelUnCheckedAttrText:(NSAttributedString *)labelUnCheckedAttrText
{
    _labelUnCheckedAttrText = labelUnCheckedAttrText;
    if (self.checkState == DJCheckBoxState_UnChecked)
    {
        self.textLabel.attributedText = labelUnCheckedAttrText;
    }
}

- (void)setLabelCheckedAttrText:(NSAttributedString *)labelCheckedAttrText
{
    _labelCheckedAttrText = labelCheckedAttrText;
    if (self.checkState == DJCheckBoxState_Checked)
    {
        self.textLabel.attributedText = labelCheckedAttrText;
    }
}

- (void)setLabelMixedAttrText:(NSAttributedString *)labelMixedAttrText
{
    _labelMixedAttrText = labelMixedAttrText;
    if (self.checkState == DJCheckBoxState_Mixed)
    {
        self.textLabel.attributedText = labelMixedAttrText;
    }
}

- (NSAttributedString *)labelAttrText
{
    switch (self.checkState)
    {
        case DJCheckBoxState_UnChecked:
            return self.labelUnCheckedAttrText;
            
        case DJCheckBoxState_Checked:
            return self.labelCheckedAttrText;
            
        case DJCheckBoxState_Mixed:
            return self.labelMixedAttrText;
            
        default:
            return self.labelUnCheckedAttrText;
    }
}

- (void)setLabelTextAlignment:(NSTextAlignment)labelTextAlignment
{
    _labelTextAlignment = labelTextAlignment;
    self.textLabel.textAlignment = labelTextAlignment;
}

- (void)setLabelTextFont:(UIFont *)labelTextFont
{
    _labelTextFont = labelTextFont;
    self.textLabel.font = labelTextFont;
}

- (void)setLabelTextUnCheckedColor:(UIColor *)labelTextUnCheckedColor
{
    _labelTextUnCheckedColor = labelTextUnCheckedColor;
    if (self.checkState == DJCheckBoxState_UnChecked)
    {
        self.textLabel.textColor = labelTextUnCheckedColor;
    }
}

- (void)setLabelTextCheckedColor:(UIColor *)labelTextCheckedColor
{
    _labelTextCheckedColor = labelTextCheckedColor;
    if (self.checkState == DJCheckBoxState_Checked)
    {
        self.textLabel.textColor = labelTextCheckedColor;
    }
}

- (void)setLabelTextMixedColor:(UIColor *)labelTextMixedColor
{
    _labelTextMixedColor = labelTextMixedColor;
    if (self.checkState == DJCheckBoxState_Mixed)
    {
        self.textLabel.textColor = labelTextMixedColor;
    }
}

- (UIColor *)labelTextColor
{
    switch (self.checkState)
    {
        case DJCheckBoxState_UnChecked:
            return self.labelTextUnCheckedColor;
            
        case DJCheckBoxState_Checked:
            return self.labelTextCheckedColor;
            
        case DJCheckBoxState_Mixed:
            return self.labelTextMixedColor;
            
        default:
            return self.labelTextUnCheckedColor;
    }
}

@end
