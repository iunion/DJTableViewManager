//
//  DJCheckBoxGroupItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/8.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJCheckBoxGroupItem.h"

//#define DJCheckBoxGroupCell_MaxItemCount    (6)
//#define DJCheckBoxGroupCell_TitleTop        (6.0f)
//#define DJCheckBoxGroupCell_TitleLeft       (16.0f)
//#define DJCheckBoxGroupCell_ItemTopGap      (4.0f)
//#define DJCheckBoxGroupCell_ItemVGap        (4.0f)
//#define DJCheckBoxGroupCell_ItemHGap        (6.0f)
//#define DJCheckBoxGroupCell_ItemHeight      (30.0f)

@interface DJCheckBoxGroupItem ()

@property (nonatomic, strong) DJCheckBoxGroup *checkBoxGroup;
@property (nonatomic, strong) NSArray *selectedIndexArray;

// for UI
@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *itemFrameArray;


@end

@implementation DJCheckBoxGroupItem

+ (instancetype)itemWithTitle:(NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray
{
    return [[self alloc] initWithTitle:title oneLineItemCount:oneLineItemCount maxSelectedCount:maxSelectedCount boxTextArray:boxTextArray labelTextArray:labelTextArray];
}

+ (instancetype)itemWithTitle:(NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray checkBoxValueChangeHandler:(checkBoxValueChangeHandler)valueChangeHandler
{
    return [[self alloc] initWithTitle:title oneLineItemCount:oneLineItemCount maxSelectedCount:maxSelectedCount boxTextArray:boxTextArray labelTextArray:labelTextArray checkBoxValueChangeHandler:valueChangeHandler];
}

- (instancetype)initWithTitle:(NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray
{
    return [self initWithTitle:title oneLineItemCount:oneLineItemCount maxSelectedCount:maxSelectedCount boxTextArray:boxTextArray labelTextArray:labelTextArray checkBoxValueChangeHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title oneLineItemCount:(NSUInteger)oneLineItemCount maxSelectedCount:(NSUInteger)maxSelectedCount boxTextArray:(NSMutableArray<NSString *> *)boxTextArray labelTextArray:(NSMutableArray *)labelTextArray checkBoxValueChangeHandler:(checkBoxValueChangeHandler)valueChangeHandler
{
    if (![labelTextArray isNotEmpty])
    {
        return nil;
    }
    
    if ([boxTextArray isNotEmpty])
    {
        if (labelTextArray.count != boxTextArray.count)
        {
            return nil;
        }
    }
    
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    //self.isShowSelectBg = NO;
    self.isShowHighlightBg = NO;
    
    self.title = title;
    self.valueChangeHandler = valueChangeHandler;
    
    self.oneLineItemCount = 1;
    
    // checkbox 类型
    self.boxType = DJCheckBoxType_Text;
    
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
        
    // checkbox 水平位置
    self.horizontallyType = DJCheckBoxHorizontallyType_Left;
    // checkbox 垂直位置
    self.verticallyType = DJCheckBoxVerticallyType_Center;

    self.labelTextCheckedColor = [UIColor blackColor];
    self.labelTextUnCheckedColor = [UIColor blackColor];
    self.labelTextMixedColor = [UIColor blackColor];
    
    self.labelTextAlignment = NSTextAlignmentLeft;
    self.labelTextFont = [UIFont systemFontOfSize:14.0f];
    
    self.oneLineItemCount = oneLineItemCount;
    self.maxSelectedCount = maxSelectedCount;
    self.boxTextArray = boxTextArray;
    self.labelTextArray = labelTextArray;
    
    self.boxStateArray = [NSMutableArray array];

    for (NSUInteger i=0; i<self.labelTextArray.count; i++)
    {
        [self.boxStateArray addObject:@(DJCheckBoxState_UnChecked)];
    }
    
    return self;
}

- (NSArray<NSNumber *> *)selectedIndexArray
{
    NSMutableArray *selectedArray = [NSMutableArray array];
    for (NSUInteger i=0; i<self.boxStateArray.count; i++)
    {
        NSNumber *state = self.boxStateArray[i];
        if (state.unsignedIntegerValue == DJCheckBoxState_Checked)
        {
            [selectedArray addObject:@(i)];
        }
    }
    
    return selectedArray;
}

- (void)setOneLineItemCount:(NSUInteger)oneLineItemCount
{
    if (oneLineItemCount < 1)
    {
        oneLineItemCount = 1;
    }
    
    _oneLineItemCount = oneLineItemCount;
}

- (void)caleCellHeightWithTableView:(UITableView *)tableView
{
    CGFloat height = DJCheckBoxGroupCell_TitleTop;
    self.titleWidth = UI_SCREEN_WIDTH-(tableView.contentInset.left+tableView.contentInset.right)-DJCheckBoxGroupCell_TitleLeft*2;
    if (self.titleAttrStr)
    {
        CGSize maxSize = CGSizeMake(self.titleWidth, CGFLOAT_MAX);
        self.titleHeight = ceil([self.titleAttrStr sizeToFit:maxSize lineBreakMode:NSLineBreakByCharWrapping].height);
    }
    else
    {
        self.titleHeight = ceil([self.title heightForFont:self.textFont width:self.titleWidth]);
    }
    
    height += self.titleHeight + tableView.contentInset.top;
    
    height += DJCheckBoxGroupCell_ItemTopGap + DJCheckBoxGroupCell_ItemVGap;

    CGFloat itemWidth = self.titleWidth/self.oneLineItemCount - DJCheckBoxGroupCell_ItemHGap;
    self.itemWidth = itemWidth;
    
    CGFloat x = DJCheckBoxGroupCell_TitleLeft + DJCheckBoxGroupCell_ItemHGap*0.5;
    CGFloat y = self.titleHeight + DJCheckBoxGroupCell_ItemTopGap + DJCheckBoxGroupCell_ItemVGap;
    CGFloat maxItemHeight = 0.0f;
    
    self.itemFrameArray = [NSMutableArray array];
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:self.oneLineItemCount];
    for (NSUInteger i=0; i<self.labelTextArray.count; i++)
    {
        NSString *str = self.labelTextArray[i];
        CGFloat itemHeight = ceil([str heightForFont:self.labelTextFont width:itemWidth]);
        if (itemHeight > maxItemHeight)
        {
            maxItemHeight = itemHeight;
        }
        
        CGRect frame = CGRectMake(x, y, itemWidth, itemHeight);
        CFDictionaryRef dictionary = CGRectCreateDictionaryRepresentation(frame);
        NSMutableDictionary *rectDict = [NSMutableDictionary dictionaryWithDictionary:
                                  (__bridge NSDictionary *)dictionary];
        CFRelease(dictionary);
        [frameArray addObject:rectDict];
        
        x += itemWidth+DJCheckBoxGroupCell_ItemHGap;
        if (x > self.titleWidth)
        {
            x = DJCheckBoxGroupCell_TitleLeft + DJCheckBoxGroupCell_ItemHGap*0.5;;
            y += maxItemHeight + DJCheckBoxGroupCell_ItemVGap;
            height += maxItemHeight + DJCheckBoxGroupCell_ItemVGap;
            
            for (NSMutableDictionary *rectDict in frameArray)
            {
                [rectDict setObject:@(maxItemHeight) forKey:@"Height"];
                
                [self.itemFrameArray addObject:rectDict];
            }
            
            maxItemHeight = 0;
            frameArray = [NSMutableArray arrayWithCapacity:self.oneLineItemCount];
        }
    }
    if ([frameArray isNotEmpty] && maxItemHeight>0)
    {
        for (NSMutableDictionary *rectDict in frameArray)
        {
            [rectDict setObject:@(maxItemHeight) forKey:@"Height"];
            
            [self.itemFrameArray addObject:rectDict];
        }
        height += maxItemHeight + DJCheckBoxGroupCell_ItemVGap;
    }
    
    height += tableView.contentInset.bottom;
    
    self.cellHeight = height;
}


@end
