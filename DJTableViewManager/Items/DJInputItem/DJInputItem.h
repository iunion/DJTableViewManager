//
//  DJInputItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/20.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJInputItem : DJTableViewItem

// Data and values
//
@property (nullable, nonatomic, copy) NSString *value;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) BOOL editable;


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

@property (nullable, nonatomic, copy) void (^onBeginEditing)(DJInputItem *item);
@property (nullable, nonatomic, copy) void (^onEndEditing)(DJInputItem *item);
@property (nullable, nonatomic, copy) void (^onChange)(DJInputItem *item);
@property (nullable, nonatomic, copy) void (^onReturn)(DJInputItem *item);
@property (nullable, nonatomic, copy) BOOL (^onChangeCharacterInRange)(DJInputItem *item, NSRange range, NSString *replacementString);


+ (instancetype)itemWithTitle:(nullable NSString *)title value:(nullable NSString *)value;
+ (instancetype)itemWithTitle:(nullable NSString *)title value:(nullable NSString *)value  placeholder:(nullable NSString *)placeholder;
- (instancetype)initWithTitle:(nullable NSString *)title value:(nullable NSString *)value;
- (instancetype)initWithTitle:(nullable NSString *)title value:(nullable NSString *)value placeholder:(nullable NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END

