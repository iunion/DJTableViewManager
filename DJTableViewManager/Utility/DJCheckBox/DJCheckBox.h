//
//  DJCheckBox.h
//  DJkit
//
//  Created by DennisDeng on 18/1/31.
//  Copyright (c) 2018年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJCheckBoxGroup.h"

#define DJCheckboxDefaultWidth 16.0f

typedef NS_ENUM(NSUInteger, DJCheckBoxState)
{
    // Default 未选中
    DJCheckBoxState_UnChecked = NO,
    // 选中
    DJCheckBoxState_Checked = YES,
    DJCheckBoxState_Mixed
};

typedef NS_ENUM(NSUInteger, DJCheckBoxType)
{
    // Default 方形
    DJCheckBoxType_Square,
    // 圆形
    DJCheckBoxType_Circle,
    // 文本
    DJCheckBoxType_Text
};

typedef NS_ENUM(NSUInteger, DJCheckBoxHorizontallyType)
{
    // Default 左
    DJCheckBoxHorizontallyType_Left = 0,
    // 右
    DJCheckBoxHorizontallyType_Right,
};

typedef NS_ENUM(NSUInteger, DJCheckBoxVerticallyType)
{
    // Default 上
    DJCheckBoxVerticallyType_Top = 0,
    // 中
    DJCheckBoxVerticallyType_Center,
    // 下
    DJCheckBoxVerticallyType_Bottom
};

NS_ASSUME_NONNULL_BEGIN

@class DJCheckBox;

typedef UIBezierPath * _Nullable (^DJCheckBoxShapeBlock)(DJCheckBox *checkBox);
typedef void (^DJCheckBoxTaped)(DJCheckBox *checkBox);

@interface DJCheckBox : UIControl

@property (nullable, nonatomic, weak, readonly) DJCheckBoxGroup *group;

#pragma mark Properties

// checkbox 状态
// Default: DJCheckBoxState_UnChecked
@property (nonatomic, assign) DJCheckBoxState checkState;

// checkbox 类型
// Default: DJCheckBoxType_Square
@property (nonatomic, assign) DJCheckBoxType boxType;

// checkbox 水平位置
// Default: DJCheckBoxHorizontallyType_Left
@property (nonatomic, assign) DJCheckBoxHorizontallyType horizontallyType;
// checkbox 垂直位置
// Default: DJCheckBoxVerticallyType_Top
@property (nonatomic, assign) DJCheckBoxVerticallyType verticallyType;

// checkbox 宽度
// 宽高相等
@property (nonatomic, assign) CGFloat checkWidth;
// checkbox frame
@property (nonatomic, assign, readonly) CGRect boxFrame;

#pragma mark Appearance

// 文本
@property (nullable, nonatomic, strong) NSString *boxText;
// 文本字体
@property (nullable, nonatomic, strong) UIFont *boxTextFont;
// 文本颜色
@property (nullable, nonatomic, strong) UIColor *boxCheckedTextColor;
@property (nullable, nonatomic, strong) UIColor *boxUnCheckedTextColor;
@property (nullable, nonatomic, readonly) UIColor *boxTextColor;

// 外框

// 外框线宽
@property (nonatomic, assign) CGFloat boxStrokeWidth;
// 外框颜色
@property (nullable, nonatomic, strong) UIColor *boxCheckedStrokeColor;
@property (nullable, nonatomic, strong) UIColor *boxUnCheckedStrokeColor;
@property (nullable, nonatomic, strong) UIColor *boxMixedStrokeColor;
@property (nullable, nonatomic, readonly) UIColor *boxStrokeColor;
// 外框是否填充
@property (nonatomic, assign) BOOL isBoxFill;
// 外框填充颜色
@property (nullable, nonatomic, strong) UIColor *boxCheckedFillColor;
@property (nullable, nonatomic, strong) UIColor *boxUnCheckedFillColor;
@property (nullable, nonatomic, strong) UIColor *boxMixedFillColor;
@property (nullable, nonatomic, readonly) UIColor *boxFillColor;

// 外框圆角半径 DJCheckBoxType_Square时可用
@property (nonatomic, assign) CGFloat boxCornerRadius;

// 外框自定义曲线
@property (nullable, nonatomic, copy) DJCheckBoxShapeBlock boxShapeBlock;

// 标记

// 标记线宽
@property (nonatomic, assign) CGFloat markStrokeWidth;
// 标记颜色
@property (nullable, nonatomic, strong) UIColor *markCheckedStrokeColor;
//@property (nullable, nonatomic, strong) UIColor *markUnCheckedStrokeColor;
@property (nullable, nonatomic, strong) UIColor *markMixedStrokeColor;
@property (nullable, nonatomic, readonly) UIColor *markStrokeColor;

// 标记自定义曲线
@property (nullable, nonatomic, copy) DJCheckBoxShapeBlock markShapeBlock;


#pragma mark Values

//// 选中时的值
//@property (nullable, nonatomic, strong) id checkedValue;
//// 未选中时的值
//@property (nullable, nonatomic, strong) id uncheckedValue;
//// 混选时的值
//@property (nullable, nonatomic, strong) id mixedValue;
//
//- (_Nullable id)value;


#pragma mark Initalization

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth;
- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth useGesture:(BOOL)useGesture;

#pragma mark Actions

- (void)toggleCheckState;

- (UIBezierPath *)getDefaultBoxShape;
- (UIBezierPath *)getDefaultMarkShape;

- (void)setCheckBoxGroup:(nullable DJCheckBoxGroup *)group;

@end

NS_ASSUME_NONNULL_END
