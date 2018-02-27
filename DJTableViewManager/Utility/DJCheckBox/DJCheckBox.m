//
//  DJCheckBox.m
//  DJkit
//
//  Created by DennisDeng on 18/1/31.
//  Copyright (c) 2018年 DennisDeng. All rights reserved.
//

#import "DJCheckBox.h"
#import "UIView+Size.h"
#import "UIColor+Category.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface DJCheckBoxView : UIView

@property (nonatomic, weak) DJCheckBox *checkBox;
@property (nonatomic, assign) BOOL highlighted;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) CAShapeLayer *boxLayer;
@property (nonatomic, strong) CAShapeLayer *markLayer;

@end

@implementation DJCheckBoxView

- (void)clearUI
{
    [self.textLabel removeFromSuperview];
    [self.boxLayer removeFromSuperlayer];
    [self.markLayer removeFromSuperlayer];
}

- (void)drawText
{
    [self.textLabel removeFromSuperview];
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.userInteractionEnabled = NO;
    self.textLabel.text = self.checkBox.boxText;
    if (self.checkBox.enabled)
    {
        self.textLabel.textColor = self.checkBox.boxTextColor;
    }
    else
    {
        self.textLabel.textColor = [self.checkBox.boxTextColor disableColor];
    }
    self.textLabel.highlightedTextColor = [self.checkBox.boxTextColor colorByLighteningTo:0.5];
    self.textLabel.highlighted = self.highlighted;
    self.textLabel.font = self.checkBox.boxTextFont;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.minimumScaleFactor = 0.5f;
    
    [self addSubview:self.textLabel];
}

- (void)drawCheckBox
{
    [self.boxLayer removeFromSuperlayer];
    self.boxLayer = [CAShapeLayer layer];
    self.boxLayer.frame = self.bounds;
    if (self.checkBox.boxShapeBlock)
    {
        self.boxLayer.path = self.checkBox.boxShapeBlock(self.checkBox).CGPath;
    }
    else
    {
        self.boxLayer.path = [self.checkBox getDefaultBoxShape].CGPath;
    }

    if (self.checkBox.isBoxFill)
    {
        if (self.checkBox.enabled)
        {
            self.boxLayer.fillColor = self.checkBox.boxFillColor.CGColor;
        }
        else
        {
            self.boxLayer.fillColor = [self.checkBox.boxFillColor disableColor].CGColor;
        }
    }
    else
    {
        self.boxLayer.fillColor = [UIColor clearColor].CGColor;
    }
    if (self.highlighted)
    {
        self.boxLayer.strokeColor = [self.checkBox.boxStrokeColor colorByLighteningTo:0.5].CGColor;
    }
    else
    {
        if (self.checkBox.enabled)
        {
            self.boxLayer.strokeColor = self.checkBox.boxStrokeColor.CGColor;
        }
        else
        {
            self.boxLayer.strokeColor = [self.checkBox.boxStrokeColor disableColor].CGColor;
        }
    }
    self.boxLayer.lineWidth = self.checkBox.boxStrokeWidth;
    self.boxLayer.rasterizationScale = 2.0 * [UIScreen mainScreen].scale;
    self.boxLayer.shouldRasterize = YES;
    
    [self.layer addSublayer:self.boxLayer];
}

- (void)drawCheckMark
{
    [self.markLayer removeFromSuperlayer];
    self.markLayer = [CAShapeLayer layer];
    self.markLayer.frame = self.bounds;
    if (self.checkBox.markShapeBlock)
    {
        self.markLayer.path = self.checkBox.markShapeBlock(self.checkBox).CGPath;
    }
    else
    {
        self.markLayer.path = [self.checkBox getDefaultMarkShape].CGPath;
    }
    
    self.markLayer.fillColor = [UIColor clearColor].CGColor;
    if (self.highlighted)
    {
        self.markLayer.strokeColor = [self.checkBox.markStrokeColor colorByLighteningTo:0.5].CGColor;
    }
    else
    {
        if (self.checkBox.enabled)
        {
            self.markLayer.strokeColor = self.checkBox.markStrokeColor.CGColor;
        }
        else
        {
            self.markLayer.strokeColor = [self.checkBox.markStrokeColor disableColor].CGColor;
        }
    }
    self.markLayer.lineCap = kCALineCapRound;
    self.markLayer.lineJoin = kCALineJoinRound;
    self.markLayer.lineWidth = self.checkBox.markStrokeWidth;
    self.markLayer.rasterizationScale = 2.0 * [UIScreen mainScreen].scale;
    self.markLayer.shouldRasterize = YES;
    
    [self.layer addSublayer:self.markLayer];
}

