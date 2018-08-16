//
//  DJStepperInputItem.h
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/8/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"
#import "DJStepperInputView.h"

NS_ASSUME_NONNULL_BEGIN

@class DJStepperInputItem;
typedef void (^stepperInputValueChangeHandler)(DJStepperInputItem *item, DJStepperInputViewStepStatus stepStatus);

@interface DJStepperInputItem : DJTableViewItem

// 控件尺寸
@property (nonatomic, assign) CGSize stepperInputSize;

// 是否可编辑数字， 默认值YES
@property(nonatomic, assign) BOOL stepperable;

// 当前值， 默认值0
@property (nonatomic, strong) NSDecimalNumber *numberValue;

// 最大值， 默认值无穷大
@property (nonatomic, strong) NSDecimalNumber *maxNumberValue;
// 最小值， 默认值0
@property (nonatomic, strong) NSDecimalNumber *minNumberValue;
// 递增步长，默认步长为1
@property (nonatomic, strong) NSDecimalNumber *stepNumberValue;

// 是否可以使用键盘输入，默认YES
@property (nonatomic, assign) BOOL useKeyBord;

// 数字颜色
@property (nonatomic, strong) UIColor *numberColor;
// 数字字体
@property (nonatomic, strong) UIFont *numberFont;

// 边框颜色， 默认值透明
@property (nonatomic, strong) UIColor *borderColor;
// 边框线宽， 默认值1
@property (nonatomic, assign) CGFloat borderWidth;

// 加按钮背景图片
@property (nonatomic, strong ) UIImage *increaseImage;
// 减按钮背景图片
@property (nonatomic, strong ) UIImage *decreaseImage;

// 长按加减的触发时间间隔,默认0.2s
@property (nonatomic, assign ) CGFloat longPressSpaceTime;

// 第一阶段加速倍数，默认1，加速值为firstMultiple*stepNumberValue
@property (nonatomic, assign) NSUInteger firstMultiple;
// 开始第二阶段加速倍数计数点，默认10
@property (nonatomic, assign) NSUInteger secondTimeCount;
// 第二阶段加速倍数，默认10，一般大于firstMultiple
@property (nonatomic, assign) NSUInteger secondMultiple;

// 最小值时隐藏减号按钮，默认NO
@property (nonatomic, assign) BOOL minHideDecrease;
// 是否开启抖动动画，默认NO
@property (nonatomic, assign) BOOL limitShakeAnimation;

@property (nonatomic, copy) stepperInputValueChangeHandler valueChangeHandler;

+ (instancetype)itemWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue;
+ (instancetype)itemWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue stepperInputValueChangeHandler:(nullable stepperInputValueChangeHandler)valueChangeHandler;

- (instancetype)initWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue;
- (instancetype)initWithTitle:(nullable NSString *)title numberValue:(nullable NSDecimalNumber *)numberValue stepperInputValueChangeHandler:(nullable stepperInputValueChangeHandler)valueChangeHandler;

@end

NS_ASSUME_NONNULL_END
