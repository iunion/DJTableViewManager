//
//  DJStepperInputView.h
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/8/14.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DJStepperInputViewStepStatus)
{
    DJStepperInputViewStepStatus_None,
    DJStepperInputViewStepStatus_Increase,
    DJStepperInputViewStepStatus_Decrease
};

typedef void(^DJStepperInputViewChangeBlock)(NSDecimalNumber *number, DJStepperInputViewStepStatus stepStatus);

@protocol DJStepperInputViewDelegate;

@interface DJStepperInputView : UIView

@property (nonatomic, weak) id<DJStepperInputViewDelegate> delegate;

// 当前值
@property (nonatomic, strong) NSDecimalNumber *numberValue;

// 最大值
@property (nonatomic, strong) NSDecimalNumber *maxNumberValue;
// 最小值
@property (nonatomic, strong) NSDecimalNumber *minNumberValue;
// 递增步长，默认步长为1
@property (nonatomic, strong) NSDecimalNumber *stepNumberValue;

// 是否可以使用键盘输入，默认YES
@property (nonatomic, assign) BOOL useKeyBord;

// 数字颜色
@property (nonatomic, strong) UIColor *numberColor;
// 数字字体
@property (nonatomic, strong) UIFont *numberFont;

// 边框颜色
@property (nonatomic, strong) UIColor *borderColor;
// 边框线宽
@property (nonatomic, assign) CGFloat borderWidth;

// 加按钮背景图片
@property (nonatomic, strong) UIImage *increaseImage;
// 减按钮背景图片
@property (nonatomic, strong) UIImage *decreaseImage;

// 长按加减的触发时间间隔,默认0.2s
@property (nonatomic, assign) CGFloat longPressSpaceTime;

// 第一阶段加速倍数，默认1，加速值为firstMultiple*stepNumberValue
@property (nonatomic, assign) NSUInteger firstMultiple;
// 开始第二阶段加速倍数计数点，默认10
@property (nonatomic, assign) NSUInteger secondTimeCount;
// 第二阶段加速倍数，默认10，一般大于firstMultiple
@property (nonatomic, assign) NSUInteger secondMultiple;

// 最小值时隐藏减号按钮，默认NO
@property (nonatomic, assign) BOOL minHideDecrease;
// 是否开启抖动动画，默认NO，minHideDecrease为YES时不执行动画
@property (nonatomic, assign) BOOL limitShakeAnimation;

@property (nonatomic, copy) DJStepperInputViewChangeBlock numberChangeBlock;

@end

@protocol DJStepperInputViewDelegate <NSObject>

@optional

- (void)stepperInputView:(DJStepperInputView *)stepperInputView changeToNumber:(NSDecimalNumber *)number stepStatus:(DJStepperInputViewStepStatus)stepStatus;

@end

NS_ASSUME_NONNULL_END
