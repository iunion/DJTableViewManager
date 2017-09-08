//
//  RootViewController.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "RootViewController.h"
#import "ControlsViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) DJTableViewManager *manager;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"DJTableViewManager";
    
    //self.tableView.style = UITableViewStyleGrouped;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __typeof (&*self) __weak weakSelf = self;

    // Create manager
    //
    self.manager = [[DJTableViewManager alloc] initWithTableView:self.tableView];
    self.manager.delegate = self;
    
    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];
    
    DJTableViewItem *item1 = [DJTableViewItem itemWithTitle:@"Forms" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(DJTableViewItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        [weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }];
    
    DJTableViewItem *item2 = [DJTableViewItem itemWithTitle:@"List" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(DJTableViewItem *item) {
        [item deselectRowAnimated:YES];
        //[weakSelf.navigationController pushViewController:[[ListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }];
    
    [section addItem:item1];
    [section addItem:item2];
    
    //[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
