//
//  DJTableViewItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DJTableViewManagerDefine.h"

#import "DJImageTextView.h"

@class DJTableViewSection;

NS_ASSUME_NONNULL_BEGIN

@interface DJTableViewItem : NSObject

@property (nullable, nonatomic, weak) DJTableViewSection *section;

// CellStyle
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

// 图标
@property (nullable, nonatomic, strong) UIImage *image;
@property (nullable, nonatomic, strong) NSString *imageUrl;
// 高亮图标
@property (nullable, nonatomic, strong) UIImage *highlightedImage;
@property (nullable, nonatomic, strong) NSString *highlightedImageUrl;
// 限制image的尺寸, 为0时使用图片本身尺寸
@property (nonatomic, assign) CGFloat imageW;
@property (nonatomic, assign) CGFloat imageH;

// 文本
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, strong) NSMutableAttributedString *titleAttrStr;
@property (nullable, nonatomic, copy) NSString *detailLabelText;
@property (nullable, nonatomic, strong) NSMutableAttributedString *detailAttrStr;
// 文本对齐方式，只适用于title，detailLabelText
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) NSTextAlignment detailTextAlignment;
// 文本颜色
@property (nullable, nonatomic, strong) UIColor *textColor;
@property (nullable, nonatomic, strong) UIColor *detailTextColor;
// 字体
@property (nullable, nonatomic, strong) UIFont *textFont;
@property (nullable, nonatomic, strong) UIFont *detailTextFont;
// detailLabel文本行数
@property (nonatomic, assign) NSInteger detailNumberOfLines;

// for UITableViewCellStyleSubtitle with caleCellHeightWithTableView
// 使用caleCellHeightWithTableView计算时的上下间距
@property (nonatomic, assign) CGFloat contentTopBottomGap;
// UITableViewCellStyleSubtitle类型时的title和subTitle间距
@property (nonatomic, assign) CGFloat contentMiddleGap;
// UITableViewCellStyleSubtitle类型时的image位置
@property (nonatomic, assign) DJTableViewCell_SubtitleStyleImageAlignment subtitleStyleImageAlignment;


// 添加aaccessoryView左边额外的img
//@property (nullable, nonatomic, strong) UIImage *aaccessoryExtrImage;
@property (nullable, nonatomic, strong) UIView *accessoryView;

// 下边线
//@property (nonatomic, assign) BOOL isDrawUnderLine;
// 下边线类型
@property (nonatomic, assign) DJTableViewCell_UnderLineDrawType underLineDrawType;
// 下边线颜色
@property (nullable, nonatomic, strong) UIColor *underLineColor;
@property (nonatomic, assign) CGFloat underLineWidth;
@property (nonatomic, assign) BOOL underLineIsDash;

// 显示选择状态
@property (assign, nonatomic) BOOL isShowSelectBg;
// 选择背景颜色
@property (strong, nonatomic, nullable) UIColor *selectBgColor;

// 显示高亮状态
@property (assign, nonatomic) BOOL isShowHighlightBg;
// 高亮背景颜色
@property (strong, nonatomic, nullable) UIColor *highlightBgColor;

@property (nonatomic, assign) BOOL enabled;

// cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@property (nullable, nonatomic, copy) NSString *cellIdentifier;


@property (nullable, nonatomic, copy) tableViewSelectionHandler selectionHandler;

// accessoryType = UITableViewCellAccessoryDetailButton 可用
@property (nullable, nonatomic, copy) tableViewAccessoryButtonTapHandler accessoryButtonTapHandler;

@property (nullable, nonatomic, copy) tableViewInsertionHandler insertionHandler;
@property (nullable, nonatomic, copy) tableViewDeletionHandler deletionHandler;
@property (nullable, nonatomic, copy) tableViewDeletionHandlerWithCompletion deletionHandlerWithCompletion;
@property (nullable, nonatomic, copy) tableViewMoveHandler moveHandler;
@property (nullable, nonatomic, copy) tableViewMoveCompletionHandler moveCompletionHandler;

@property (nullable, nonatomic, copy) tableViewCutHandler cutHandler;
@property (nullable, nonatomic, copy) tableViewCopyHandler copyHandler;
@property (nullable, nonatomic, copy) tableViewPasteHandler pasteHandler;

// Action bar
// handler for nav button on ActionBar
@property (nullable, nonatomic, copy) tableViewActionBarNavButtonTapHandler actionBarNavButtonTapHandler;
// handler for done button on ActionBar
@property (nullable, nonatomic, copy) tableViewActionBarDoneButtonTapHandler actionBarDoneButtonTapHandler;

+ (instancetype)item;
+ (instancetype)itemWithTitle:(nullable NSString *)title;
+ (instancetype)itemWithTitle:(nullable NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(nullable tableViewSelectionHandler)selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(nullable tableViewSelectionHandler)selectionHandler accessoryButtonTapHandler:(nullable tableViewAccessoryButtonTapHandler)accessoryButtonTapHandler;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(nullable tableViewSelectionHandler)selectionHandler;
- (instancetype)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(nullable tableViewSelectionHandler)selectionHandler accessoryButtonTapHandler:(nullable tableViewAccessoryButtonTapHandler)accessoryButtonTapHandler;

+ (instancetype)itemWithTitle:(nullable NSString *)title selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType accessoryView:(nullable UIView *)accessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType accessoryView:(nullable UIView *)accessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType accessoryView:(nullable UIView *)accessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;

- (instancetype)initWithTitle:(nullable NSString *)title selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
- (instancetype)initWithTitle:(nullable NSString *)title underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
- (instancetype)initWithTitle:(nullable NSString *)title underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType accessoryView:(nullable UIView *)accessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
- (instancetype)initWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType accessoryView:(nullable UIView *)accessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
- (instancetype)initWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType accessoryView:(nullable UIView *)accessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;

// DJImageTextView
+ (DJImageTextView *)DefaultAccessoryView;
+ (DJImageTextView *)DefaultAccessoryViewWithClicked:(nullable DJImageTextViewClicked)clicked;

+ (instancetype)itemWithTitle:(NSString *)title useDefaultAccessoryView:(BOOL)useDefaultAccessoryView selectionHandler:(void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType useDefaultAccessoryView:(BOOL)useDefaultAccessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType useDefaultAccessoryView:(BOOL)useDefaultAccessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType useDefaultAccessoryView:(BOOL)useDefaultAccessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;

- (instancetype)initWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType useDefaultAccessoryView:(BOOL)useDefaultAccessoryView selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;

+ (instancetype)itemWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType rightAttributedText:(NSAttributedString *)attributedText rightImage:(nullable NSString *)image  imageTextViewType:(DJImageTextViewType)imageTextViewType selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;

- (instancetype)initWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle imageName:(nullable NSString *)imageName underLineDrawType:(DJTableViewCell_UnderLineDrawType)underLineDrawType rightAttributedText:(NSAttributedString *)attributedText rightImage:(nullable NSString *)image  imageTextViewType:(DJImageTextViewType)imageTextViewType selectionHandler:(nullable void(^)(DJTableViewItem *item))selectionHandler;


- (nullable NSIndexPath *)indexPath;

- (void)selectRowAnimated:(BOOL)animated;
- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectRowAnimated:(BOOL)animated;
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;

- (void)caleCellHeightWithTableView:(UITableView *)tableView;


@end

NS_ASSUME_NONNULL_END
