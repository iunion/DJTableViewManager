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
    
    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
