//
//  ControlsViewController.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController ()

@end

@implementation ControlsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Controls";
    
    __typeof (&*self) __weak weakSelf = self;
    
    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];
    
    DJTableViewItem *item1 = [DJTableViewItem itemWithTitle:@"Forms" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(DJTableViewItem *item) {
        //[item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        //[weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }];
    item1.image = [UIImage imageNamed:@"icon1"];
    
    DJTableViewItem *item2 = [DJTableViewItem itemWithTitle:@"List" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(DJTableViewItem *item) {
        [item deselectRowAnimated:YES];
        //[weakSelf.navigationController pushViewController:[[ListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }];
    item2.image = [UIImage imageNamed:@"icon2"];

    [section addItem:item1];
    [section addItem:item2];

    DJTableViewSection *section1 = [DJTableViewSection section];
    [self.manager addSection:section1];
    
    DJTableViewItem *item3 = [DJTableViewItem itemWithTitle:@"Forms" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(DJTableViewItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        //[weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }];
    
    DJTableViewItem *item4 = [DJTableViewItem itemWithTitle:@"List" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(DJTableViewItem *item) {
        [item deselectRowAnimated:YES];
        //[weakSelf.navigationController pushViewController:[[ListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }];
    
    DJTextItem *item5 = [DJTextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"];
    item5.charactersLimit = 6;
    
    DJMaskTextItem *item6 = [DJMaskTextItem itemWithTitle:@"PhoneNum" value:nil placeholder:@"xxx-xxxx-xxxx" maskPattern:@"(\\d{3})-(\\d{4})-(\\d{4})" maskPlaceholder:@"_"];

    DJNumberTextItem *item7 = [DJNumberTextItem itemWithTitle:@"NumberText" numberValue:nil placeholder:@"0.00"];
    item7.showWithDecimalStyle = YES;


    [section1 addItem:item3];
    [section1 addItem:item4];
    [section1 addItem:item5];
    [section1 addItem:item6];
    [section1 addItem:item7];
    
    DJBoolItem *item8 = [DJBoolItem itemWithTitle:@"外星人?" value:NO switchValueChangeHandler:^(DJBoolItem *item){
        NSLog(@"switchValueChanged %@", @(item.value));
    }];
    [section1 addItem:item8];

    
    DJTableViewSection *section2 = [DJTableViewSection section];
    [self.manager addSection:section2];

}

@end
