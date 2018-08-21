//
//  DJTableViewCheckBoxGroupCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/8.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewCheckBoxGroupCell.h"
#import "DJTableViewManager.h"
#import "DJCheckBoxGroupItem.h"
#import "DJCheckBoxGroup.h"


@interface DJTableViewCheckBoxGroupCell ()

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, strong) DJCheckBoxGroupItem *item;

@property (nonatomic, strong) NSMutableArray *checkBoxArray;
@property (nonatomic, strong) DJCheckBoxGroup *checkBoxGroup;

@end

@implementation DJTableViewCheckBoxGroupCell
@synthesize item = _item;

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.numberOfLines = 0;

    self.checkBoxArray = [NSMutableArray arrayWithCapacity:DJCheckBoxGroupCell_MaxItemCount];
    
    for (NSUInteger i=0; i<DJCheckBoxGroupCell_MaxItemCount; i++)
    {
        DJCheckBoxLabel *checkBoxLabel = [[DJCheckBoxLabel alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 30.0f)];
        [self.checkBoxArray addObject:checkBoxLabel];
        //checkBoxLabel.hidden = YES;
        [self.contentView addSubview:checkBoxLabel];
    }
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.enabled = self.item.enabled;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    //self.textLabel.backgroundColor = [UIColor redColor];

    CGFloat width = self.item.titleWidth;
    CGFloat textLabelHeight = self.item.titleHeight;
    self.textLabel.frame = CGRectMake(DJCheckBoxGroupCell_TitleLeft, DJCheckBoxGroupCell_TitleTop, width, textLabelHeight);
    
    for (NSUInteger i=0; i<DJCheckBoxGroupCell_MaxItemCount; i++)
    {
        DJCheckBoxLabel *checkBoxLabel = self.checkBoxArray[i];
        if ( i < self.item.itemFrameArray.count)
        {
            NSDictionary *rectDict = self.item.itemFrameArray[i];
            CGRect rect = CGRectZero;
            BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)rectDict, &rect);
            if (!success)
            {
                rect = CGRectZero;
            }
            //NSLog(@"%@", NSStringFromCGRect(rect));
            checkBoxLabel.frame = rect;
            [checkBoxLabel setNeedsDisplay];
            checkBoxLabel.hidden = NO;
        }
        else
        {
            checkBoxLabel.hidden = YES;
        }
    }
}

- (void)setItem:(DJCheckBoxGroupItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSMutableArray *checkBoxLabelArray = [NSMutableArray arrayWithCapacity:item.labelContentArray.count];
    for (NSUInteger i=0; i<DJCheckBoxGroupCell_MaxItemCount; i++)
    {
        DJCheckBoxLabel *checkBoxLabel = self.checkBoxArray[i];
        checkBoxLabel.hidden = YES;
        [checkBoxLabel removeTarget:self action:@selector(checkChangedValue:) forControlEvents:UIControlEventValueChanged];
        
        if (i < item.labelContentArray.count)
        {
            // checkbox 类型
            checkBoxLabel.boxType = item.boxType;
            
            // 文本字体
            checkBoxLabel.boxTextFont = item.boxTextFont;
            // 文本颜色
            checkBoxLabel.boxCheckedTextColor = item.boxCheckedTextColor;
            checkBoxLabel.boxUnCheckedTextColor = item.boxUnCheckedTextColor;
            
            // 外框
            
            // 外框线宽
            checkBoxLabel.boxStrokeWidth = item.boxStrokeWidth;
            // 外框颜色
            checkBoxLabel.boxCheckedStrokeColor = item.boxCheckedStrokeColor;
            checkBoxLabel.boxUnCheckedStrokeColor = item.boxUnCheckedStrokeColor;
            checkBoxLabel.boxMixedStrokeColor = item.boxMixedStrokeColor;
            // 外框是否填充
            checkBoxLabel.isBoxFill = item.isBoxFill;
            // 外框填充颜色
            checkBoxLabel.boxCheckedFillColor = item.boxCheckedFillColor;
            checkBoxLabel.boxUnCheckedFillColor = item.boxUnCheckedFillColor;
            checkBoxLabel.boxMixedFillColor = item.boxMixedFillColor;
            
            // 外框圆角半径 DJCheckBoxType_Square时可用
            checkBoxLabel.boxCornerRadius = item.boxCornerRadius;
            
            // 标记
            
            // 标记线宽
            checkBoxLabel.markStrokeWidth = item.markStrokeWidth;
            // 标记颜色
            checkBoxLabel.markCheckedStrokeColor = item.markCheckedStrokeColor;
            checkBoxLabel.markMixedStrokeColor = item.markMixedStrokeColor;
            
            // checkbox 水平位置
            checkBoxLabel.horizontallyType = item.horizontallyType;
            // checkbox 垂直位置
            checkBoxLabel.verticallyType = item.verticallyType;
            
            checkBoxLabel.labelTextCheckedColor = item.labelTextCheckedColor;
            checkBoxLabel.labelTextUnCheckedColor = item.labelTextUnCheckedColor;
            checkBoxLabel.labelTextMixedColor = item.labelTextMixedColor;
            
            checkBoxLabel.labelTextAlignment = item.labelTextAlignment;
            checkBoxLabel.labelTextFont = item.labelTextFont;
            
            checkBoxLabel.boxText = item.boxTextArray[i];
            
            id labelContent = item.labelContentArray[i];
            if ([labelContent isKindOfClass:[NSString class]])
            {
                NSString *str = (NSString *)labelContent;
                checkBoxLabel.labelText = str;
            }
            else
            {
                DJCheckBoxGroupImage *checkBoxImage = (DJCheckBoxGroupImage *)labelContent;
                checkBoxLabel.labelImage = checkBoxImage.image;
                checkBoxLabel.labelImageUrl = checkBoxImage.imageUrl;
                checkBoxLabel.imageLongPress = item.imageLongPress;
            }
            
            checkBoxLabel.checkState = item.boxStateArray[i].unsignedIntegerValue;
            
            //checkBoxLabel.hidden = NO;
            
            [checkBoxLabel addTarget:self action:@selector(checkChangedValue:) forControlEvents:UIControlEventValueChanged];

            [checkBoxLabelArray addObject:checkBoxLabel];
        }
    }
    
    self.checkBoxGroup = [[DJCheckBoxGroup alloc] initWithCheckBoxes:checkBoxLabelArray maxSelectedCount:item.maxSelectedCount];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    
    for (DJCheckBoxLabel *checkBoxLabel in self.checkBoxArray)
    {
        checkBoxLabel.enabled = _enabled;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJCheckBoxGroupItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
}

- (void)checkChangedValue:(DJCheckBoxLabel *)checkBoxLabel
{
    NSUInteger index = [self.checkBoxGroup.checkBoxes indexOfObject:checkBoxLabel];
    if (index < self.item.boxStateArray.count)
    {
        self.item.boxStateArray[index] = @(checkBoxLabel.checkState);
    }
    
    if (self.item.valueChangeHandler)
    {
        self.item.valueChangeHandler(self.item);
    }
}

@end
