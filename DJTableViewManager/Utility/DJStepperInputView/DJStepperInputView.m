//
//  DJStepperInputView.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/8/14.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJStepperInputView.h"
#import "NSNumber+Category.h"
#import "NSDecimalNumber+Category.h"
#import "UIView+Size.h"

#define LongPressDefaultStartTime   1.0f

#define DefaultNumberColor          [UIColor blackColor]
#define DefaultNumberFont           [UIFont systemFontOfSize:16.0f]
#define DefaultBorderColor          [UIColor grayColor]
#define DefaultBorderWidth          1.0f

@interface DJStepperInputView ()
<
    UITextFieldDelegate
>
{
    UIButton *_clickBtn;
    NSUInteger _longTimeCount;
    
    DJStepperInputViewStepStatus _stepStatus;
}

// 长按加减的启动时间间隔
@property (nonatomic, assign ) CGFloat longPressStartTime;

// 快速加减定时器
@property (nonatomic, strong) NSTimer *longPressTimer;
// 减按钮
@property (nonatomic, strong) UIButton *decreaseBtn;
// 加按钮
@property (nonatomic, strong) UIButton *increaseBtn;
// 数量展示/输入框
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) CGFloat firstFloatMultiple;
@property (nonatomic, assign) CGFloat secondFloatMultiple;

@end

@implementation DJStepperInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self makeView];
        
        self.frame = frame;
    }
    return self;
}

- (void)makeView
{
    _minNumberValue = [NSDecimalNumber zero];
    _maxNumberValue = [NSDecimalNumber maximumDecimalNumber];
    
    _stepNumberValue = [NSDecimalNumber one];
    
    // 加,减按钮
    _increaseBtn = [self creatButton];
    _decreaseBtn = [self creatButton];

    // 数量展示/输入框
    _textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textField];

    self.useKeyBord = YES;
    
    _clickBtn = nil;
    _stepStatus = DJStepperInputViewStepStatus_None;
    
    self.numberColor = DefaultNumberColor;
    self.numberFont = DefaultNumberFont;
    
    self.borderColor = DefaultBorderColor;
    self.borderWidth = DefaultBorderWidth;
    
    self.increaseImage = [UIImage imageNamed:@"plus_icon"];
    self.decreaseImage = [UIImage imageNamed:@"minus_icon"];
    
    self.longPressSpaceTime = 0.2f;
    self.firstMultiple = 1;
    self.secondTimeCount = 10;
    self.secondMultiple = 10;
    
    self.minHideDecrease = NO;
    self.limitShakeAnimation = NO;

    self.clipsToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    self.backgroundColor = [UIColor clearColor];
}

- (UIButton *)creatButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    // button点击事件
    [button addTarget:self action:@selector(btnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    // button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongClick:)];
     // 长按等待时间
    longPress.minimumPressDuration = LongPressDefaultStartTime;
    [button addGestureRecognizer:longPress];
    button.exclusiveTouch = YES;
    [self addSubview:button];
    return button;
}

- (void)btnTouchDown:(UIButton *)btn
{
    [self.textField resignFirstResponder];

    _clickBtn = btn;
    
    if (btn == self.increaseBtn)
    {
        _stepStatus = DJStepperInputViewStepStatus_Increase;
    }
    else if (btn == self.decreaseBtn)
    {
        _stepStatus = DJStepperInputViewStepStatus_Decrease;
    }
    else
    {
        _stepStatus = DJStepperInputViewStepStatus_None;
    }
}

- (void)btnShortClick:(UIButton *)btn
{
    NSDecimalNumber *number = [NSDecimalNumber zero];
    NSDecimalNumber *multiple = [NSDecimalNumber decimalNumberWithInteger:self.firstMultiple];
    if (_longTimeCount >= self.secondTimeCount)
    {
        multiple = [NSDecimalNumber decimalNumberWithInteger:self.secondMultiple];
    }
    
    if (btn == self.increaseBtn)
    {
        number = [self.numberValue decimalNumberByAdding:[self.stepNumberValue decimalNumberByMultiplyingBy:multiple]];
    }
    else if (btn == self.decreaseBtn)
    {
        number = [self.numberValue decimalNumberBySubtracting:[self.stepNumberValue decimalNumberByMultiplyingBy:multiple]];
    }
    
    self.numberValue = number;
    
    //_stepStatus = DJStepperInputViewStepStatus_None;
}

-(void)btnLongClick:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        self.longPressTimer = [NSTimer timerWithTimeInterval:self.longPressSpaceTime target:self selector:@selector(btnLongTime:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.longPressTimer forMode:NSRunLoopCommonModes];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateFailed)
    {
        _clickBtn = nil;
        [self stopLongPressTimer];
    }
}

