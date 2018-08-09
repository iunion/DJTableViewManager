//
//  DJTableViewTextCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTableViewTextCell.h"
#import "DJTableViewManager.h"
#import "DJTextItem.h"

@implementation DJInsetTextField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.separatorInset = UIEdgeInsetsZero;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame separatorInset:(UIEdgeInsets)separatorInset
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.separatorInset = separatorInset;
    }
    
    return self;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_separatorInset, separatorInset))
    {
        _separatorInset = separatorInset;
        
        [self setNeedsLayout];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect superBounds = [super textRectForBounds:bounds];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.separatorInset, UIEdgeInsetsZero))
    {
        return CGRectMake(superBounds.origin.x + self.separatorInset.left, superBounds.origin.y + self.separatorInset.top, superBounds.size.width - self.separatorInset.right, superBounds.size.height - self.separatorInset.bottom);
    }
    else
    {
        return superBounds;
    }
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect superBounds = [super placeholderRectForBounds:bounds];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.separatorInset, UIEdgeInsetsZero))
    {
        return CGRectMake(superBounds.origin.x + self.separatorInset.left, superBounds.origin.y + self.separatorInset.top, superBounds.size.width - self.separatorInset.right, superBounds.size.height - self.separatorInset.bottom);
    }
    else
    {
        return superBounds;
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect superBounds = [super editingRectForBounds:bounds];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.separatorInset, UIEdgeInsetsZero))
    {
        return CGRectMake(superBounds.origin.x + self.separatorInset.left, superBounds.origin.y + self.separatorInset.top, superBounds.size.width - self.separatorInset.right, superBounds.size.height - self.separatorInset.bottom);
    }
    else
    {
        return superBounds;
    }
}

@end

@interface DJTableViewTextCell ()

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL editable;

@property (nonatomic, strong) DJTextItem *item;
@property (nonatomic, strong) DJInsetTextField *textField;

@end

@implementation DJTableViewTextCell
@synthesize item = _item;

+ (BOOL)canFocusWithItem:(DJTextItem *)item
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
    }
}

- (UIResponder *)responder
{
    return self.textField;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.textField = [[DJInsetTextField alloc] initWithFrame:CGRectZero];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.inputAccessoryView = self.actionBar;
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.textField];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //self.textLabel.text = self.item.title.length == 0 ? @" " : self.item.title;
    self.textField.text = self.item.value;

    if (self.item.textFieldTextColor)
    {
        self.textField.textColor = self.item.textFieldTextColor;
    }
    else
    {
        self.textField.textColor = [UIColor colorWithHex:0x333333];
    }
    self.textField.placeholder = self.item.placeholder;
    if (self.item.textFieldPlaceholderColor)
    {
        [self.textField setPlaceholderColor:self.item.textFieldPlaceholderColor];
    }
    
    if (self.item.textFieldTextFont)
    {
        self.textField.font = self.item.textFieldTextFont;
    }
    else
    {
        self.textField.font = [UIFont systemFontOfSize:16.0f];
    }
    self.textField.autocapitalizationType = self.item.autocapitalizationType;
    self.textField.autocorrectionType = self.item.autocorrectionType;
    self.textField.spellCheckingType = self.item.spellCheckingType;
    self.textField.keyboardType = self.item.keyboardType;
    self.textField.keyboardAppearance = self.item.keyboardAppearance;
    self.textField.returnKeyType = self.item.returnKeyType;
    self.textField.enablesReturnKeyAutomatically = self.item.enablesReturnKeyAutomatically;
    self.textField.secureTextEntry = self.item.secureTextEntry;
    self.textField.clearButtonMode = self.item.clearButtonMode;
    self.textField.clearsOnBeginEditing = self.item.clearsOnBeginEditing;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.item.textFieldSeparatorInset, UIEdgeInsetsZero))
    {
        self.textField.separatorInset = self.item.textFieldSeparatorInset;
    }
    self.textField.textAlignment = self.item.textFieldAlignment;
    
    self.actionBar.barStyle = self.item.keyboardAppearance == UIKeyboardAppearanceAlert ? UIBarStyleBlack : UIBarStyleDefault;
    
    self.enabled = self.item.enabled;
    self.editable = self.item.editable;
}

- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth
{
    [super layoutDetailView:view minimumWidth:minimumWidth];
    
    if (self.item.accessoryView)
    {
        self.textField.width = self.item.accessoryView.left - 10 - self.textField.left;
    }
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    [self layoutDetailView:self.textField minimumWidth:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected)
    {
        [self.textField becomeFirstResponder];
    }
}


#pragma mark -
#pragma mark Handle state

- (void)setItem:(DJTextItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"editable"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"editable" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.textField.enabled = _enabled;
    
    ((UIControl *)self.responder).enabled = enabled;
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
    
    //self.textField.enabled = _editable;
    self.textField.userInteractionEnabled = _editable;
    
    //((UIControl *)self.responder).enabled = _editable;
    ((UIControl *)self.responder).userInteractionEnabled = _editable;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJTextItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
    else if ([object isKindOfClass:[DJTextItem class]] && [keyPath isEqualToString:@"editable"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.editable = newValue;
    }
}


#pragma mark -
#pragma mark Text field events

- (void)textFieldDidChanged:(UITextField *)textField
{
    if (self.item.charactersLimit)
    {
        NSString *textFieldText = textField.text;
        
        // ios7之前使用 [UITextInputMode currentInputMode].primaryLanguage
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
        
        if ([lang isEqualToString:@"zh-Hans"])
        {
            // 中文输入
            UITextRange *selectedRange = textField.markedTextRange;
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                // 判断是否超过最大字数限制，如果超过就截断
                if (textFieldText.length > self.item.charactersLimit)
                {
                    textField.text = [textFieldText substringToIndex:self.item.charactersLimit];
                }
            }
        }
        else
        {
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (textFieldText.length > self.item.charactersLimit)
            {
                textField.text = [textFieldText substringToIndex:self.item.charactersLimit];
            }
        }
    }
    
    self.item.value = textField.text;
    if (self.item.onChange)
    {
        self.item.onChange(self.item);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath)
    {
        textField.returnKeyType = UIReturnKeyNext;
    }
    else
    {
        textField.returnKeyType = self.item.returnKeyType;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    if (self.item.onBeginEditing)
    {
        self.item.onBeginEditing(self.item);
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.item.onEndEditing)
    {
        self.item.onEndEditing(self.item);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.item.onReturn)
    {
        self.item.onReturn(self.item);
    }
//    if (self.item.onEndEditing)
//    {
//        self.item.onEndEditing(self.item);
//    }
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (!indexPath)
    {
        [self endEditing:YES];
        return YES;
    }
    DJTableViewCell *cell = (DJTableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
    [cell.responder becomeFirstResponder];
    return YES;
}

// 选择待选字不触发此函数，在textFieldDidChanged中截取
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = YES;
    
#if (0)
    if (self.item.charactersLimit)
    {
        // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
        UITextRange *selectedRange = textField.markedTextRange;
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position)
        {
            NSUInteger newLength = textField.text.length + string.length - range.length;
            shouldChange = newLength <= self.item.charactersLimit;
        }
    }
#endif
    
    if (self.item.onChangeCharacterInRange && shouldChange)
    {
        shouldChange = self.item.onChangeCharacterInRange(self.item, range, string);
    }
    
    return shouldChange;
}

@end
