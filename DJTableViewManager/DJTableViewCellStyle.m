//
//  DJTableViewCellStyle.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTableViewCellStyle.h"

// 默认高度
#define Default_Cell_Height     TABLE_CELL_HEIGHT

@implementation DJTableViewCellStyle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.backgroundImages = [[NSMutableDictionary alloc] init];
        self.selectedBackgroundImages = [[NSMutableDictionary alloc] init];
        self.cellHeight = Default_Cell_Height;
        self.defaultCellSelectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    DJTableViewCellStyle *style = [[self class] allocWithZone:zone];
    if (style)
    {
        style.backgroundImages = [NSMutableDictionary dictionaryWithDictionary:[self.backgroundImages copyWithZone:zone]];
        style.selectedBackgroundImages = [NSMutableDictionary dictionaryWithDictionary:[self.selectedBackgroundImages copyWithZone:zone]];
        style.cellHeight = self.cellHeight;
        style.defaultCellSelectionStyle = self.defaultCellSelectionStyle;
        style.backgroundImageMargin = self.backgroundImageMargin;
        style.contentViewMargin = self.contentViewMargin;
    }
    return style;
}

- (BOOL)hasCustomBackgroundImage
{
    return [self backgroundImageForCellPositionType:DJTableViewCell_PositionType_None] || [self backgroundImageForCellPositionType:DJTableViewCell_PositionType_First] || [self backgroundImageForCellPositionType:DJTableViewCell_PositionType_Middle] || [self backgroundImageForCellPositionType:DJTableViewCell_PositionType_Last] || [self backgroundImageForCellPositionType:DJTableViewCell_PositionType_Single];
}

- (UIImage *)backgroundImageForCellPositionType:(DJTableViewCell_PositionType)cellPositionType
{
    UIImage *image = self.backgroundImages[@(cellPositionType)];
    if (!image && cellPositionType != DJTableViewCell_PositionType_None)
    {
        image = self.backgroundImages[@(DJTableViewCell_PositionType_None)];
    }
    return image;
}

- (void)setBackgroundImage:(UIImage *)image forCellPositionType:(DJTableViewCell_PositionType)cellPositionType
{
    if (image)
    {
        [self.backgroundImages setObject:image forKey:@(cellPositionType)];
    }
    else
    {
        [self.backgroundImages removeObjectForKey:@(cellPositionType)];
    }
}

- (BOOL)hasCustomSelectedBackgroundImage
{
    return [self selectedBackgroundImageForCellPositionType:DJTableViewCell_PositionType_None] || [self selectedBackgroundImageForCellPositionType:DJTableViewCell_PositionType_First] || [self selectedBackgroundImageForCellPositionType:DJTableViewCell_PositionType_Middle] || [self selectedBackgroundImageForCellPositionType:DJTableViewCell_PositionType_Last] || [self selectedBackgroundImageForCellPositionType:DJTableViewCell_PositionType_Single];
}

- (UIImage *)selectedBackgroundImageForCellPositionType:(DJTableViewCell_PositionType)cellPositionType
{
    UIImage *image = self.selectedBackgroundImages[@(cellPositionType)];
    if (!image && cellPositionType != DJTableViewCell_PositionType_None)
    {
        image = self.selectedBackgroundImages[@(DJTableViewCell_PositionType_None)];
    }
    return image;
}

- (void)setSelectedBackgroundImage:(UIImage *)image forCellPositionType:(DJTableViewCell_PositionType)cellPositionType
{
    if (image)
    {
        [self.selectedBackgroundImages setObject:image forKey:@(cellPositionType)];
    }
    else
    {
        [self.selectedBackgroundImages removeObjectForKey:@(cellPositionType)];
    }
}

@end
