//
//  DJTableViewManagerDefine.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#ifndef DJTableViewManagerDefine_h
#define DJTableViewManagerDefine_h

#import "NSArray+Category.h"
#import "NSAttributedString+Category.h"
#import "NSDate+Category.h"
#import "NSObject+Category.h"
#import "NSString+Category.h"
#import "NSString+Format.h"
#import "NSString+RegEx.h"
#import "NSNumber+Category.h"

#import "UIColor+Category.h"
#import "UIFont+Category.h"
#import "UITextField+Category.h"
#import "UIView+Size.h"
#import "UIView+Positioning.h"

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

/**
 *  Macros that returns if the iOS version is greater or equal to choosed one
 *
 *  @return Returns a BOOL
 */
#define IS_IOS_5_OR_LATER    (IOS_VERSION >= 5.0f)
#define IS_IOS_6_OR_LATER    (IOS_VERSION >= 6.0f)
#define IS_IOS_7_OR_LATER    (IOS_VERSION >= 7.0f)
#define IS_IOS_8_OR_LATER    (IOS_VERSION >= 8.0f)
#define IS_IOS_9_OR_LATER    (IOS_VERSION >= 9.0f)
#define IS_IOS_10_OR_LATER    (IOS_VERSION >= 10.0f)

#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

#define TABLE_CELL_HEIGHT   44.0f

// 单像素
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define UI_DEFAULT_LINECOLOR        [UIColor colorWithHex:0xE6E6E6]

// Cell背景颜色
#define UI_CELL_BGCOLOR             [UIColor colorWithHex:0xFFFFFF]

// Cell选中状态背景颜色
#define UI_CELL_SELECT_BGCOLOR      [UIColor colorWithHex:0xCCCCCC]
#define UI_CELL_HIGHLIGHT_BGCOLOR   [UIColor colorWithHex:0xE8373D]

// 字体
#define UI_DJFONT_MAKE(FontName, FontSize)  [UIFont fontForFontName:FontName size:FontSize]
#define UI_NUMBER_FONT(fontSize)            UI_DJFONT_MAKE(FontNameHelveticaNeueBold, fontSize)
#define UI_DJ_FONT(fontSize)                [UIFont systemFontOfSize:fontSize]
#define UI_DJ_BFONT(fontSize)               [UIFont boldSystemFontOfSize:fontSize]

typedef NS_OPTIONS(NSUInteger, DJTableViewCell_PositionType)
{
    DJTableViewCell_PositionType_None = 0,
    DJTableViewCell_PositionType_First = 1 << 0,
    DJTableViewCell_PositionType_Middle = 1 << 1,
    DJTableViewCell_PositionType_Last = 1 << 2,
    DJTableViewCell_PositionType_ALL = DJTableViewCell_PositionType_First | DJTableViewCell_PositionType_Last,
    DJTableViewCell_PositionType_Single = DJTableViewCell_PositionType_ALL
};

typedef NS_ENUM(NSUInteger, DJTableViewCell_UnderLineDrawType)
{
    DJTableViewCell_UnderLineDrawType_None,
    DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset,
    DJTableViewCell_UnderLineDrawType_SeparatorLeftInset,
    DJTableViewCell_UnderLineDrawType_SeparatorInset,
    DJTableViewCell_UnderLineDrawType_Image,
    DJTableViewCell_UnderLineDrawType_ImageInset,
    DJTableViewCell_UnderLineDrawType_Full
};

NS_ASSUME_NONNULL_BEGIN

typedef void (^tableViewSelectionHandler)(id item);
typedef void (^tableViewAccessoryButtonTapHandler)(id item);
typedef void (^tableViewInsertionHandler)(id item);
typedef void (^tableViewDeletionHandler)(id item);
typedef void (^tableViewDeletionHandlerWithCompletion)(id item, void (^)(void));
typedef BOOL (^tableViewMoveHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
typedef void (^tableViewMoveCompletionHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);

typedef void (^tableViewCutHandler)(id item);
typedef void (^tableViewCopyHandler)(id item);
typedef void (^tableViewPasteHandler)(id item);

// Action bar
typedef void (^tableViewActionBarNavButtonTapHandler)(id item); //handler for nav button on ActionBar
typedef void (^tableViewActionBarDoneButtonTapHandler)(id item); //handler for done button on ActionBar


@protocol RETextCellProtocol <NSObject>

- (void)textFieldDidChanged:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END


#endif /* DJTableViewManagerDefine_h */
