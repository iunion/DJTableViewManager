//
//  SuperVC.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/5.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJTableViewManager.h"

@interface SuperVC : UITableViewController
<
    DJTableViewManagerDelegate
>

@property (nonatomic, strong) DJTableViewManager *manager;

@end