- (void)drawUI
{
    [self clearUI];
    
    if (self.checkBox.boxType == DJCheckBoxType_Text)
    {
        [self drawText];
    }
    else
    {
        [self drawCheckBox];
    }
    
    if (self.checkBox.checkState != DJCheckBoxState_UnChecked)
    {
        [self drawCheckMark];
    }
}

- (void)drawRect:(CGRect)rect
{
    [self drawUI];
}

@end



@interface DJCheckBox ()

@property (nonatomic, weak) DJCheckBoxGroup *group;

@property (nonatomic, assign) BOOL isUseGesture;

@property (nonatomic, strong) DJCheckBoxView *checkBoxView;

@property (nonatomic, assign) CGRect boxFrame;

@end

@implementation DJCheckBox
//@synthesize enabled = _enabled;

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
    self = [super initWithFrame:frame];
    if (self)
    {
        self.enabled = YES;
        self.isUseGesture = useGesture;
        self.checkWidth = checkWidth;
        
        if (self.checkWidth > self.width)
        {
            self.width = self.checkWidth;
        }
        if (self.checkWidth > self.height)
        {
            self.height = self.checkWidth;
        }
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    
    // checkbox 状态
    self.checkState = DJCheckBoxState_UnChecked;
    // checkbox 类型
    self.boxType = DJCheckBoxType_Square;
    
    // 文本字体
    self.boxTextFont = [UIFont systemFontOfSize:14.0f];
    // 文本颜色
    self.boxCheckedTextColor = [UIColor blackColor];
    self.boxUnCheckedTextColor = [UIColor blackColor];
    
    // 外框
    
    // 外框线宽
    self.boxStrokeWidth = 1.0f;
    // 外框颜色
    self.boxCheckedStrokeColor = [UIColor blackColor];
    self.boxUnCheckedStrokeColor = [UIColor blackColor];
    self.boxMixedStrokeColor = [UIColor blackColor];
    // 外框是否填充
    self.isBoxFill = NO;
    // 外框填充颜色
    self.boxCheckedFillColor = [UIColor clearColor];
    self.boxUnCheckedFillColor = [UIColor clearColor];
    self.boxMixedFillColor = [UIColor clearColor];
    
    // 外框圆角半径 DJCheckBoxType_Square时可用
    self.boxCornerRadius = 3.0f;
    
    // 标记
    
    // 标记线宽
    self.markStrokeWidth = 1.0f;
    // 标记颜色
    self.markCheckedStrokeColor = [UIColor blackColor];
    self.markMixedStrokeColor = [UIColor blackColor];
    
    self.checkBoxView = [[DJCheckBoxView alloc] initWithFrame:CGRectMake(0, 0, self.checkWidth, self.checkWidth)];
    self.checkBoxView.backgroundColor = [UIColor clearColor];
    self.checkBoxView.userInteractionEnabled = NO;
    [self addSubview:self.checkBoxView];
    self.checkBoxView.checkBox = self;
    //[self placeCheckBoxView];

    // checkbox 水平位置
    self.horizontallyType = DJCheckBoxHorizontallyType_Left;
    // checkbox 垂直位置
    self.verticallyType = DJCheckBoxVerticallyType_Top;
    
    if (self.isUseGesture)
    {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCheckBox:)]];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.checkBoxView.highlighted = highlighted;
    [self.checkBoxView setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];

    [self.checkBoxView setNeedsDisplay];
}

