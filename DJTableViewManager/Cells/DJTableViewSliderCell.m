//
//  DJTableViewSliderCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/3/19.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewSliderCell.h"
#import "DJTableViewManager.h"
#import "DJSliderItem.h"

#define sliderViewHeight        (24.0f)

@interface DJTableViewSliderCell ()

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL sliderable;

@property (nonatomic, strong) DJSliderItem *item;

@property (nonatomic, strong) UISlider *sliderView;

@end

@implementation DJTableViewSliderCell
@synthesize item = _item;

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"sliderable"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.sliderView = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 100.0f, sliderViewHeight)];
    [self.sliderView addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:self.sliderView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.sliderView.value = self.item.sliderValue;
    
    self.enabled = self.item.enabled;
    self.sliderable = self.item.sliderable;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];

    CGFloat cellOffset = 4.0;
    if (self.section.style.contentViewMargin <= 0)
    {
        cellOffset += 4.0f;
    }
    
    self.sliderView.frame = CGRectMake(self.contentView.frame.size.width - self.item.sliderWidth - cellOffset, (self.contentView.frame.size.height - sliderViewHeight) * 0.5f, self.item.sliderWidth, sliderViewHeight);
    
    if (self.textLabel.frame.origin.x + self.textLabel.frame.size.width >= self.sliderView.frame.origin.x)
    {
        self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.sliderView.frame.size.width - self.section.style.contentViewMargin - cellOffset, self.textLabel.frame.size.height);
    }
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(DJSliderItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"sliderable"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"sliderable" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.sliderView.enabled = _enabled;
}

- (void)setSliderable:(BOOL)enabled
{
    if (!_enabled)
    {
        NSLog(@"Cell is disabled");
        enabled = NO;
    }
    
    _sliderable = enabled;
    
    self.userInteractionEnabled = _sliderable;
    self.sliderView.userInteractionEnabled = _sliderable;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJSliderItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
    else if ([object isKindOfClass:[DJSliderItem class]] && [keyPath isEqualToString:@"sliderable"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.sliderable = newValue;
    }
}

- (void)sliderValueDidChange:(UISlider *)sliderView
{
    self.item.sliderValue = sliderView.value;
    if (self.item.valueChangeHandler)
    {
        self.item.valueChangeHandler(self.item);
    }
}

@end
