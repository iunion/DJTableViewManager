//
//  DJTableViewManager.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DJTableViewManagerDefine.h"

#import "DJTableViewCellStyle.h"
#import "DJTableViewSection.h"

#import "DJTableViewItem.h"
#import "DJTextItem.h"
#import "DJMaskTextItem.h"
#import "DJNumberTextItem.h"
#import "DJBoolItem.h"

#import "DJTableViewTextCell.h"
#import "DJTableViewMaskTextCell.h"
#import "DJTableViewNumberTextCell.h"
#import "DJTableViewBoolCell.h"


@protocol DJTableViewManagerDelegate;


NS_ASSUME_NONNULL_BEGIN

@interface DJTableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

// The object that acts as the delegate of the receiving table view.
@property (nullable, nonatomic, weak) id <DJTableViewManagerDelegate> delegate;

@property (nullable, nonatomic, weak) UITableView *tableView;

// The array of sections. See DJTableViewSection reference for details.
@property (nullable, nonatomic, strong, readonly) NSArray *sections;
// The object that provides styling for `UITableView`. See DJTableViewCellStyle reference for details.
@property (nullable, nonatomic, strong) DJTableViewCellStyle *style;

///-----------------------------
/// @name Managing Custom Cells
///-----------------------------

/**
 The array of pairs of items / cell classes.
 */
@property (strong, nonatomic, nullable) NSMutableDictionary *registeredClasses;

/**
 For each custom item class that the manager will use, register a cell class.
 
 @param objectClass The object class to be associated with a cell class.
 @param identifier The cell class identifier.
 @param bundle The resource gbundle.
 */
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier bundle:(nullable NSBundle *)bundle;

/**
 Returns cell class at specified index path.
 
 @param indexPath The index path of cell.
 */
- (nullable Class)classForCellAtIndexPath:(NSIndexPath *)indexPath;

///-----------------------------
/// @name Creating and Initializing a DJTableViewManager
///-----------------------------

- (instancetype)initWithTableView:(UITableView *)tableView;

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(nullable id <DJTableViewManagerDelegate>)delegate;

- (void)addSection:(DJTableViewSection *)section;
- (void)addSectionsFromArray:(NSArray *)array;

- (void)insertSection:(DJTableViewSection *)section atIndex:(NSUInteger)index;
- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

- (void)removeSection:(DJTableViewSection *)section;
- (void)removeSection:(DJTableViewSection *)section inRange:(NSRange)range;
- (void)removeAllSections;

- (void)removeSectionIdenticalTo:(DJTableViewSection *)section;
- (void)removeSectionIdenticalTo:(DJTableViewSection *)section inRange:(NSRange)range;
- (void)removeSectionsInArray:(NSArray *)otherArray;
- (void)removeSectionsInRange:(NSRange)range;

- (void)removeLastSection;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(DJTableViewSection *)section;
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray;

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

- (void)sortSectionsUsingFunction:(NSInteger (NS_NOESCAPE *)(id, id, void * _Nullable))compare context:(nullable void *)context;
- (void)sortSectionsUsingSelector:(SEL)comparator;

// 弹出键盘
- (void)showKeyBordWithVisibleCells;
- (void)showKeyBordAtIndexPath:(NSIndexPath *)indexPath;

//- (NSInteger)indexOfFirstResponder;

@end


@protocol DJTableViewManagerDelegate <UITableViewDelegate>

@optional

- (void)tableView:(UITableView *)tableView willLayoutCellSubviews:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView willLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
