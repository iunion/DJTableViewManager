//
//  DJTableViewCellStyle.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJTableViewManagerDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJTableViewCellStyle : NSObject

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) UITableViewCellSelectionStyle defaultCellSelectionStyle;

@property (nonatomic, assign) CGFloat backgroundImageMargin;
@property (nonatomic, assign) CGFloat contentViewMargin;

// 背景图
@property (nullable, nonatomic, strong) NSMutableDictionary *backgroundImages;
@property (nullable, nonatomic, strong) NSMutableDictionary *selectedBackgroundImages;

- (BOOL)hasCustomBackgroundImage;
- (nullable UIImage *)backgroundImageForCellPositionType:(DJTableViewCell_PositionType)cellPositionType;
- (void)setBackgroundImage:(nullable UIImage *)image forCellPositionType:(DJTableViewCell_PositionType)cellPositionType;

- (BOOL)hasCustomSelectedBackgroundImage;
- (nullable UIImage *)selectedBackgroundImageForCellPositionType:(DJTableViewCell_PositionType)cellPositionType;
- (void)setSelectedBackgroundImage:(nullable UIImage *)image forCellPositionType:(DJTableViewCell_PositionType)cellPositionType;

@end

NS_ASSUME_NONNULL_END