- (void)stopLongPressTimer
{
    _longTimeCount = 0;
    _stepStatus = DJStepperInputViewStepStatus_None;

    if (self.longPressTimer.valid)
    {
        [self.longPressTimer invalidate];
        self.longPressTimer = nil;
    }
}

- (void)btnLongTime:(NSTimer *)theTimer
{
    [self btnShortClick:_clickBtn];
    _longTimeCount++;
}

- (void)textFieldDidChanged:(UITextField *)textField
{
    _stepStatus = DJStepperInputViewStepStatus_None;
    
    if (textField.text.length > 0)
    {
        NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:textField.text];
        self.numberValue = num;
    }
    else
    {
        self.numberValue = self.minNumberValue;
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.textField.frame = CGRectMake(self.height, 0, self.width - 2*self.height, self.height);
    self.increaseBtn.frame = CGRectMake(self.width - self.height, 0, self.height, self.height);
    self.decreaseBtn.frame = CGRectMake(0, 0, self.height, self.height);
}

- (void)setMinHideDecrease:(BOOL)minHideDecrease
{
    _minHideDecrease = minHideDecrease;
    
    if (minHideDecrease)
    {
        if ([self.numberValue compare:self.minNumberValue] != NSOrderedDescending)
        {
            self.textField.hidden = YES;
            self.decreaseBtn.alpha = 0;
            self.decreaseBtn.left = self.width-self.height;
        }
        else
        {
            self.textField.hidden = NO;
            self.decreaseBtn.alpha = 1.0f;
            self.decreaseBtn.left = 0;
        }
    }
}

- (NSDecimalNumber *)numberValue
{
    if (self.textField.text.length > 0)
    {
        NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:self.textField.text];
        return num;
    }
    
    return self.minNumberValue;
}

- (void)setNumberValue:(NSDecimalNumber *)numberValue
{
    if (!numberValue)
    {
        return;
    }
    
    BOOL hiddeDecreaseBtn = NO;
    if (self.minHideDecrease)
    {
        if ([numberValue compare:self.minNumberValue] != NSOrderedDescending && !self.textField.hidden)
        {
            hiddeDecreaseBtn = YES;
            self.textField.hidden = YES;
            [self rotationAnimationMethod];
            [UIView animateWithDuration:0.25f animations:^{
                self.decreaseBtn.alpha = 0;
                self.decreaseBtn.left = self.width-self.height;
            }];
        }
        else if ([numberValue compare:self.minNumberValue] == NSOrderedDescending && self.textField.hidden)
        {
            self.textField.hidden = NO;
            [self rotationAnimationMethod];
            [UIView animateWithDuration:0.25f animations:^{
                self.decreaseBtn.alpha = 1.0f;
                self.decreaseBtn.left = 0;
            }];
        }
    }
    
    DJStepperInputViewStepStatus backStepStatus = _stepStatus;
    if ([numberValue compare:self.minNumberValue] == NSOrderedAscending)
    {
        numberValue = self.minNumberValue;
        
        [self stopLongPressTimer];
        
        if (self.limitShakeAnimation && !hiddeDecreaseBtn)
        {
            [self shakeAnimationMethod];
        }
    }
    else if ([numberValue compare:self.maxNumberValue] == NSOrderedDescending)
    {
        numberValue = self.maxNumberValue;

        [self stopLongPressTimer];
        
        if (self.limitShakeAnimation)
        {
            [self shakeAnimationMethod];
        }
    }

    self.textField.text = [numberValue stringWithNoStyleDecimalNozeroScale:2];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(stepperInputView:changeToNumber:stepStatus:)])
    {
        [self.delegate stepperInputView:self changeToNumber:numberValue stepStatus:backStepStatus];
    }
    if (self.numberChangeBlock)
    {
        self.numberChangeBlock(numberValue, backStepStatus);
    }
}

