//
//  DJTableViewLongTextCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/20.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewLongTextCell.h"
#import "DJLongTextItem.h"

@interface DJTableViewLongTextCell ()

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL editable;

@property (nonatomic, strong) DJLongTextItem *item;
@property (nonatomic, strong) DJPlaceholderTextView *textView;

@end

@implementation DJTableViewLongTextCell
@synthesize item = _item;

+ (BOOL)canFocusWithItem:(DJLongTextItem *)item
{
    if (item.enabled)
    {
        return item.editable;
    }
    
    return NO;
}

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"editable"];
        [_item removeObserver:self forKeyPath:@"textViewTypingAttributes"];
    }
}

- (UIResponder *)responder
{
    return self.textView;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.textView = [[DJPlaceholderTextView alloc] initWithFrame:CGRectZero];
    self.textView.inputAccessoryView = self.actionBar;
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.textView.delegate = self;

    self.textView.layer.cornerRadius = 4.0f;
    self.textView.layer.borderWidth = SINGLE_LINE_WIDTH;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.masksToBounds = YES;

    [self.contentView addSubview:self.textView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;

    if (self.item.attributedValue)
    {
        self.textView.attributedText = self.item.attributedValue;
    }
    else
    {
        self.textView.text = self.item.value;
    }
    
    self.textView.placeholder = self.item.placeholder;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.item.textViewTextContainerInset, UIEdgeInsetsZero))
    {
        self.textView.textContainerInset = self.item.textViewTextContainerInset;
    }
    
    if (self.item.textViewPlaceholderColor)
    {
        self.textView.placeholderColor = self.item.textViewPlaceholderColor;
    }
    self.textView.placeholderLineBreakMode = self.item.textViewPlaceholderLineBreakMode;
    
    self.textView.font = self.item.textViewFont;
    if (self.item.textViewTextColor)
    {
        self.textView.textColor = self.item.textViewTextColor;
    }
    self.textView.textAlignment = self.item.textViewTextAlignment;
    
    self.textView.selectable = self.item.textViewSelectable;
    
    self.textView.typingAttributes = self.item.textViewLinkTextAttributes;

    self.textView.autocapitalizationType = self.item.autocapitalizationType;
    self.textView.autocorrectionType = self.item.autocorrectionType;
    self.textView.spellCheckingType = self.item.spellCheckingType;
    self.textView.keyboardType = self.item.keyboardType;
    self.textView.keyboardAppearance = self.item.keyboardAppearance;
    self.textView.returnKeyType = self.item.returnKeyType;
    self.textView.enablesReturnKeyAutomatically = self.item.enablesReturnKeyAutomatically;
    self.textView.secureTextEntry = self.item.secureTextEntry;
    
    self.actionBar.barStyle = self.item.keyboardAppearance == UIKeyboardAppearanceAlert ? UIBarStyleBlack : UIBarStyleDefault;
    
    self.enabled = self.item.enabled;
    self.editable = self.item.editable;
    
    //self.textView.backgroundColor = [UIColor redColor];
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    self.textLabel.top = self.item.textLabelTopGap;
    self.textLabel.height = self.textLabel.font.pointSize+8.0f;

    CGFloat top = self.item.textViewTopGap;
    CGFloat left = self.textLabel.left + self.item.textViewLeftGap;
    CGRect frame;
    
    if (self.textLabel.text)
    {
        CGFloat top = self.textLabel.top + self.textLabel.height + self.item.textViewTopGap;
        frame = CGRectMake(left, top, self.textLabel.width-2.0*self.item.textViewLeftGap, self.height-top-self.item.textViewTopGap);
    }
    else
    {
        frame = CGRectMake(left, top, self.textLabel.width-2.0*self.item.textViewLeftGap, self.height-2*self.item.textViewTopGap);
    }
    
    self.textView.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected)
    {
        [self.textView becomeFirstResponder];
    }
}


#pragma mark -
#pragma mark Handle state

- (void)setItem:(DJLongTextItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"editable"];
        [_item removeObserver:self forKeyPath:@"textViewTypingAttributes"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"editable" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"textViewTypingAttributes" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.textView.editable = _enabled;
    
    //((UIControl *)self.responder).enabled = enabled;
}

- (void)setEditable:(BOOL)enabled
{
    if (!_enabled)
    {
        NSLog(@"Cell is disabled");
        enabled = NO;
    }
    
    _editable = enabled;
    
    self.userInteractionEnabled = _editable;
    
    self.textView.editable = _editable;
    //self.textView.userInteractionEnabled = _editable;
    
    //((UIControl *)self.responder).enabled = _editable;
    //((UIControl *)self.responder).userInteractionEnabled = _editable;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJLongTextItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
    else if ([object isKindOfClass:[DJLongTextItem class]] && [keyPath isEqualToString:@"editable"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.editable = newValue;
    }
    else if ([object isKindOfClass:[DJLongTextItem class]] && [keyPath isEqualToString:@"textViewTypingAttributes"])
    {
        id newValue = [change objectForKey: NSKeyValueChangeNewKey];
        
        self.textView.typingAttributes = newValue;
    }
}



#pragma mark -
#pragma mark Text field events

- (void)textViewDidChange:(UITextView *)textView
{
    self.item.value = textView.text;
    if (self.item.onChange)
    {
        self.item.onChange(self.item);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath)
    {
        textView.returnKeyType = UIReturnKeyNext;
    }
    else
    {
        textView.returnKeyType = self.item.returnKeyType;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    if (self.item.onBeginEditing)
    {
        self.item.onBeginEditing(self.item);
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    if (self.item.onEndEditing)
    {
        self.item.onEndEditing(self.item);
    }
    return YES;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (self.item.onReturn)
//    {
//        self.item.onReturn(self.item);
//    }
//    //    if (self.item.onEndEditing)
//    //    {
//    //        self.item.onEndEditing(self.item);
//    //    }
//    NSIndexPath *indexPath = [self indexPathForNextResponder];
//    if (!indexPath)
//    {
//        [self endEditing:YES];
//        return YES;
//    }
//    DJTableViewCell *cell = (DJTableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
//    [cell.responder becomeFirstResponder];
//    return YES;
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL shouldChange = YES;
    
    if (self.item.charactersLimit)
    {
        NSUInteger newLength = textView.text.length + text.length - range.length;
        shouldChange = newLength <= self.item.charactersLimit;
    }
    
    if (self.item.onChangeCharacterInRange && shouldChange)
    {
        shouldChange = self.item.onChangeCharacterInRange(self.item, range, text);
    }
    
    return shouldChange;
}

@end
