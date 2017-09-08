//
//  DJTableViewItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/4/20.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"
#import "DJTableViewManager.h"
#import "DJTableViewSection.h"

@implementation DJTableViewItem

+ (instancetype)item
{
    return [[self alloc] init];
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(tableViewSelectionHandler)selectionHandler
{
    return [[self alloc] initWithTitle:title accessoryType:accessoryType selectionHandler:selectionHandler accessoryButtonTapHandler:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(tableViewSelectionHandler)selectionHandler accessoryButtonTapHandler:(tableViewAccessoryButtonTapHandler)accessoryButtonTapHandler
{
    return [[self alloc] initWithTitle:title accessoryType:accessoryType selectionHandler:selectionHandler accessoryButtonTapHandler:accessoryButtonTapHandler];
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title accessoryType:UITableViewCellAccessoryNone selectionHandler:nil accessoryButtonTapHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(tableViewSelectionHandler)selectionHandler
{
    return [self initWithTitle:title accessoryType:accessoryType selectionHandler:selectionHandler accessoryButtonTapHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(tableViewSelectionHandler)selectionHandler accessoryButtonTapHandler:(tableViewAccessoryButtonTapHandler)accessoryButtonTapHandler
{
    self = [self init];
    
    if (!self)
    {
        return nil;
    }
    
    self.title = title;
    self.accessoryType = accessoryType;
    self.selectionHandler = selectionHandler;
    self.accessoryButtonTapHandler = accessoryButtonTapHandler;
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.enabled = YES;
        
        self.cellHeight = 0.0f;
        
        self.cellStyle = UITableViewCellStyleDefault;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.editingStyle = UITableViewCellEditingStyleNone;
        
        self.textColor = [UIColor darkGrayColor];
        self.detailTextColor = [UIColor grayColor];
        self.textFont = [UIFont systemFontOfSize:16.0f];
        self.detailTextFont = [UIFont systemFontOfSize:12.0f];
        self.textAlignment = NSTextAlignmentLeft;
        self.detailTextAlignment = NSTextAlignmentLeft;
        
        self.isDrawUnderLine = YES;
        self.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorInset;
        self.underLineColor = UI_DEFAULT_LINECOLOR;
        
        self.isShowSelectBg = NO;
        self.selectBgColor = UI_CELL_SELECT_BGCOLOR;
        self.isShowHighlightBg = YES;
        self.highlightBgColor = [UI_CELL_HIGHLIGHT_BGCOLOR colorWithAlphaComponent:0.15];
    }
    
    return self;
}

- (NSIndexPath *)indexPath
{
    return [NSIndexPath indexPathForRow:[self.section.items indexOfObject:self] inSection:self.section.index];
}


#pragma mark -
#pragma mark Manipulating table view row

- (void)selectRowAnimated:(BOOL)animated
{
    [self selectRowAnimated:animated scrollPosition:UITableViewScrollPositionNone];
}

- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    [self.section.tableViewManager.tableView selectRowAtIndexPath:self.indexPath animated:animated scrollPosition:scrollPosition];
}

- (void)deselectRowAnimated:(BOOL)animated
{
    [self.section.tableViewManager.tableView deselectRowAtIndexPath:self.indexPath animated:animated];
}

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation
{
    [self.section.tableViewManager.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}

- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation
{
    DJTableViewSection *section = self.section;
    NSInteger row = self.indexPath.row;
    [section removeItemAtIndex:self.indexPath.row];
    [section.tableViewManager.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section.index]] withRowAnimation:animation];
}

@end