- (void)setBoxType:(DJCheckBoxType)boxType
{
    if (_boxType != boxType)
    {
        _boxType = boxType;
        [self.checkBoxView setNeedsDisplay];
    }
}

- (void)setCheckState:(DJCheckBoxState)checkState
{
    if (_checkState != checkState)
    {
        _checkState = checkState;
        [self.checkBoxView setNeedsDisplay];
    }
}

- (void)placeCheckBoxView
{
    switch (self.horizontallyType)
    {
        case DJCheckBoxHorizontallyType_Left:
            self.checkBoxView.left = 0;
            break;

        case DJCheckBoxHorizontallyType_Right:
            self.checkBoxView.right = self.width;
            break;

        default:
            self.checkBoxView.left = 0;
            break;
    }
    
    switch (self.verticallyType)
    {
        case DJCheckBoxVerticallyType_Top:
            self.checkBoxView.top = 0;
            break;
            
        case DJCheckBoxVerticallyType_Center:
            self.checkBoxView.centerY = self.height*0.5f;
            break;
            
        case DJCheckBoxVerticallyType_Bottom:
            self.checkBoxView.bottom = self.height;
            break;
            
        default:
            self.checkBoxView.top = 0;
            break;
    }
    
    self.boxFrame = self.checkBoxView.frame;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self placeCheckBoxView];
}

- (void)setHorizontallyType:(DJCheckBoxHorizontallyType)horizontallyType
{
    if (_horizontallyType != horizontallyType)
    {
        _horizontallyType = horizontallyType;
        [self placeCheckBoxView];
    }
}

- (void)setVerticallyType:(DJCheckBoxVerticallyType)verticallyType
{
    if (_verticallyType != verticallyType)
    {
        _verticallyType = verticallyType;
        [self placeCheckBoxView];
    }
}

- (void)setCheckWidth:(CGFloat)checkWidth
{
    if (checkWidth < DJCheckboxDefaultWidth)
    {
        checkWidth = DJCheckboxDefaultWidth;
    }
    
    _checkWidth = checkWidth;
    [self placeCheckBoxView];
}

- (UIColor *)boxTextColor
{
    switch (self.checkState)
    {
        case DJCheckBoxState_UnChecked:
            return self.boxUnCheckedTextColor;
            
        case DJCheckBoxState_Checked:
        case DJCheckBoxState_Mixed:
            return self.boxCheckedTextColor;
            
        default:
            return self.boxUnCheckedStrokeColor;
    }
}

- (UIColor *)boxStrokeColor
{
    switch (self.checkState)
    {
        case DJCheckBoxState_UnChecked:
            return self.boxUnCheckedStrokeColor;
            
        case DJCheckBoxState_Checked:
            return self.boxCheckedStrokeColor;

        case DJCheckBoxState_Mixed:
            return self.boxMixedStrokeColor;
        
        default:
            return self.boxUnCheckedStrokeColor;
    }
}

- (UIColor *)boxFillColor
{
    switch (self.checkState)
    {
        case DJCheckBoxState_UnChecked:
            return self.boxUnCheckedFillColor;
            
        case DJCheckBoxState_Checked:
            return self.boxCheckedFillColor;
            
        case DJCheckBoxState_Mixed:
            return self.boxMixedFillColor;
            
        default:
            return self.boxUnCheckedFillColor;
    }
}

- (UIColor *)markStrokeColor
{
    switch (self.checkState)
    {
        case DJCheckBoxState_UnChecked:
        case DJCheckBoxState_Checked:
            return self.markCheckedStrokeColor;
            
        case DJCheckBoxState_Mixed:
            return self.markMixedStrokeColor;
            
        default:
            return self.markCheckedStrokeColor;
    }
}

