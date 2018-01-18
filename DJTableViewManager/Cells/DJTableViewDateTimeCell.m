//
//  DJTableViewDateTimeCell.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewDateTimeCell.h"
#import "DJTableViewManager.h"
#import "DJDateTimeItem.h"

@interface DJTableViewDateTimeCell ()
<
    UITextFieldDelegate
>

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, strong) UITextField *hidenTextField;

@property (nonatomic, strong) UILabel *pickerTextLabel;
@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) DJDatePicker *pickerView;

@property (nonatomic, strong) DJDateTimeItem *item;

@end

@implementation DJTableViewDateTimeCell
@synthesize item = _item;

+ (BOOL)canFocusWithItem:(DJPickerItem *)item
{
    if (item.enabled)
    {
        return YES;
    }
    
    return NO;
}

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
}

- (UIResponder *)responder
{
    return self.hidenTextField;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.hidenTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.hidenTextField.inputAccessoryView = self.actionBar;
    self.hidenTextField.delegate = self;
    [self addSubview:self.hidenTextField];
    
    self.pickerTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pickerTextLabel.backgroundColor = [UIColor clearColor];
    self.pickerTextLabel.textAlignment = NSTextAlignmentRight;
    //self.pickerTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview:self.pickerTextLabel];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.textAlignment = NSTextAlignmentRight;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.placeholderLabel];

    DJDatePicker *datePicker = [[DJDatePicker alloc] initWithPickerStyle:PickerStyle_YearMonthDayHourMinute completeBlock:nil];
    self.pickerView = datePicker;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.pickerView.pickerStyle = self.item.pickerStyle;
    
    __typeof (&*self) __weak weakSelf = self;
    self.pickerView.completeBlock = ^(NSDate *date, BOOL isDone) {
        if (weakSelf.item.showDoneBtn)
        {
            if (isDone)
            {
                weakSelf.item.pickerDate = date;
                if (weakSelf.item.onChange)
                {
                    weakSelf.item.onChange(weakSelf.item);
                }
            }
        }
        else
        {
            weakSelf.item.pickerDate = date;
            if (weakSelf.item.onChange)
            {
                weakSelf.item.onChange(weakSelf.item);
            }
        }
        
        [weakSelf showPickerText];
    };

    self.hidenTextField.inputView = self.pickerView;
    
    self.pickerTextLabel.textColor = self.item.pickerValueColor;
    self.pickerTextLabel.font = self.item.pickerValueFont;
    self.pickerTextLabel.textAlignment = self.item.pickerTextAlignment;
    
    self.placeholderLabel.textColor = self.item.pickerPlaceholderColor;
    self.placeholderLabel.font = self.item.pickerValueFont;
    self.placeholderLabel.textAlignment = self.item.pickerTextAlignment;

    self.pickerView.formateColor = self.item.formateColor;
    self.pickerView.formate = self.item.formate;
    
    self.pickerView.yearColor = self.item.bigYearColor;
    self.pickerView.pickerLabelColor = self.item.pickerLabelColor;
    self.pickerView.pickerItemColor = self.item.pickerItemColor;

    self.pickerView.showDoneBtn = self.item.showDoneBtn;
    self.pickerView.doneBtnBgColor = self.item.doneBtnBgColor;
    self.pickerView.doneBtnTextColor = self.item.doneBtnTextColor;
    
    self.pickerView.maxLimitDate = self.item.maxLimitDate;
    self.pickerView.minLimitDate = self.item.minLimitDate;

    if ([self.item.pickerDate isNotEmpty])
    {
        [self.pickerView scrollToDate:self.item.pickerDate animated:YES];
    }
    else
    {
        if (self.item.defaultPickerDate)
        {
            [self.pickerView scrollToDate:self.item.defaultPickerDate animated:YES];
        }
        else
        {
            [self.pickerView scrollToDate:[NSDate date] animated:YES];
        }
    }
    
    self.enabled = self.item.enabled;
}

- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth
{
    [super layoutDetailView:view minimumWidth:minimumWidth];
    
    self.placeholderLabel.frame = view.frame;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    [self layoutDetailView:self.pickerTextLabel minimumWidth:0];
}

- (void)setItem:(DJDateTimeItem *)item
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
    self.pickerTextLabel.enabled = _enabled;
    self.placeholderLabel.enabled = _enabled;
    self.pickerView.userInteractionEnabled = _enabled;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJDateTimeItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        [self.hidenTextField becomeFirstResponder];
    }
}

- (void)showPickerText
{
    if ([self.item.pickerDate isNotEmpty])
    {
        if (self.item.formatPickerText)
        {
            self.pickerTextLabel.text = self.item.formatPickerText(self.item);
        }
        else
        {
            self.pickerTextLabel.text = [self.item.pickerDate stringByDefaultFormatter];
        }
    }
    else
    {
        if (self.item.defaultPickerDate)
        {
            if (self.item.formatPickerText)
            {
                self.pickerTextLabel.text = self.item.formatPickerText(self.item);
            }
            else
            {
                self.pickerTextLabel.text = [self.item.defaultPickerDate stringByDefaultFormatter];
            }
        }
        else
        {
            self.pickerTextLabel.text = nil;
        }
    }

    self.placeholderLabel.text = self.item.placeholder;
    self.placeholderLabel.hidden = [self.pickerTextLabel.text isNotEmpty];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath)
    {
        textField.returnKeyType = UIReturnKeyNext;
    }
    else
    {
        textField.returnKeyType = UIReturnKeyDefault;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self showPickerText];
    
    return YES;
}

@end

