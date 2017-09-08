//
//  DJSingleLineView.h
//  DJkit
//
//  Created by DennisDeng on 15/9/03.
//  Copyright (c) 2015年 DennisDeng. All rights reserved.
//

#import "DJSingleLineView.h"
#import "UIView+Size.h"

//#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
//#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define SINGLE_LINE_LINELENGTH      5.0f
#define SINGLE_LINE_LINESPACING     5.0f

@interface DJSingleLineView ()

@property (nonatomic, strong) CAShapeLayer *shapeDashLayer;

@end

@implementation DJSingleLineView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithFrame:CGRectMake(15.0f, 0, UI_SCREEN_WIDTH-30.0f, 2) direction:SingleLineDirectionLandscape];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame direction:SingleLineDirectionLandscape];
}

- (instancetype)initWithFrame:(CGRect)frame direction:(DJSingleLineDirection)direction
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _lineDirection = direction;
        _lineColor = [UIColor lightGrayColor];
        _lineWidth = SINGLE_LINE_WIDTH;
        _needGap = YES;
        _lineGap = 1.0f-SINGLE_LINE_WIDTH;
        _isDash = NO;
        _lineLength = SINGLE_LINE_LINELENGTH;
        _lineSpacing = SINGLE_LINE_LINESPACING;
    }
    
    return self;
}

- (void)setLineDirection:(DJSingleLineDirection)alineDirection
{
    _lineDirection = alineDirection;
    
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)alineColor
{
    _lineColor = alineColor;
    
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)alineWidth
{
    if (alineWidth < SINGLE_LINE_WIDTH)
    {
        alineWidth = SINGLE_LINE_WIDTH;
    }
    _lineWidth = alineWidth;
    
    [self setNeedsDisplay];
}

- (void)setNeedGap:(BOOL)aneedGap
{
    _needGap = aneedGap;
    
    [self setNeedsDisplay];
}

- (void)setLineGap:(CGFloat)alineGap
{
    if (alineGap < 1.0f-SINGLE_LINE_WIDTH)
    {
        alineGap = 1.0f-SINGLE_LINE_WIDTH;
    }
    _lineGap = alineGap;
    
    [self setNeedsDisplay];
}

- (void)setLineLength:(CGFloat)alineLength
{
    if (alineLength < 1.0f)
    {
        alineLength = 1.0f;
    }
    _lineLength = alineLength;
    
    [self setNeedsDisplay];
}

- (void)setLineSpacing:(CGFloat)alineSpacing
{
    if (alineSpacing < 1.0f)
    {
        alineSpacing = 1.0f;
    }
    _lineSpacing = alineSpacing;
    
    [self setNeedsDisplay];
}

- (void)setIsDash:(BOOL)aisDash
{
    if (aisDash != _isDash)
    {
        _isDash = aisDash;
        
        [self setNeedsDisplay];
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    [super drawLayer:layer inContext:ctx];
    
    if (!self.isDash)
    {
        return;
    }
    
    if (self.shapeDashLayer)
    {
        [self.shapeDashLayer removeFromSuperlayer];
        self.shapeDashLayer = nil;
    }

    self.shapeDashLayer = [CAShapeLayer layer];
    
    [self.shapeDashLayer setBounds:self.bounds];
    
    [self.shapeDashLayer setPosition:CGPointMake(self.width*0.5, 0)];
    
    [self.shapeDashLayer setFillColor:[UIColor clearColor].CGColor];
    // 设置虚线颜色为blackColor
    [self.shapeDashLayer setStrokeColor:self.lineColor.CGColor];
    // 设置虚线宽度
    [self.shapeDashLayer setLineWidth:self.lineWidth];
    [self.shapeDashLayer setLineJoin:kCALineJoinRound];
    // 设置线宽，线间距
    [self.shapeDashLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:self.lineLength], [NSNumber numberWithFloat:self.lineSpacing], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    if (self.lineDirection == SingleLineDirectionLandscape)
    {
        if (self.needGap)
        {
            if (self.lineGap + self.lineWidth <= self.bounds.size.height)
            {
                CGFloat xPos = 0;
                CGFloat yPos = self.lineGap;
                CGPathMoveToPoint(path, NULL, xPos, yPos);
                CGPathAddLineToPoint(path, NULL, self.bounds.size.width, yPos);
            }
        }
        else
        {
            if (self.lineWidth <= self.bounds.size.height)
            {
                CGFloat xPos = 0;
                CGFloat yPos = 0;
                CGPathMoveToPoint(path, NULL, xPos, yPos);
                CGPathAddLineToPoint(path, NULL, self.bounds.size.width, yPos);
            }
        }
    }
    else
    {
        if (self.needGap)
        {
            if (self.lineGap + self.lineWidth <= self.bounds.size.width)
            {
                CGFloat xPos = self.lineGap;
                CGFloat yPos = 0;
                CGPathMoveToPoint(path, NULL, xPos, yPos);
                CGPathAddLineToPoint(path, NULL, xPos, self.bounds.size.height);
            }
        }
        else
        {
            if (self.lineWidth <= self.bounds.size.width)
            {
                CGFloat xPos = 0;
                CGFloat yPos = 0;
                CGPathMoveToPoint(path, NULL, xPos, yPos);
                CGPathAddLineToPoint(path, NULL, xPos, self.bounds.size.height);
            }
        }
    }
    [self.shapeDashLayer setPath:path];
    CGPathRelease(path);
    // 把绘制好的虚线添加上来
    [layer addSublayer:self.shapeDashLayer];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.isDash)
    {
        return;
    }
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
//    CGFloat pixelAdjustOffset = 0;
//    if (((int)(self.lineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
//        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
//    }
    
    if (self.lineDirection == SingleLineDirectionLandscape)
    {
        if (self.needGap)
        {
            if (self.lineGap + self.lineWidth <= self.bounds.size.height)
            {
                CGFloat xPos = 0;
                CGFloat yPos = self.lineGap;
                CGContextMoveToPoint(context, xPos, yPos);
                CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
            }
        }
        else
        {
            if (self.lineWidth <= self.bounds.size.height)
            {
                CGFloat xPos = 0;
                CGFloat yPos = 0;
                CGContextMoveToPoint(context, xPos, yPos);
                CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
            }
        }
    }
    else if (self.lineDirection == SingleLineDirectionPortait)
    {
        if (self.needGap)
        {
            if (self.lineGap + self.lineWidth <= self.bounds.size.width)
            {
                CGFloat xPos = self.lineGap;
                CGFloat yPos = 0;
                CGContextMoveToPoint(context, xPos, yPos);
                CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
            }
        }
        else
        {
            if (self.lineWidth <= self.bounds.size.width)
            {
                CGFloat xPos = 0;
                CGFloat yPos = 0;
                CGContextMoveToPoint(context, xPos, yPos);
                CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
            }
        }
    }
    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextStrokePath(context);
}

@end
