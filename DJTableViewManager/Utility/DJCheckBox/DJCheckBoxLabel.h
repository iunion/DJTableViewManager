//
//  DJCheckBoxLabel.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/9.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJCheckBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJCheckBoxLabel : DJCheckBox

// 文本和选择框的间隔
@property (nonatomic, assign) CGFloat checkBoxGap;

// 文本
@property (nullable, nonatomic, strong) NSString *labelText;
@property (nullable, nonatomic, strong) NSAttributedString *labelCheckedAttrText;
@property (nullable, nonatomic, strong) NSAttributedString *labelUnCheckedAttrText;
@property (nullable, nonatomic, strong) NSAttributedString *labelMixedAttrText;
@property (nullable, nonatomic, readonly) NSAttributedString *labelAttrText;

// 文本对齐
@property (nonatomic, assign) NSTextAlignment labelTextAlignment;

// 文本字体
@property (nullable, nonatomic, strong) UIFont *labelTextFont;

// 文本颜色
@property (nullable, nonatomic, strong) UIColor *labelTextCheckedColor;
@property (nullable, nonatomic, strong) UIColor *labelTextUnCheckedColor;
@property (nullable, nonatomic, strong) UIColor *labelTextMixedColor;
@property (nullable, nonatomic, readonly) UIColor *labelTextColor;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth;
- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth useGesture:(BOOL)useGesture;

- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth labelText:(nullable NSString *)labelText useGesture:(BOOL)useGesture;
- (instancetype)initWithFrame:(CGRect)frame checkWidth:(CGFloat)checkWidth labelText:(nullable NSString *)labelText checkBoxGap:(CGFloat)checkBoxGap useGesture:(BOOL)useGesture;

@end

NS_ASSUME_NONNULL_END