- (void)setMinNumberValue:(NSDecimalNumber *)minNumberValue
{
    if (!minNumberValue)
    {
        return;
    }
    
    if ([minNumberValue isEqualToNumber:_minNumberValue])
    {
        return;
    }
    
    if (self.maxNumberValue)
    {
        if ([minNumberValue compare:self.maxNumberValue] == NSOrderedDescending)
        {
            minNumberValue = self.maxNumberValue;
        }
    }
    
    _minNumberValue = minNumberValue;
    
    if ([self.numberValue compare:minNumberValue] == NSOrderedAscending)
    {
        self.numberValue = minNumberValue;
    }
}

- (void)setMaxNumberValue:(NSDecimalNumber *)maxNumberValue
{
    if (!maxNumberValue)
    {
        return;
    }
    
    if ([maxNumberValue isEqualToNumber:_maxNumberValue])
    {
        return;
    }
    
    if (self.minNumberValue)
    {
        if ([maxNumberValue compare:self.minNumberValue] == NSOrderedAscending)
        {
            maxNumberValue = self.minNumberValue;
        }
    }
    
    _maxNumberValue = maxNumberValue;
    
    if ([self.numberValue compare:maxNumberValue] == NSOrderedDescending)
    {
        self.numberValue = maxNumberValue;
    }
}

- (void)setStepNumberValue:(NSDecimalNumber *)stepNumberValue
{
    if (!stepNumberValue)
    {
        return;
    }
    
    _stepNumberValue = stepNumberValue;
}

- (void)setUseKeyBord:(BOOL)useKeyBord
{
    _useKeyBord = useKeyBord;
    self.textField.userInteractionEnabled = useKeyBord;
}

- (void)setFirstMultiple:(NSUInteger)firstMultiple
{
    _firstMultiple = firstMultiple;
    self.firstFloatMultiple = firstMultiple;
}

- (void)setSecondMultiple:(NSUInteger)secondMultiple
{
    _secondMultiple = secondMultiple;
    self.secondFloatMultiple = secondMultiple;
}

- (void)setNumberColor:(UIColor *)numberColor
{
    if (!numberColor)
    {
        return;
    }

    _numberColor = numberColor;
    self.textField.textColor = numberColor;
}

- (void)setNumberFont:(UIFont *)numberFont
{
    if (!numberFont)
    {
        return;
    }
    
    _numberFont = numberFont;
    self.textField.font = numberFont;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (!borderColor)
    {
        borderColor = [UIColor clearColor];
        return;
    }
    
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;

    self.increaseBtn.layer.borderColor = borderColor.CGColor;
    self.decreaseBtn.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;

    self.increaseBtn.layer.borderWidth = borderWidth;
    self.decreaseBtn.layer.borderWidth = borderWidth;
}

- (void)setIncreaseImage:(UIImage *)increaseImage
{
    if (!increaseImage)
    {
        return;
    }

    _increaseImage = increaseImage;
    [self.increaseBtn setBackgroundImage:increaseImage forState:UIControlStateNormal];
}

- (void)setDecreaseImage:(UIImage *)decreaseImage
{
    if (!decreaseImage)
    {
        return;
    }
    
    _decreaseImage = decreaseImage;
    [self.decreaseBtn setBackgroundImage:decreaseImage forState:UIControlStateNormal];
}

- (void)setLongPressSpaceTime:(CGFloat)longPressSpaceTime
{
    if (longPressSpaceTime < 0.1)
    {
        longPressSpaceTime = 0.1;
    }
    
    _longPressSpaceTime = longPressSpaceTime;
}

#pragma mark - 核心动画

// 抖动动画
- (void)shakeAnimationMethod
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = self.layer.position.x;
    animation.values = @[@(positionX-10),@(positionX),@(positionX+10)];
    animation.repeatCount = 3;
    animation.duration = 0.07;
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:nil];
}

// 旋转动画
- (void)rotationAnimationMethod
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = @(M_PI*2);
    rotationAnimation.duration = 0.3f;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = YES;
    [self.decreaseBtn.layer addAnimation:rotationAnimation forKey:nil];
}

@end
