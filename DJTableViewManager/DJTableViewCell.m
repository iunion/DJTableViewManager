//
//  DJTableViewCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/7.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"
#import "DJTableViewManager.h"
#import "DJTableViewItem.h"

#import "DJSingleLineView.h"

#import "UIImageView+WebCache.h"

#define Default_Text_Color          [UIColor colorWithHex:0x666666]
#define Default_Text_Font           [UIFont systemFontOfSize:16.0f]

#define Default_DetailText_Color    [UIColor colorWithHex:0x888888]
#define Default_DetailText_Font     [UIFont systemFontOfSize:14.0f]

#define IMAGE_LABLE_GAP     8.0f

@interface DJTableViewCell ()

@property (assign, readwrite, nonatomic) BOOL loaded;
@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (strong, readwrite, nonatomic) UIImageView *selectedBackgroundImageView;

@property (strong, readwrite, nonatomic) DJSingleLineView *singleLineView;

@end

@implementation DJTableViewCell

+ (CGFloat)heightWithItem:(DJTableViewItem *)item tableViewManager:(DJTableViewManager *)tableViewManager
{
    CGFloat cellHeight = 0;
    if ([item isKindOfClass:[DJTableViewItem class]])
    {
        if (item.cellHeight > 0)
        {
            cellHeight = item.cellHeight;
        }
        else if (item.cellHeight == 0)
        {
            cellHeight = item.section.style.cellHeight;
        }
    }
    
    if (cellHeight == 0)
    {
        cellHeight = tableViewManager.style.cellHeight;
    }
    
    return cellHeight;
}

+ (BOOL)canFocusWithItem:(DJTableViewItem *)item
{
    return NO;
}


#pragma mark - UI

- (void)addBackgroundImage
{
    self.tableViewManager.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height + 1)];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.backgroundView addSubview:self.backgroundImageView];
}

- (void)addSelectedBackgroundImage
{
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.selectedBackgroundView.bounds.size.width, self.selectedBackgroundView.bounds.size.height + 1)];
    self.selectedBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.selectedBackgroundView addSubview:self.selectedBackgroundImageView];
}

- (void)drawSingleLineView
{
    if (self.tableViewManager.tableView.separatorStyle != UITableViewCellSeparatorStyleNone)
    {
        return;
    }
    
    if (!self.singleLineView.superview)
    {
        CGRect frame = CGRectMake(0, 0, self.contentView.width, 1);
        self.singleLineView = [[DJSingleLineView alloc] initWithFrame:frame];
        self.singleLineView.needGap = NO;
        [self addSubview:self.singleLineView];
    }
    
    if (self.item.underLineColor)
    {
        self.singleLineView.lineColor = self.item.underLineColor;
    }
    else
    {
        self.singleLineView.lineColor = UI_DEFAULT_LINECOLOR;
    }
    self.singleLineView.bottom = self.contentView.height;
    
    self.singleLineView.hidden = !self.item.isDrawUnderLine;
}

- (DJTableViewCell_PositionType)positionType
{
    if (self.rowIndex == 0 && self.section.items.count == 1)
    {
        return DJTableViewCell_PositionType_Single;
    }
    
    if (self.rowIndex == 0 && self.section.items.count > 1)
    {
        return DJTableViewCell_PositionType_First;
    }
    
    if (self.rowIndex > 0 && self.rowIndex < self.section.items.count - 1 && self.section.items.count > 2)
    {
        return DJTableViewCell_PositionType_Middle;
    }
    
    if (self.rowIndex == self.section.items.count - 1 && self.section.items.count > 1)
    {
        return DJTableViewCell_PositionType_Last;
    }
    
    return DJTableViewCell_PositionType_None;
}

#pragma mark -
#pragma mark Cell life cycle

- (void)cellDidLoad
{
    self.loaded = YES;
    
    self.actionBar = [[DJActionBar alloc] initWithDelegate:self];
    
    self.selectionStyle = self.tableViewManager.style.defaultCellSelectionStyle;
    
    if ([self.tableViewManager.style hasCustomBackgroundImage])
    {
        [self addBackgroundImage];
    }
    
    if ([self.tableViewManager.style hasCustomSelectedBackgroundImage])
    {
        [self addSelectedBackgroundImage];
    }
}

