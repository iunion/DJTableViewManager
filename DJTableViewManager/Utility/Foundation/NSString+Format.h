//
//  NSString+Format.h
//  DJkit
//
//  Created by DennisDeng on 2017/4/14.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

- (nullable NSString *)formatWithPattern:(nullable NSString *)pattern;
- (nullable NSString *)formatWithPattern:(nullable NSString *)pattern placeholder:(nullable NSString *)placeholder;
- (nullable NSString *)formatWithPattern:(nullable NSString *)pattern placeholder:(nullable NSString *)placeholder errorContinue:(BOOL)errorContinue;

- (nullable NSString *)formatWithRegex:(nullable NSRegularExpression *)regex;
- (nullable NSString *)formatWithRegex:(nullable NSRegularExpression *)regex placeholder:(nullable NSString *)placeholder;
- (nullable NSString *)formatWithRegex:(nullable NSRegularExpression *)regex placeholder:(nullable NSString *)placeholder errorContinue:(BOOL)errorContinue;

- (nullable NSString *)validCharactersWithRegex:(nullable NSRegularExpression *)regex errorContinue:(BOOL)errorContinue;

@end

@interface NSString (PhoneNumber)

- (nonnull NSString *)maskPhoneNumber:(NSRange)maskRang withMask:(char)maskChar;
- (nonnull NSString *)maskAtRang:(NSRange)maskRang withMask:(char)maskChar;

@end
