//
//  DJStepperInputItem.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/8/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJStepperInputItem.h"

#define DefaultNumberColor          [UIColor blackColor]
#define DefaultNumberFont           [UIFont systemFontOfSize:16.0f]
#define DefaultBorderColor          [UIColor clearColor]
#define DefaultBorderWidth          1.0f

@implementation DJStepperInputItem

+ (instancetype)itemWithTitle:(nullable NSString *)title numberValue:(NSDecimalNumber *)numberValue
{
    return [[self alloc] initWithTitle:title numberValue:numberValue stepperInputValueChangeHandler:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue stepperInputValueChangeHandler:(stepperInputValueChangeHandler)valueChangeHandler
{
    return [[self alloc] initWithTitle:title numberValue:numberValue stepperInputValueChangeHandler:valueChangeHandler];
}

- (instancetype)initWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue
{
    return [self initWithTitle:title numberValue:numberValue stepperInputValueChangeHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title numberValue:(NSDecimalNumber *)numberValue stepperInputValueChangeHandler:(stepperInputValueChangeHandler)valueChangeHandler
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    //self.isShowSelectBg = NO;
    self.isShowHighlightBg = NO;
    
    self.title = title;

    // 当前值， 默认值0
    if (numberValue)
    {
        self.numberValue = numberValue;
    }
    else
    {
        self.numberValue = [NSDecimalNumber zero];
    }
    
    // 是否可编辑数字， 默认值YES
    self.stepperable = YES;
    self.valueChangeHandler = valueChangeHandler;
    
    // 控件尺寸
    self.stepperInputSize = CGSizeMake(150.0f, 30.0f);
    
    // 最大值， 默认值无穷大
    self.maxNumberValue = [NSDecimalNumber maximumDecimalNumber];
    // 最小值， 默认值0
    self.minNumberValue = [NSDecimalNumber zero];
    // 递增步长，默认步长为1
    self.stepNumberValue = [NSDecimalNumber one];

    // 是否可以使用键盘输入，默认YES
    self.useKeyBord = YES;
    
    // 数字颜色
    self.numberColor = DefaultNumberColor;
    // 数字字体
    self.numberFont = DefaultNumberFont;

    // 边框颜色， 默认值透明
    self.borderColor = DefaultBorderColor;
    // 边框线宽， 默认值1
    self.borderWidth = DefaultBorderWidth;

    // 加按钮背景图片
    self.increaseImage = [UIImage imageNamed:@"increase_baiduwaimai"];
    // 减按钮背景图片
    self.decreaseImage = [UIImage imageNamed:@"decrease_baiduwaimai"];
    
    // 长按加减的触发时间间隔,默认0.2s
    self.longPressSpaceTime = 0.2f;
    
    // 第一阶段加速倍数，默认1，加速值为firstMultiple*stepNumberValue
    self.firstMultiple = 1;
    // 开始第二阶段加速倍数计数点，默认10
    self.secondTimeCount = 10;
    // 第二阶段加速倍数，默认10，一般大于firstMultiple
    self.secondMultiple = 10;
    
    // 最小值时隐藏减号按钮，默认NO
    self.minHideDecrease = NO;
    // 是否开启抖动动画，默认NO
    self.limitShakeAnimation = NO;

    return self;
}

@end
