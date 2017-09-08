//
//  DJTextItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJTextItem : DJTableViewItem

// Data and values
//
@property (nullable, nonatomic, copy) NSString *value;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) BOOL editable;

// TextField
//
// default is UITextFieldViewModeNever
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;
// default is NO
@property (nonatomic, assign) BOOL clearsOnBeginEditing;

@property (nullable, nonatomic, strong) UIColor *textFieldBgColor;
@property (nonatomic, assign) UIEdgeInsets textFieldSeparatorInset;

@property (nonatomic, assign) NSTextAlignment textFieldAlignment;

@property (nullable, nonatomic, strong) UIColor *textFieldTextColor;
@property (nullable, nonatomic, strong) UIFont *textFieldTextFont;

@property (nullable, nonatomic, strong) UIColor *textFieldPlaceholderColor;

// Keyboard
//
// default is UITextAutocapitalizationTypeSentences
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;
// default is UITextAutocorrectionTypeDefault
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
// default is UITextSpellCheckingTypeDefault;
@property (nonatomic, assign) UITextSpellCheckingType spellCheckingType NS_AVAILABLE_IOS(5_0);
// default is UIKeyboardTypeDefault
@property (nonatomic, assign) UIKeyboardType keyboardType;
// default is UIKeyboardAppearanceDefault
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;
// default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property (nonatomic, assign) UIReturnKeyType returnKeyType;
// default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property (nonatomic, assign) BOOL enablesReturnKeyAutomatically;
// default is NO
@property (nonatomic, assign) BOOL secureTextEntry;

// 输入字符数限制 0: 不限制
@property (nonatomic, assign) NSUInteger charactersLimit;

@property (nullable, nonatomic, copy) void (^onBeginEditing)(DJTextItem *item);
@property (nullable, nonatomic, copy) void (^onEndEditing)(DJTextItem *item);
@property (nullable, nonatomic, copy) void (^onChange)(DJTextItem *item);
@property (nullable, nonatomic, copy) void (^onReturn)(DJTextItem *item);
@property (nullable, nonatomic, copy) BOOL (^onChangeCharacterInRange)(DJTextItem *item, NSRange range, NSString *replacementString);


+ (instancetype)itemWithTitle:(nullable NSString *)title value:(nullable NSString *)value;
+ (instancetype)itemWithTitle:(nullable NSString *)title value:(nullable NSString *)value  placeholder:(nullable NSString *)placeholder;
- (instancetype)initWithTitle:(nullable NSString *)title value:(nullable NSString *)value;
- (instancetype)initWithTitle:(nullable NSString *)title value:(nullable NSString *)value placeholder:(nullable NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END

