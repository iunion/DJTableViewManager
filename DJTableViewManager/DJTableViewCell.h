//
//  DJTableViewCell.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/7.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DJTableViewManagerDefine.h"

#import "DJTableViewSection.h"
#import "DJActionBar.h"

@class DJTableViewManager;
@class DJTableViewItem;

NS_ASSUME_NONNULL_BEGIN

@interface DJTableViewCell : UITableViewCell <DJActionBarDelegate>

@property (nullable, nonatomic, weak) UITableView *parentTableView;
@property (nullable, nonatomic, weak) DJTableViewManager *tableViewManager;

///-----------------------------
/// @name Working With Keyboard
///-----------------------------
@property (nullable, nonatomic, strong) DJActionBar *actionBar;

@property (nullable, nonatomic, strong, readonly) UIResponder *responder;
@property (nullable, nonatomic, strong, readonly) NSIndexPath *indexPathForPreviousResponder;
@property (nullable, nonatomic, strong, readonly) NSIndexPath *indexPathForNextResponder;

///-----------------------------
/// @name Managing Cell Appearance
///-----------------------------
@property (nullable, nonatomic, strong, readonly) UIImageView *backgroundImageView;
@property (nullable, nonatomic, strong, readonly) UIImageView *selectedBackgroundImageView;

///-----------------------------
/// @name Accessing Row and Section
///-----------------------------
@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic, assign) NSInteger sectionIndex;

@property (nullable, nonatomic, weak) DJTableViewSection *section;
@property (nullable, nonatomic, strong) DJTableViewItem *item;

@property (nonatomic, assign, readonly) DJTableViewCell_PositionType positionType;

@property (nonatomic, assign, readonly) BOOL loaded;

// cell高度
+ (CGFloat)heightWithItem:(DJTableViewItem *)item tableViewManager:(DJTableViewManager *)tableViewManager;

// 是否可以设置Focus
+ (BOOL)canFocusWithItem:(DJTableViewItem *)item;

// 刷新导航工具条
- (void)updateActionBarNavigationControl;

// 布局detailView
- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth;

// 底部连线
- (void)drawSingleLineView;
// 高亮动画
- (void)showHighlightedAnimation;

- (void)cellDidLoad;
- (void)cellWillAppear;
- (void)cellDidDisappear;

- (void)cellLayoutSubviews;

@end

NS_ASSUME_NONNULL_END
