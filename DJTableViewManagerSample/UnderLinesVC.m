//
//  UnderLinesVC.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/5.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "UnderLinesVC.h"
#import "DJTableViewManager.h"

@interface UnderLinesVC ()

@end

@implementation UnderLinesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"UnderLines";
    
    // 自定义下划线，需要设置 separatorStyle 为 UITableViewCellSeparatorStyleNone
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];
    
    DJTableViewItem *item1 = [DJTableViewItem itemWithTitle:@"SeparatorAllLeftInset"];
    item1.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset;
    item1.underLineColor = [UIColor redColor];
    item1.enabled = YES;
    item1.isShowHighlightBg = NO;
    
    DJTableViewItem *item2 = [DJTableViewItem itemWithTitle:@"SeparatorLeftInset"];
    item2.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorLeftInset;
    item2.underLineColor = [UIColor redColor];
    item2.image = [UIImage imageNamed:@"icon1"];
    item2.accessoryView = [DJTableViewItem DefaultAccessoryView];
    
    DJTableViewItem *item3 = [DJTableViewItem itemWithTitle:@"SeparatorInset"];
    item3.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorInset;
    item3.underLineColor = [UIColor redColor];
    item3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    item3.accessoryView = [DJTableViewItem DefaultAccessoryView];

    DJTableViewItem *item4 = [DJTableViewItem itemWithTitle:@"Image"];
    item4.underLineDrawType = DJTableViewCell_UnderLineDrawType_Image;
    item4.underLineColor = [UIColor redColor];
    item4.image = [UIImage imageNamed:@"icon1"];
    item4.enabled = NO;

    DJTableViewItem *item5 = [DJTableViewItem itemWithTitle:@"ImageInset"];
    item5.underLineDrawType = DJTableViewCell_UnderLineDrawType_ImageInset;
    item5.underLineColor = [UIColor redColor];
    item5.image = [UIImage imageNamed:@"icon2"];
    item5.enabled = NO;

    DJTableViewItem *item6 = [DJTableViewItem itemWithTitle:@"Full"];
    item6.underLineDrawType = DJTableViewCell_UnderLineDrawType_Full;
    item6.underLineColor = [UIColor redColor];
    item6.enabled = NO;

    DJTableViewItem *item7 = [DJTableViewItem itemWithTitle:@"None"];
    item7.underLineDrawType = DJTableViewCell_UnderLineDrawType_None;
    item7.underLineColor = [UIColor redColor];
    item7.enabled = NO;

    DJTableViewItem *item8 = [DJTableViewItem itemWithTitle:@"Default-SeparatorInset"];
    item8.underLineColor = [UIColor redColor];
    item8.enabled = NO;

    [section addItem:item1];
    [section addItem:item2];
    [section addItem:item3];
    [section addItem:item4];
    [section addItem:item5];
    [section addItem:item6];
    [section insertItem:item7 atIndex:0];
    [section addItem:item8];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
