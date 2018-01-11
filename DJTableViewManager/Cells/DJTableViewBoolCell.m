//
//  DJTableViewBoolCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/11.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewBoolCell.h"
#import "DJTableViewManager.h"
#import "DJBoolItem.h"

@interface DJTableViewBoolCell ()

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL switchable;

@property (nonatomic, strong) DJBoolItem *item;
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation DJTableViewBoolCell
@synthesize item = _item;

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"switchable"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.switchView = [[UISwitch alloc] init];
    self.switchView.exclusiveTouch = YES;
    [self.switchView addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchView];
    
    CGFloat margin = (self.section.style.contentViewMargin <= 0) ? 15.0f : 10.0f;
    [self.switchView centerVerticallyInSuperViewWithLeft:self.contentView.width-self.switchView.width-margin];
    self.switchView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
 
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;

    self.switchView.on = self.item.value;
    
    self.enabled = self.item.enabled;
    self.switchable = self.item.switchable;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    if (self.textLabel.frame.origin.x + self.textLabel.frame.size.width >= self.switchView.frame.origin.x)
    {
        self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.switchView.frame.size.width - self.section.style.contentViewMargin - 10.0f, self.textLabel.frame.size.height);
    }
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)setItem:(DJBoolItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"switchable"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"switchable" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.switchView.enabled = _enabled;
}

- (void)setSwitchable:(BOOL)enabled
{
    if (!_enabled)
    {
        NSLog(@"Cell is disabled");
        enabled = NO;
    }
    
    _switchable = enabled;
    
    self.userInteractionEnabled = _switchable;
    self.switchView.userInteractionEnabled = _switchable;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJBoolItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
    else if ([object isKindOfClass:[DJTextItem class]] && [keyPath isEqualToString:@"switchable"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.switchable = newValue;
    }
}

- (void)switchValueDidChange:(UISwitch *)switchView
{
    self.item.value = switchView.isOn;
    if (self.item.valueChangeHandler)
    {
        self.item.valueChangeHandler(self.item);
    }
}

@end