- (void)cellWillAppear
{
    [self updateActionBarNavigationControl];
    
    self.selectionStyle = self.section.style.defaultCellSelectionStyle;
    
    if ([self.item isKindOfClass:[NSString class]])
    {
        self.textLabel.text = (NSString *)self.item;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        DJTableViewItem *item = (DJTableViewItem *)self.item;
        
        if (item.titleAttrStr)
        {
            self.textLabel.attributedText = item.titleAttrStr;
        }
        else
        {
            self.textLabel.text = item.title;

            if (item.textFont)
            {
                self.textLabel.font = item.textFont;
            }
            else
            {
                self.textLabel.font = Default_Text_Font;
            }

            self.textLabel.backgroundColor = [UIColor clearColor];

            if (item.textColor)
            {
                self.textLabel.textColor = item.textColor;
            }
            else
            {
                self.textLabel.textColor = Default_Text_Color;
            }
        }
        self.textLabel.textAlignment = item.textAlignment;
        
        if (item.detailAttrStr)
        {
            self.detailTextLabel.attributedText = item.detailAttrStr;
        }
        else
        {
            self.detailTextLabel.text = item.detailLabelText;
            
            if (item.detailTextFont)
            {
                self.detailTextLabel.font = item.detailTextFont;
            }
            else
            {
                self.detailTextLabel.font = Default_DetailText_Font;
            }

            self.detailTextLabel.backgroundColor = [UIColor clearColor];
            
            if (item.detailTextColor)
            {
                self.detailTextLabel.textColor = item.detailTextColor;
            }
            else
            {
                self.detailTextLabel.textColor = Default_DetailText_Color;
            }
        }
        self.detailTextLabel.textAlignment = item.detailTextAlignment;
        
        self.accessoryType = item.accessoryType;
        self.accessoryView = item.accessoryView;
        
        if (self.selectionStyle != UITableViewCellSelectionStyleNone)
        {
            self.selectionStyle = item.selectionStyle;
        }
        
        self.imageView.image = item.image;
        if (item.imageUrl)
        {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:item.image options:SDWebImageRetryFailed|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
        
        self.imageView.highlightedImage = item.highlightedImage;
        if (item.highlightedImageUrl)
        {
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:item.highlightedImageUrl] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
            } completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (image)
                    {
                        self.imageView.highlightedImage = image;
                    }
                });
            }];
        }
        
        [self drawSingleLineView];
        
        if (![self.tableViewManager.style hasCustomBackgroundImage])
        {
            if (self.item.isShowSelectBg)
            {
                self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
                self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
                UIView *view = [[UIView alloc] initWithFrame:self.bounds];
                view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

                if (self.item.isDrawUnderLine)
                {
                    view.height = self.height-1;
                }
                else
                {
                    view.height = self.height;
                }
                view.backgroundColor = self.item.selectBgColor;
                
                [self.selectedBackgroundView addSubview:view];
            }
            else
            {
                self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
                self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            }
        }
        
        self.userInteractionEnabled = self.item.enabled;
    }
    
    if (self.textLabel.text.length == 0)
    {
        self.textLabel.text = @" ";
    }
}

