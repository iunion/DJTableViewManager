//
//  DJTableViewSection.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern CGFloat const DJTableViewSectionHeaderHeightAutomatic;
extern CGFloat const DJTableViewSectionFooterHeightAutomatic;

@class DJTableViewManager;
@class DJTableViewCellStyle;

NS_ASSUME_NONNULL_BEGIN

@interface DJTableViewSection : NSObject

// The table view manager of this section.
@property (nullable, nonatomic, weak) DJTableViewManager *tableViewManager;

// The object that provides styling for the section. See DJTableViewCellStyle reference for details.
@property (nullable, nonatomic, strong) DJTableViewCellStyle *style;

// Section index in UITableView.
@property (nonatomic, assign, readonly) NSUInteger index;

// Section index title.
@property (nullable, nonatomic, copy) NSString *indexTitle;

@property (nullable, nonatomic, copy) NSString *headerTitle;
@property (nullable, nonatomic, copy) NSString *footerTitle;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nullable, nonatomic, strong) UIView *headerView;
@property (nullable, nonatomic, strong) UIView *footerView;

// The width of padding between the cell title and cell detail view
@property (nonatomic, assign) CGFloat cellTitlePadding;

// An array of section items (rows).
@property (nullable, nonatomic, strong, readonly) NSArray *items;


+ (instancetype)section;

+ (instancetype)sectionWithHeaderTitle:(nullable NSString *)headerTitle;
+ (instancetype)sectionWithHeaderTitle:(nullable NSString *)headerTitle footerTitle:(nullable NSString *)footerTitle;

+ (instancetype)sectionWithHeaderView:(nullable UIView *)headerView;
+ (instancetype)sectionWithHeaderView:(nullable UIView *)headerView footerView:(nullable UIView *)footerView;

- (id)initWithHeaderTitle:(nullable NSString *)headerTitle;
- (id)initWithHeaderTitle:(nullable NSString *)headerTitle footerTitle:(nullable NSString *)footerTitle;

- (id)initWithHeaderView:(nullable UIView *)headerView;
- (id)initWithHeaderView:(nullable UIView *)headerView footerView:(nullable UIView *)footerView;

// Returns the width of the longest title in the section.
//
// @param font A base font to use in calculations.
// @return width.
- (CGFloat)maximumTitleWidthWithFont:(UIFont *)font;


- (void)addItem:(id)item;
- (void)addItemsFromArray:(NSArray *)array;

- (void)insertItem:(id)item atIndex:(NSUInteger)index;
- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes;

- (void)removeItem:(id)item;
- (void)removeItem:(id)item inRange:(NSRange)range;
- (void)removeAllItems;

- (void)removeItemIdenticalTo:(id)item;
- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range;
- (void)removeItemsInArray:(NSArray *)otherArray;
- (void)removeItemsInRange:(NSRange)range;

- (void)removeLastItem;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item;
- (void)replaceItemsWithItemsFromArray:(NSArray *)otherArray;
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items;

- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2;

- (void)sortItemsUsingFunction:(NSInteger (NS_NOESCAPE *)(id,  id, void * _Nullable))compare context:(nullable void *)context;
- (void)sortItemsUsingSelector:(SEL)comparator;

- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation;


@end

NS_ASSUME_NONNULL_END
