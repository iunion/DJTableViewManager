//
//  DJTableViewSegmentCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/17.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewSegmentCell.h"
#import "DJTableViewManager.h"
#import "DJSegmentItem.h"

@interface DJTableViewSegmentCell ()

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL segmentable;
@property (nonatomic, strong) NSArray *disableItems;

@property (nonatomic, strong) DJSegmentItem *item;

@property (nonatomic, strong) UISegmentedControl *segmentView;

@end

@implementation DJTableViewSegmentCell
@synthesize item = _item;

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"segmentable"];
        [_item removeObserver:self forKeyPath:@"disableItems"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.segmentView = [[UISegmentedControl alloc] initWithItems:nil];
    self.segmentView.exclusiveTouch = YES;
    [self.segmentView addTarget:self action:@selector(segmentValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.segmentView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    [self.segmentView removeAllSegments];
    if ([self.item.segmentedItems isNotEmpty])
    {
        [self.item.segmentedItems enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
            if ([item isNotKindOfClass:[NSString class]])
            {
                NSString *title = (NSString *)item;
                [self.segmentView insertSegmentWithTitle:title atIndex:idx animated:NO];
            }
            else if ([item isNotKindOfClass:[UIImage class]])
            {
                UIImage *image = (UIImage *)item;
                [self.segmentView insertSegmentWithImage:image atIndex:idx animated:NO];
            }
        }];
    }
    [self.segmentView setSelectedSegmentIndex:self.item.selectedSegmentIndex];
    
    self.segmentView.tintColor = self.item.tintColor;

    self.disableItems = self.item.disableItems;

    self.enabled = self.item.enabled;
    self.segmentable = self.item.segmentable;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    CGFloat margin = (self.section.style.contentViewMargin <= 0) ? 15.0f : 10.0f;
    [self.segmentView centerVerticallyInSuperViewWithLeft:self.contentView.width-self.segmentView.width-margin];
    //self.segmentView.left = self.contentView.width - self.segmentView.width;
    
    if (self.textLabel.frame.origin.x + self.textLabel.frame.size.width >= self.segmentView.frame.origin.x)
    {
        self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.segmentView.frame.size.width - self.section.style.contentViewMargin - 10.0f, self.textLabel.frame.size.height);
    }
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)setItem:(DJSegmentItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"segmentable"];
        [_item removeObserver:self forKeyPath:@"disableItems"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"segmentable" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"disableItems" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.segmentView.enabled = _enabled;
}

- (void)setSegmentable:(BOOL)enabled
{
    if (!_enabled)
    {
        NSLog(@"Cell is disabled");
        enabled = NO;
    }
    
    _segmentable = enabled;
    
    self.userInteractionEnabled = _segmentable;
    self.segmentView.userInteractionEnabled = _segmentable;
}

- (void)setDisableItems:(NSArray *)disableItems
{
    _disableItems = disableItems;
    
    for (NSUInteger index=0; index<self.segmentView.numberOfSegments; index++)
    {
        [self.segmentView setEnabled:YES forSegmentAtIndex:index];
    }
    if ([_disableItems isNotEmpty])
    {
        [_disableItems enumerateObjectsUsingBlock:^(NSNumber *item, NSUInteger idx, BOOL *stop) {
            [self.segmentView setEnabled:NO forSegmentAtIndex:item.unsignedIntegerValue];
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJSegmentItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
    else if ([object isKindOfClass:[DJSegmentItem class]] && [keyPath isEqualToString:@"segmentable"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.segmentable = newValue;
    }
    else if ([object isKindOfClass:[DJSegmentItem class]] && [keyPath isEqualToString:@"disableItems"])
    {
        self.disableItems = [change objectForKey: NSKeyValueChangeNewKey];
    }
}

- (void)segmentValueDidChange:(UISegmentedControl *)segmentedControl
{
    self.item.selectedSegmentIndex = segmentedControl.selectedSegmentIndex;
    if (self.item.valueChangeHandler)
    {
        self.item.valueChangeHandler(self.item);
    }
}


@end
