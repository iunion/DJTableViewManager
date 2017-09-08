//
//  NSDictionary+Category.h
//  DJkit
//
//  Created by DennisDeng on 16/1/21.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

- (long long)longForKey:(nonnull id)key;
- (long long)longForKey:(nonnull id)key withDefault:(long long)theDefault;
- (long long)longForKey:(nonnull id)key formatNumberStyle:(NSNumberFormatterStyle)numberStyle withDefault:(long long)theDefault;
- (NSInteger)intForKey:(nonnull id)key;
- (NSInteger)intForKey:(nonnull id)key withDefault:(NSInteger)theDefault;
- (NSInteger)intForKey:(nonnull id)key formatNumberStyle:(NSNumberFormatterStyle)numberStyle withDefault:(NSInteger)theDefault;
- (NSUInteger)uintForKey:(nonnull id)key;
- (NSUInteger)uintForKey:(nonnull id)key withDefault:(NSUInteger)theDefault;
- (NSUInteger)uintForKey:(nonnull id)key formatNumberStyle:(NSNumberFormatterStyle)numberStyle withDefault:(NSUInteger)theDefault;

- (BOOL)boolForKey:(nonnull id)key;
- (BOOL)boolForKey:(nonnull id)key withDefault:(BOOL)theDefault;

- (nullable NSString *)stringForKey:(nonnull id)key;
- (nullable NSString *)stringForKey:(nonnull id)key withDefault:(nullable NSString *)theDefault;
// 由于第三方库的问题,字典获取string使用以下方法.
- (nullable NSString *)DJStringForKey:(nonnull id)key;
- (nullable NSString *)DJStringForKey:(nonnull id)key withDefault:(nullable NSString *)theDefault;

- (BOOL)containsObjectForKey:(nonnull id)key;

- (nullable NSString *)toJSON;
- (nullable NSString *)toJSONWithOptions:(NSJSONWritingOptions)options;
+ (nullable NSDictionary *)dictionaryWithJsonString:(nullable NSString *)jsonString;

- (nullable NSData *)transformToData;

@end

@interface NSDictionary (DeepMutableCopy)

- (nullable NSMutableDictionary *)deepMutableCopy;

@end

@interface NSMutableDictionary (bbCategory)

- (void)setInteger:(NSInteger)value forKey:(nonnull id)key;
- (void)setUInteger:(NSUInteger)value forKey:(nonnull id)key;
- (void)setBool:(BOOL)value forKey:(nonnull id)key;
- (void)setFloat:(float)value forKey:(nonnull id)key;
- (void)setDouble:(double)value forKey:(nonnull id)key;
- (void)setString:(nullable NSString *)value forKey:(nonnull id)key;

@end
