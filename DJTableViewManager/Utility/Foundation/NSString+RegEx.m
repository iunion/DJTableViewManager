//
//  NSString+RegEx.m
//  DJkit
//
//  Created by DennisDeng on 2017/4/28.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "NSString+RegEx.h"

@implementation NSString (RegEx)

- (NSRegularExpression *)toRx
{
    return [[NSRegularExpression alloc] initWithPattern:self];
}

- (NSRegularExpression *)toRxIgnoreCase:(BOOL)ignoreCase
{
    return [NSRegularExpression rx:self ignoreCase:ignoreCase];
}

- (NSRegularExpression *)toRxWithOptions:(NSRegularExpressionOptions)options
{
    return [NSRegularExpression rx:self options:options];
}

- (BOOL)isMatch:(NSRegularExpression *)rx
{
    return [rx isMatch:self];
}

- (NSInteger)indexOf:(NSRegularExpression *)rx
{
    return [rx indexOf:self];
}

- (NSArray <NSString *>*)split:(NSRegularExpression *)rx
{
    return [rx split:self];
}

- (NSString *)replace:(NSRegularExpression *)rx with:(NSString *)replacement
{
    return [rx replace:self with:replacement];
}

- (NSString *)replace:(NSRegularExpression *)rx withBlock:(NSString * (^)(NSString *match))replacer
{
    return [rx replace:self withBlock:replacer];
}

- (NSString *)replace:(NSRegularExpression *)rx withDetailsBlock:(NSString * (^)(RxMatch *match))replacer
{
    return [rx replace:self withDetailsBlock:replacer];
}

- (NSArray <NSString *>*)matches:(NSRegularExpression *)rx
{
    return [rx matches:self];
}

- (NSString *)firstMatch:(NSRegularExpression *)rx
{
    return [rx firstMatch:self];
}

- (NSArray <RxMatch *>*)matchesWithDetails:(NSRegularExpression *)rx
{
    return [rx matchesWithDetails:self];
}

- (RxMatch *)firstMatchWithDetails:(NSRegularExpression *)rx
{
    return [rx firstMatchWithDetails:self];
}

#pragma mark ori

- (BOOL)isValidPhoneNumber
{
    if (!self.length)
    {
        return NO;
    }
    return [self isMatchWithPattern:PHONE_PATTERN];
}

- (BOOL)isValidPassword
{
    if (!self.length)
    {
        return NO;
    }
    return [self isMatchWithPattern:PASSWORD_PATTERN];
}

- (BOOL)isValidNickName
{
    if (!self.length || self.length > 8)
    {
        return NO;
    }
    return [self isMatchWithPattern:NICKNAME_PATTERN];
}

- (BOOL)isValidChinesePhoneNumber
{
    if (self.length != 11)
    {
        return NO;
    }
    return [self isMatchWithPattern:PHONE_PATTERN_CHINESE];
}

- (BOOL)isValidEMailAddress
{
    if (!self.length)
    {
        return NO;
    }
    return [self isMatchWithPattern:EMAIL_PATTERN];
}

- (BOOL)isValidIPAddress
{
    if (self.length > 12 ||
        self.length < 7)
    {
        return NO;
    }
    return [self isMatchWithPattern:IP_PATTERN];
}

- (BOOL)isValidMD532String
{
    if (self.length != 32)
    {
        return NO;
    }
    return [self isMatchWithPattern:MD5_32_PATTERN];
}

- (BOOL)isValidChineseIDNumberString
{
    if (self.length < 15 ||
        self.length > 18)
    {
        return NO;
    }
    return [self isMatchWithPattern:CHINESE_ID_NUMBER_PATTERN];
}

- (NSArray <NSString *>*)matchesWithPattern:(NSString *)pattern
{
    return [self matches:RX(pattern)];
}

- (NSString *)firstMatchWithPattern:(NSString *)pattern
{
    return [self firstMatch:RX(pattern)];
}

- (BOOL)isMatchWithPattern:(NSString *)pattern
{
    return [self isMatch:RX(pattern)];
}

- (NSRange)rangOfFirstMatchWithPattern:(NSString *)pattern
{
    NSError *error;
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error)
    {
        return NSMakeRange(NSNotFound, 0);
    }
    NSRange range = [regEx rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return range;
}

- (NSInteger)indexOfFirstMatchWithPattern:(NSString *)pattern
{
    NSRange range = [self rangOfFirstMatchWithPattern:pattern];
    return range.location == NSNotFound ? -1 : (int)range.location;
}

- (NSString *)stringByReplacingOccurrencesOfPattern:(NSString *)pattern withString:(NSString *)string
{
    return [self replace:RX(pattern) with:string];
}

- (NSString *)replaceWithPattern:(NSString *)pattern to:(NSString *)replacement
{
    return [self replace:RX(pattern) with:replacement];
}

- (NSArray<NSString *> *)splitWithPattern:(NSString *)pattern
{
    return [self split:RX(pattern)];
}

@end