- (void)cellDidDisappear
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Set content frame
    //
    CGRect contentFrame = self.contentView.bounds;
    contentFrame.origin.x = contentFrame.origin.x + self.section.style.contentViewMargin;
    contentFrame.size.width = contentFrame.size.width - self.section.style.contentViewMargin * 2;
    self.contentView.bounds = contentFrame;
    
    // iOS 7 textLabel margin fix
    //
    if (self.section.style.contentViewMargin > 0)
    {
        if (self.imageView.image)
        {
            self.imageView.frame = CGRectMake(self.section.style.contentViewMargin, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
            self.textLabel.frame = CGRectMake(self.section.style.contentViewMargin + self.imageView.frame.size.width + IMAGE_LABLE_GAP, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
        }
        else
        {
            self.textLabel.frame = CGRectMake(self.section.style.contentViewMargin, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
        }
    }
    else
    {
        if (self.imageView.image)
        {
            if (self.item.imageW > 0 && self.item.imageH > 0)
            {
                self.imageView.width = self.item.imageW;
                self.imageView.height = self.item.imageH;
                self.imageView.centerY = self.height * 0.5;
            }
            
            CGFloat width = self.imageView.width;
            
            self.textLabel.left = self.imageView.left + width + IMAGE_LABLE_GAP;
            
            if (self.item.cellStyle == UITableViewCellStyleSubtitle)
            {
                self.detailTextLabel.left = self.textLabel.left;
            }
        }
    }
    
    if (self.tableViewManager.tableView.separatorStyle == UITableViewCellSeparatorStyleNone)
    {
        UIEdgeInsets separatorInset = self.tableViewManager.tableView.separatorInset;
        self.singleLineView.left = separatorInset.left;
        self.singleLineView.bottom = self.contentView.height;
        
        if ([self.item isKindOfClass:[DJTableViewItem class]])
        {
            switch (self.item.underLineDrawType)
            {
                case DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset:
                {
                    self.singleLineView.width = self.width - separatorInset.left*2;
                    break;
                }
                case DJTableViewCell_UnderLineDrawType_Image:
                {
                    self.singleLineView.left = self.textLabel.left;
                    self.singleLineView.width = self.width - self.textLabel.left;
                    break;
                }
                case DJTableViewCell_UnderLineDrawType_ImageInset:
                {
                    self.singleLineView.left = self.textLabel.left;
                    self.singleLineView.width = self.width - separatorInset.left - self.textLabel.left;
                    break;
                }
                case DJTableViewCell_UnderLineDrawType_SeparatorInset:
                {
                    self.singleLineView.width = self.contentView.width - separatorInset.left - separatorInset.right;
                    break;
                }
                case DJTableViewCell_UnderLineDrawType_SeparatorLeftInset:
                {
                    self.singleLineView.width = self.width - separatorInset.left;
                    break;
                }
                case DJTableViewCell_UnderLineDrawType_Full:
                {
                    self.singleLineView.left = 0;
                    self.singleLineView.width = self.width;
                    break;
                }
            }
        }
    }
    
    if ([self.section.style hasCustomBackgroundImage])
    {
        self.backgroundColor = [UIColor clearColor];
        if (!self.backgroundImageView)
        {
            [self addBackgroundImage];
        }
        self.backgroundImageView.image = [self.section.style backgroundImageForCellPositionType:self.positionType];
    }
    
    if ([self.section.style hasCustomSelectedBackgroundImage])
    {
        if (!self.selectedBackgroundImageView)
        {
            [self addSelectedBackgroundImage];
        }
        self.selectedBackgroundImageView.image = [self.section.style selectedBackgroundImageForCellPositionType:self.positionType];
    }
    
    // Set background frame
    //
    CGRect backgroundFrame = self.backgroundImageView.frame;
    backgroundFrame.origin.x = self.section.style.backgroundImageMargin;
    backgroundFrame.size.width = self.backgroundView.frame.size.width - self.section.style.backgroundImageMargin * 2;
    self.backgroundImageView.frame = backgroundFrame;
    self.selectedBackgroundImageView.frame = backgroundFrame;
}

- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth
{
    CGFloat cellOffset = 10.0;
    CGFloat fieldOffset = 6.0;
    
    if (self.section.style.contentViewMargin <= 0)
    {
        cellOffset += 5.0;
    }
    
    UIFont *font = self.textLabel.font;
    
    CGRect frame = CGRectMake(0, self.textLabel.frame.origin.y, 0, self.textLabel.frame.size.height);
    if (self.item.title.length > 0)
    {
        frame.origin.x = [self.section maximumTitleWidthWithFont:font] + cellOffset + fieldOffset;
    }
    else if (self.item.titleAttrStr.length > 0)
    {
        frame.origin.x = [self.section maximumTitleWidthWithFont:font] + cellOffset + fieldOffset;
    }
    else
    {
        //frame.origin.x = cellOffset;
        if (self.imageView.image)
        {
            frame.origin.x = self.imageView.right + fieldOffset;
        }
        else
        {
            frame.origin.x = cellOffset;
        }
    }
    frame.size.width = self.contentView.frame.size.width - frame.origin.x - cellOffset;
    if (frame.size.width < minimumWidth)
    {
        CGFloat diff = minimumWidth - frame.size.width;
        frame.origin.x = frame.origin.x - diff;
        frame.size.width = minimumWidth;
    }
    
    view.frame = frame;
}

#pragma mark - HighlightedAnimation

- (void)showHighlightedAnimation
{
    UIView *tmpView = [[UIView alloc] initWithFrame:self.bounds];
    tmpView.backgroundColor = self.item.highlightBgColor;
    tmpView.alpha = 0.f;
    [self addSubview:tmpView];
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tmpView.alpha = 0.8f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            tmpView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            
            [tmpView removeFromSuperview];
        }];
    }];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    //[super setHighlighted:highlighted animated:animated];
    
    if ([self.item isKindOfClass:[DJTableViewItem class]])
    {
        if (highlighted && self.item.isShowHighlightBg)
        {
            [self showHighlightedAnimation];
        }
        else
        {
            [super setHighlighted:highlighted animated:animated];
        }
    }
    else
    {
        [super setHighlighted:highlighted animated:animated];
    }
}

