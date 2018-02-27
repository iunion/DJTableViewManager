//
//  DJCheckBoxGroup.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/8.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJCheckBoxGroup.h"
#import "DJCheckBox.h"

//@interface DJCheckBox ()
//
//@property (nonatomic, weak) DJCheckBoxGroup *group;
//
//@end

@interface DJCheckBoxGroup ()

@property (nonatomic, strong) NSMutableArray<DJCheckBox *> *checkBoxes;
@property (nonatomic, strong) NSMutableArray<DJCheckBox *> *selectedCheckBoxes;

@end

@implementation DJCheckBoxGroup

+ (instancetype)groupWithCheckBoxes:(NSArray<DJCheckBox *> *)checkBoxes maxSelectedCount:(NSUInteger)maxSelectedCount
{
    DJCheckBoxGroup *checkBoxGroup = [[DJCheckBoxGroup alloc] initWithCheckBoxes:checkBoxes maxSelectedCount:maxSelectedCount];
    
    return checkBoxGroup;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.maxSelectedCount = 1;
        self.checkBoxes = [NSMutableArray array];
        self.selectedCheckBoxes = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithCheckBoxes:(NSArray<DJCheckBox *> *)checkBoxes maxSelectedCount:(NSUInteger)maxSelectedCount
{
    self = [self init];
    if (self)
    {
        self.maxSelectedCount = maxSelectedCount;
        
        for (DJCheckBox *checkBox in checkBoxes)
        {
            [self addCheckBoxToGroup:checkBox];
        }
    }
    return self;
}

- (void)setMaxSelectedCount:(NSUInteger)maxSelectedCount
{
    if (maxSelectedCount < 1)
    {
        maxSelectedCount = 1;
    }

    if (_maxSelectedCount != maxSelectedCount)
    {
        _maxSelectedCount = maxSelectedCount;
    }
}


- (void)addCheckBoxToGroup:(DJCheckBox *)checkBox
{
    if (checkBox.group)
    {
        [checkBox.group removeCheckBoxFromGroup:checkBox];
    }

    [self.checkBoxes addObject:checkBox];
    [checkBox setCheckBoxGroup:self];
    if (checkBox.checkState == DJCheckBoxState_Checked)
    {
        if (self.selectedCheckBoxes.count < self.maxSelectedCount)
        {
            [self.selectedCheckBoxes addObject:checkBox];
        }
    }
    else
    {
        checkBox.checkState = DJCheckBoxState_UnChecked;
    }
}

- (void)removeCheckBoxFromGroup:(DJCheckBox *)checkBox
{
    if (![self.checkBoxes containsObject:checkBox])
    {
        return;
    }
    [checkBox setCheckBoxGroup:nil];
    [self.checkBoxes removeObject:checkBox];
    
    if (![self.selectedCheckBoxes containsObject:checkBox])
    {
        return;
    }
    [self.selectedCheckBoxes removeObject:checkBox];
}

- (void)groupSelectionChangedWithCheckBox:(DJCheckBox *)checkBox
{
    if (checkBox.checkState != DJCheckBoxState_Checked)
    {
        if (![self.selectedCheckBoxes containsObject:checkBox])
        {
            return;
        }
        [self.selectedCheckBoxes removeObject:checkBox];
        
        return;
    }
    
    if ([self.selectedCheckBoxes containsObject:checkBox])
    {
        return;
    }
    
    if (self.maxSelectedCount == 1)
    {
        DJCheckBox *oldCheckBox = [self.selectedCheckBoxes firstObject];
        oldCheckBox.checkState = DJCheckBoxState_UnChecked;
        
        [self.selectedCheckBoxes removeAllObjects];
        [self.selectedCheckBoxes addObject:checkBox];
    }
    else
    {
        if (self.selectedCheckBoxes.count < self.maxSelectedCount)
        {
            [self.selectedCheckBoxes addObject:checkBox];
        }
        else
        {
            checkBox.checkState = DJCheckBoxState_UnChecked;
        }
    }
}

@end
