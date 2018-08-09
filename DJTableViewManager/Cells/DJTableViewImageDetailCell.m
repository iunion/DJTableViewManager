//
//  DJTableViewImageDetailCell.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/7/30.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewImageDetailCell.h"
#import "DJImageDetailItem.h"
#import "UIImageView+WebCache.h"

@interface DJTableViewImageDetailCell ()

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, strong) DJImageDetailItem *item;

@property (nonatomic, strong) UIImageView *detailImageView;

@end

@implementation DJTableViewImageDetailCell
@synthesize item = _item;

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [self.contentView addSubview:self.detailImageView];

    self.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.detailImageView.image = nil;
    if (self.item.detailImage)
    {
        self.detailImageView.image = [UIImage imageNamed:self.item.detailImage];
    }
    if (!self.detailImageView.image)
    {
        [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:self.item.detailImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [self setNeedsLayout];
             if (self.item.imageLoadedHandler)
             {
                 self.item.imageLoadedHandler(self.item);
             }
         }];
    }
    
    self.detailImageView.size = CGSizeMake(self.item.detailImageWidth, self.item.detailImageWidth);
    
    self.enabled = self.item.enabled;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    [self layoutDetailView:self.detailTextLabel minimumWidth:100.0f];
}

- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth
{
    [super layoutDetailView:view minimumWidth:minimumWidth];
    
    if (self.detailImageView.image)
    {
        self.detailImageView.left = view.left;
        self.detailImageView.centerY = view.centerY;
    
        view.left = self.detailImageView.left + self.detailImageView.width + self.item.imageDetailGap;
        view.width = view.width - (self.detailImageView.width + self.item.imageDetailGap);
    }
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(DJImageDetailItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.detailTextLabel.enabled = _enabled;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJImageDetailItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
}

@end
