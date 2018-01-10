//
//  AccessoryViewVC.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/5.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "AccessoryViewVC.h"

@interface AccessoryViewVC ()

@end

@implementation AccessoryViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"AccessoryView";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];
    
    NSString *string = [NSString stringWithFormat:@"%@人", @"100"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString setFont:UI_DJ_FONT(14.0f)];
    [attributedString setFont:UI_NUMBER_FONT(14.0f) range:NSMakeRange(0, 3)];
    [attributedString setTextColor:[UIColor grayColor]];
    [attributedString setTextColor:[UIColor redColor] range:NSMakeRange(0, 3)];

    DJImageTextView *imageTextView = [[DJImageTextView alloc] initWithAttributedText:attributedString image:@"arrows_rightBlack"];
    imageTextView.imageTextViewClicked = ^(DJImageTextView * imageTextView) {
        NSLog(@"ImageTextView Clicked");
    };

    DJTableViewItem *item1 = [DJTableViewItem itemWithTitle:@"人数" imageName:nil underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset accessoryView:imageTextView selectionHandler:^(DJTableViewItem *item) {
        NSLog(@"Cell Clicked");
    }];
    item1.enabled = YES;
    //item1.isShowHighlightBg = NO;

    imageTextView = [[DJImageTextView alloc] initWithAttributedText:attributedString image:nil];
    imageTextView.imageTextViewClicked = ^(DJImageTextView * imageTextView) {
        NSLog(@"ImageTextView Clicked");
    };
    imageTextView.showTableCellAccessoryArrow = YES;
    DJTableViewItem *item2 = [DJTableViewItem itemWithTitle:@"人数" imageName:nil underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset accessoryView:imageTextView selectionHandler:^(DJTableViewItem *item) {
        NSLog(@"Cell Clicked");
    }];

    attributedString = [[NSMutableAttributedString alloc] initWithString:@"给你100"];
    [attributedString setFont:UI_DJ_FONT(14.0f)];
    [attributedString setFont:UI_NUMBER_FONT(14.0f) range:NSMakeRange(2, 3)];
    [attributedString setTextColor:[UIColor grayColor]];
    [attributedString setTextColor:[UIColor redColor] range:NSMakeRange(2, 3)];
    imageTextView = [[DJImageTextView alloc] initWithAttributedText:attributedString image:@"icon2"];
    imageTextView.imageTextViewClicked = ^(DJImageTextView * imageTextView) {
        NSLog(@"不给钱");
    };
    imageTextView.type = DJImageTextViewType_ImageLeft;
    imageTextView.showTableCellAccessoryArrow = YES;
    
    DJTableViewItem *item3 = [DJTableViewItem itemWithTitle:@"拿钱来" imageName:nil underLineDrawType:DJTableViewCell_UnderLineDrawType_Full accessoryView:imageTextView selectionHandler:^(DJTableViewItem * _Nonnull item) {
        NSLog(@"给钱了");
    }];

    [section addItem:item1];
    [section addItem:item2];
    [section addItem:item3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
