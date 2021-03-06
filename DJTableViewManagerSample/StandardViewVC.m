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
    item1.detailTextAlignment = NSTextAlignmentLeft;

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
    item31.subtitleStyleImageAlignment = DJTableViewCell_SubtitleStyleImageAlignmentTop;
    [item31 caleCellHeightWithTableView:self.tableView];
    item31.underLineColor = [UIColor redColor];

    DJTableViewItem *item32 = [DJTableViewItem itemWithTitle:@"个人介绍:" subTitle:@"UITableView是iOS开发中用的非常多的一个控件，UITableview用来展示列表数据，相当于安卓中的listview。不同于安卓中的listview自定义item来定义列表显示的样式，iOS中系统自带了四种样式在很多场合都够我们使用了。" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item32];
    item32.cellStyle = UITableViewCellStyleSubtitle;
    item32.detailNumberOfLines = 0;
    item32.contentTopBottomGap = 30.0f;
    item32.contentMiddleGap = 20.0f;
    [item32 caleCellHeightWithTableView:self.tableView];
    item32.underLineColor = [UIColor redColor];

    DJTableViewItem *item33 = [DJTableViewItem itemWithTitle:@"个人介绍:" subTitle:@"UITableView是iOS开发中用的非常多的一个控件，UITableview用来展示列表数据，相当于安卓中的listview。不同于安卓中的listview自定义item来定义列表显示的样式，iOS中系统自带了四种样式在很多场合都够我们使用了。" imageName:@"icon2" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset accessoryView:nil selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    [section addItem:item33];
    item33.cellStyle = UITableViewCellStyleSubtitle;
    item33.detailNumberOfLines = 0;
    item33.contentTopBottomGap = 30.0f;
    item33.contentMiddleGap = 20.0f;
    item33.subtitleStyleImageAlignment = DJTableViewCell_SubtitleStyleImageAlignmentBottom;
    [item33 caleCellHeightWithTableView:self.tableView];
    item33.underLineColor = [UIColor redColor];
    
    DJImageDetailItem *item4 = [DJImageDetailItem itemWithTitle:@"测试:" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    item4.image = [UIImage imageNamed:@"icon2"];
    item4.cellStyle = UITableViewCellStyleValue1;
    item4.detailLabelText = @"dsgs.doc";
    item4.detailImage = @"Card_Stack";
    item4.underLineColor = [UIColor redColor];
    [section addItem:item4];
    
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"Card_Stack"];
    attch.bounds = CGRectMake(0, -4, 20, 20);
    // 创建带有图片的富文本
    NSAttributedString *phoneString = [NSAttributedString attributedStringWithAttachment:attch];
    [allString appendAttributedString:phoneString];
    NSMutableAttributedString *numberString = [[NSMutableAttributedString alloc] initWithString:@" 186******38"];
    [numberString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, numberString.string.length)];
    [allString appendAttributedString:numberString];

    DJImageDetailItem *item41 = [DJImageDetailItem itemWithTitle:@"测试测试测试:" underLineDrawType:DJTableViewCell_UnderLineDrawType_SeparatorInset selectionHandler:^(DJTableViewItem * _Nonnull item) {
        
    }];
    item41.image = [UIImage imageNamed:@"icon2"];
    item41.cellStyle = UITableViewCellStyleValue1;
    item41.detailAttrStr = allString;
    //item41.detailLabelText = @"dsgs.doc";
    //item41.detailImage = @"Card_Stack";
    item41.underLineColor = [UIColor redColor];
    [section addItem:item41];
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
