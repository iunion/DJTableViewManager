//
//  DJCheckBoxGroupItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/8.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"
#import "DJCheckBoxGroup.h"
#import "DJCheckBoxLabel.h"

NS_ASSUME_NONNULL_BEGIN

#define DJCheckBoxGroupCell_MaxItemCount    (6)
#define DJCheckBoxGroupCell_TitleTop        (12.0f)
#define DJCheckBoxGroupCell_TitleLeft       (16.0f)
#define DJCheckBoxGroupCell_ItemTopGap      (10.0f)
#define DJCheckBoxGroupCell_ItemHGap        (12.0f)
#define DJCheckBoxGroupCell_ItemVGap        (8.0f)

@class DJCheckBoxGroupItem;
typedef void (^checkBoxValueChangeHandler)(DJCheckBoxGroupItem *item);

@interface DJCheckBoxGroupItem : DJTableViewItem

// 每行个数 default: 1
@property (nonatomic, assign) NSUInteger oneLineItemCount;

@property (nullable, nonatomic, strong, readonly) DJCheckBoxGroup *checkBoxGroup;

// 多选个数 default: 1
@property (nonatomic, assign) NSUInteger maxSelectedCount;
// 选中index数组 NSNumber
@property (nullable, nonatomic, strong, readonly) NSArray<NSNumber *> *selectedIndexArray;

@property (nullable, nonatomic, strong) NSMutableArray<NSNumber *> *boxStateArray;

// checkbox 类型
@property (nonatomic, assign) DJCheckBoxType boxType;

// checkbox 水平位置
@property (nonatomic, assign) DJCheckBoxHorizontallyType horizontallyType;
// checkbox 垂直位置
@property (nonatomic, assign) DJCheckBoxVerticallyType verticallyType;

// checkbox 宽度
@property (nonatomic, assign) CGFloat checkWidth;

// 选框文本 NSString 
@property (nullable, nonatomic, strong) NSMutableArray<NSString *> *boxTextArray;
@property (nullable, nonatomic, strong) UIFont *boxTextFont;
@property (nullable, nonatomic, strong) UIColor *boxCheckedTextColor;
@property (nullable, nonatomic, strong) UIColor *boxUnCheckedTextColor;

@property (nonatomic, assign) CGFloat boxStrokeWidth;

@property (nullable, nonatomic, strong) UIColor *boxCheckedStrokeColor;
@property (nullable, nonatomic, strong) UIColor *boxUnCheckedStrokeColor;
@property (nullable, nonatomic, strong) UIColor *boxMixedStrokeColor;

@property (nonatomic, assign) BOOL isBoxFill;

@property (nullable, nonatomic, strong) UIColor *boxCheckedFillColor;
@property (nullable, nonatomic, strong) UIColor *boxUnCheckedFillColor;
@property (nullable, nonatomic, strong) UIColor *boxMixedFillColor;

@property (nonatomic, assign) CGFloat boxCornerRadius;

@property (nullable, nonatomic, copy) DJCheckBoxShapeBlock boxShapeBlock;

@property (nonatomic, assign) CGFloat markStrokeWidth;

@property (nullable, nonatomic, strong) UIColor *markCheckedStrokeColor;
@property (nullable, nonatomic, strong) UIColor *markMixedStrokeColor;

@property (nullable, nonatomic, copy) DJCheckBoxShapeBlock markShapeBlock;

// 文本和选择框的间隔
@property (nonatomic, assign) CGFloat checkBoxGap;

// 文本
@property (nullable, nonatomic, strong) NSMutableArray *labelTextArray;
//@property (nullable, nonatomic, strong) NSMutableArray *labelCheckedAttrTextArray;
//@property (nullable, nonatomic, strong) NSMutableArray *labelUnCheckedAttrTextArray;
//@property (nullable, nonatomic, strong) NSMutableArray *labelMixedAttrTextArray;

@property (nonatomic, assign) NSTextAlignment labelTextAlignment;

@property (nullable, nonatomic, strong) UIFont *labelTextFont;

@property (nullable, nonatomic, strong) UIColor *labelTextCheckedColor;
@property (nullable, nonatomic, strong) UIColor *labelTextUnCheckedColor;
@property (nullable, nonatomic, strong) UIColor *labelTextMixedColor;

// UI
@property (nonatomic, assign, readonly) CGFloat titleWidth;
@property (nonatomic, assign, readonly) CGFloat titleHeight;

@property (nonatomic, assign, readonly) CGFloat itemWidth;
@property (nullable, nonatomic, strong, readonly) NSMutableArray<NSMutableDictionary *> *itemFrameArray;

@property (nullable, nonatomic, copy) checkBoxValueChangeHandler valueChangeHandler;


+ (instancetype)itemWithTitle:(nullable NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(nullable NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray;
+ (instancetype)itemWithTitle:(nullable NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(nullable NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray checkBoxValueChangeHandler:(nullable checkBoxValueChangeHandler)valueChangeHandler;
- (instancetype)initWithTitle:(nullable NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(nullable NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray;
- (instancetype)initWithTitle:(nullable NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(nullable NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray checkBoxValueChangeHandler:(nullable checkBoxValueChangeHandler)valueChangeHandler;

- (void)caleCellHeightWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
