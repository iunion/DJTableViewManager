//
//  DJMaskTextItem.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/23.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJMaskTextItem.h"

@implementation DJMaskTextItem
@synthesize secureTextEntry = _secureTextEntry;
@synthesize charactersLimit = _charactersLimit;

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    //NSAssert(YES, @"Can't set secureTextEntry");
    _secureTextEntry = NO;
    return;
}

- (void)setCharactersLimit:(NSUInteger)charactersLimit
{
    //NSAssert(YES, @"Can't set charactersLimit");
    _charactersLimit = 0;
    return;
}

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"init not supported, use (itemWithTitle: value: placeholder: maskPattern: maskPlaceholder:) instead." userInfo:nil];
    return nil;
}

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"init not supported, use (itemWithTitle: value: placeholder: maskPattern: maskPlaceholder:) instead." userInfo:nil];
    return nil;
}

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder maskPattern:(NSString *)maskPattern maskPlaceholder:(NSString *)maskPlaceholder
{
    return [[self alloc] initWithTitle:title value:value placeholder:placeholder maskPattern:maskPattern maskPlaceholder:maskPlaceholder];
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"init not supported, use (itemWithTitle: value: placeholder: maskPattern: maskPlaceholder:) instead." userInfo:nil];
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"init not supported, use (itemWithTitle: value: placeholder: maskPattern: maskPlaceholder:) instead." userInfo:nil];
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder maskPattern:(NSString *)maskPattern maskPlaceholder:(NSString *)maskPlaceholder
{
    self = [super init];
    
    if (self)
    {
        self.isShowHighlightBg = NO;
        
        self.editable = YES;
        self.title = title;
        self.value = value;
        self.placeholder = placeholder;
        self.textFieldSeparatorInset = UIEdgeInsetsZero;
        
        self.clearsOnBeginEditing = YES;
        self.maskPattern = maskPattern;
        self.maskPlaceholder = maskPlaceholder;
    }
    
    return self;
}




@end
