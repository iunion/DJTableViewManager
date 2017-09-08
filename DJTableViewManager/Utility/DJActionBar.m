//
//  DJActionBar.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/7.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJActionBar.h"
#import "DJTableViewManager.h"

@interface DJActionBar ()

@property (strong, nonatomic) UISegmentedControl *navigationControl;

@end

@implementation DJActionBar

- (instancetype)initWithDelegate:(id<DJActionBarDelegate>)delegate
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    [self sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleActionBarDone:)];
    
    self.navigationControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    self.navigationControl.momentary = YES;
    [self.navigationControl addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationControl setImage:[UIImage imageNamed:@"UIButtonBarArrowLeft"] forSegmentAtIndex:0];
    [self.navigationControl setImage:[UIImage imageNamed:@"UIButtonBarArrowRight"] forSegmentAtIndex:1];
    
    [self.navigationControl setDividerImage:[[UIImage alloc] init]
                        forLeftSegmentState:UIControlStateNormal
                          rightSegmentState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];
    
    [self.navigationControl setBackgroundImage:[UIImage imageNamed:@"Transparent"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.navigationControl setWidth:40.0f forSegmentAtIndex:0];
    [self.navigationControl setWidth:40.0f forSegmentAtIndex:1];
    [self.navigationControl setContentOffset:CGSizeMake(-4, 0) forSegmentAtIndex:0];
    
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:self.navigationControl];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    self.actionBarDelegate = delegate;
    
    return self;
}

- (void)handleActionBarPreviousNext:(UISegmentedControl *)segmentedControl
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:navigationControlValueChanged:)])
    {
        [self.actionBarDelegate actionBar:self navigationControlValueChanged:segmentedControl];
    }
}

- (void)handleActionBarDone:(UIBarButtonItem *)doneButtonItem
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:doneButtonPressed:)])
    {
        [self.actionBarDelegate actionBar:self doneButtonPressed:doneButtonItem];
    }
}

@end