#pragma mark - ActionBar

- (UIResponder *)responder
{
    return nil;
}

- (void)updateActionBarNavigationControl
{
    [self.actionBar.navigationControl setEnabled:[self indexPathForPreviousResponder] != nil forSegmentAtIndex:0];
    [self.actionBar.navigationControl setEnabled:[self indexPathForNextResponder] != nil forSegmentAtIndex:1];
}

- (NSIndexPath *)indexPathForPreviousResponderInSectionIndex:(NSUInteger)sectionIndex
{
    DJTableViewSection *section = self.tableViewManager.sections[sectionIndex];
    NSUInteger indexInSection =  [section isEqual:self.section] ? [section.items indexOfObject:self.item] : section.items.count;
    for (NSInteger i = indexInSection - 1; i >= 0; i--)
    {
        DJTableViewItem *item = section.items[i];
        if ([item isKindOfClass:[DJTableViewItem class]])
        {
            Class class = [self.tableViewManager classForCellAtIndexPath:item.indexPath];
            if ([class canFocusWithItem:item])
            {
                return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
            }
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForPreviousResponder
{
    for (NSInteger i = self.sectionIndex; i >= 0; i--)
    {
        NSIndexPath *indexPath = [self indexPathForPreviousResponderInSectionIndex:i];
        if (indexPath)
        {
            return indexPath;
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextResponderInSectionIndex:(NSUInteger)sectionIndex
{
    DJTableViewSection *section = self.tableViewManager.sections[sectionIndex];
    NSUInteger indexInSection =  [section isEqual:self.section] ? [section.items indexOfObject:self.item] : -1;
    for (NSInteger i = indexInSection + 1; i < section.items.count; i++)
    {
        DJTableViewItem *item = section.items[i];
        if ([item isKindOfClass:[DJTableViewItem class]])
        {
            Class class = [self.tableViewManager classForCellAtIndexPath:item.indexPath];
            if ([class canFocusWithItem:item])
            {
                return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
            }
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextResponder
{
    for (NSInteger i = self.sectionIndex; i < self.tableViewManager.sections.count; i++)
    {
        NSIndexPath *indexPath = [self indexPathForNextResponderInSectionIndex:i];
        if (indexPath)
        {
            return indexPath;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark REActionBar delegate

- (void)actionBar:(DJActionBar *)actionBar navigationControlValueChanged:(UISegmentedControl *)navigationControl
{
    NSIndexPath *indexPath = navigationControl.selectedSegmentIndex == 0 ? [self indexPathForPreviousResponder] : [self indexPathForNextResponder];
    if (indexPath)
    {
        DJTableViewCell *cell = (DJTableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
        if (!cell)
        {
            [self.parentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        }
        //cell = (DJTableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
        [cell.responder becomeFirstResponder];
    }
    if (self.item.actionBarNavButtonTapHandler)
    {
        self.item.actionBarNavButtonTapHandler(self.item);
    }
}

- (void)actionBar:(DJActionBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem
{
    if (self.item.actionBarDoneButtonTapHandler)
    {
        self.item.actionBarDoneButtonTapHandler(self.item);
    }
    
    [self endEditing:YES];
}

@end