- (void)setCheckBoxGroup:(DJCheckBoxGroup *)group
{
    self.group = group;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    if (!self.enabled)
    {
        return NO;
    }
    
    self.alpha = 0.8f;
    
    self.checkBoxView.highlighted = YES;
    [self.checkBoxView setNeedsDisplay];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    if (!self.enabled)
    {
        return NO;
    }
    
    self.alpha = 0.8f;
    
    self.checkBoxView.highlighted = YES;
    [self.checkBoxView setNeedsDisplay];

    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event
{
    if (!self.enabled)
    {
        return;
    }
    
    self.alpha = 1.0f;
    
    self.checkBoxView.highlighted = NO;
    [self.checkBoxView setNeedsDisplay];
    
    if (!self.isUseGesture)
    {
        CGPoint location = [touch locationInView:self];
        if (CGRectContainsPoint(self.bounds, location))
        {
            [self toggleCheckState];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
    
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event
{
    if (!self.enabled)
    {
        return;
    }
    
    self.alpha = 1.0f;
    
    self.checkBoxView.highlighted = NO;
    [self.checkBoxView setNeedsDisplay];
    
    [super cancelTrackingWithEvent:event];
}

- (UIBezierPath *)getDefaultBoxShape
{
    if (self.boxType == DJCheckBoxType_Square)
    {
        UIBezierPath *boxPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.checkBoxView.bounds, self.boxStrokeWidth, self.boxStrokeWidth) cornerRadius:self.boxCornerRadius];
    
        return boxPath;
    }
    else
    {
        CGFloat radius = (self.checkWidth - self.boxStrokeWidth)*0.5;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.checkWidth*0.5, self.checkWidth*0.5)
                                          radius: radius
                                      startAngle: - M_PI / 4
                                        endAngle:  2 * M_PI - M_PI / 4
                                       clockwise:YES];
        return circlePath;
    }

}

- (UIBezierPath *)getDefaultMarkShape
{
    if (self.checkState == DJCheckBoxState_Mixed)
    {
        UIBezierPath *checkMarkPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.checkWidth*0.25, self.checkWidth*0.5 - self.markStrokeWidth*0.5, self.checkWidth*0.5, self.markStrokeWidth) cornerRadius:0.0f];
        return checkMarkPath;
    }
    else
    {
        UIBezierPath *checkMarkPath = [UIBezierPath bezierPath];
        [checkMarkPath moveToPoint: CGPointMake(3.5f*self.checkWidth/16.0f, 8.0f*self.checkWidth/16.0f)];
        [checkMarkPath addLineToPoint: CGPointMake(6.5f*self.checkWidth/16.0f, 11.0f*self.checkWidth/16.0f)];
        [checkMarkPath addLineToPoint: CGPointMake(11.5f*self.checkWidth/16.0f, 6.0f*self.checkWidth/16.0f)];
        //[checkMarkPath closePath];

        if (self.boxType != DJCheckBoxType_Circle)
        {
            // If we use a square box or text, the check mark should be a little bit bigger
            [checkMarkPath applyTransform:CGAffineTransformMakeScale(1.5, 1.5)];
            [checkMarkPath applyTransform:CGAffineTransformMakeTranslation(-self.checkWidth*0.25, -self.checkWidth*0.25)];
        }
        
        return checkMarkPath;
    }
}

- (void)toggleCheckState
{
    self.checkState = !self.checkState;
    if (self.group)
    {
        [self.group groupSelectionChangedWithCheckBox:self];
    }
    
    [self.checkBoxView setNeedsDisplay];
}

#pragma mark - Gesture Recognizer

- (void)handleTapCheckBox:(UITapGestureRecognizer *)recognizer
{
    if (UIGestureRecognizerStateBegan == recognizer.state || UIGestureRecognizerStateChanged == recognizer.state)
    {
        self.alpha = 0.8f;
        
        self.checkBoxView.highlighted = YES;
        [self.checkBoxView setNeedsDisplay];
    }
    else
    {
        self.alpha = 1.0f;
        
        self.checkBoxView.highlighted = NO;
        [self.checkBoxView setNeedsDisplay];

        if (UIGestureRecognizerStateEnded == recognizer.state)
        {
            [self toggleCheckState];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end
