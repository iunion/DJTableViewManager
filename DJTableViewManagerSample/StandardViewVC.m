//
//  StandardViewVC.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/6/25.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "StandardViewVC.h"

@interface StandardViewVC ()

@end

@implementation StandardViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"StandardView";
    
    // 自定义下划线，需要设置 separatorStyle 为 UITableViewCellSeparatorStyleNone
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];

    DJTableViewItem *item0 = [DJTableViewItem itemWithTitle:@"姓名:" subTitle:@"XXX" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item0];
    item0.cellStyle = UITableViewCellStyleDefault;
    item0.cellHeight = 80;
    item0.underLineColor = [UIColor redColor];

    DJTableViewItem *item1 = [DJTableViewItem itemWithTitle:@"姓名:" subTitle:@"XXX" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item1];
    item1.cellStyle = UITableViewCellStyleValue1;
    item1.cellHeight = 80;
    item1.underLineColor = [UIColor redColor];

    DJTableViewItem *item2 = [DJTableViewItem itemWithTitle:@"姓名:" subTitle:@"XXX" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item2];
    item2.cellStyle = UITableViewCellStyleValue2;
    item2.cellHeight = 80;
    item2.underLineColor = [UIColor redColor];

    DJTableViewItem *item21 = [DJTableViewItem itemWithTitle:@"个人介绍:" subTitle:@"XXX" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item21];
    item21.cellStyle = UITableViewCellStyleValue2;
    item21.textAlignment = NSTextAlignmentRight;
    item21.cellHeight = 80;
    item21.underLineColor = [UIColor redColor];

    DJTableViewItem *item3 = [DJTableViewItem itemWithTitle:@"姓名:" subTitle:@"XXX" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item3];
    item3.contentMiddleGap = 20.0f;
    item3.cellStyle = UITableViewCellStyleSubtitle;
    item3.cellHeight = 100;
    item3.underLineColor = [UIColor redColor];

    DJTableViewItem *item31 = [DJTableViewItem itemWithTitle:@"个人介绍:" subTitle:@"UITableView是iOS开发中用的非常多的一个控件，UITableview用来展示列表数据，相当于安卓中的listview。不同于安卓中的listview自定义item来定义列表显示的样式，iOS中系统自带了四种样式在很多场合都够我们使用了。" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item31];
    item31.cellStyle = UITableViewCellStyleSubtitle;
    item31.detailNumberOfLines = 0;
    item31.contentTopBottomGap = 30.0f;
    item31.contentMiddleGap = 20.0f;
    [item31 caleCellHeightWithTableView:self.tableView];
    item31.underLineColor = [UIColor redColor];
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
