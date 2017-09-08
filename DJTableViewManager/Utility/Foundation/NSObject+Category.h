//
//  NSObject+Category.h
//  DJkit
//
//  Created by DennisDeng on 12-8-7.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

/**
 * Additional performSelector signatures that support up to 7 arguments.
 */
- (nullable id)performSelector:(nonnull SEL)selector
                    withObject:(nullable id)p1
                    withObject:(nullable id)p2
                    withObject:(nullable id)p3;
- (nullable id)performSelector:(nonnull SEL)selector
                    withObject:(nullable id)p1
                    withObject:(nullable id)p2
                    withObject:(nullable id)p3
                    withObject:(nullable id)p4;
- (nullable id)performSelector:(nonnull SEL)selector
                    withObject:(nullable id)p1
                    withObject:(nullable id)p2
                    withObject:(nullable id)p3
                    withObject:(nullable id)p4
                    withObject:(nullable id)p5;
- (nullable id)performSelector:(nonnull SEL)selector
                    withObject:(nullable id)p1
                    withObject:(nullable id)p2
                    withObject:(nullable id)p3
                    withObject:(nullable id)p4
                    withObject:(nullable id)p5
                    withObject:(nullable id)p6;
- (nullable id)performSelector:(nonnull SEL)selector
                    withObject:(nullable id)p1
                    withObject:(nullable id)p2
                    withObject:(nullable id)p3
                    withObject:(nullable id)p4
                    withObject:(nullable id)p5
                    withObject:(nullable id)p6
                    withObject:(nullable id)p7;

- (void)performSelectorCoalesced:(nonnull SEL)selector
                      withObject:(nullable id)obj
                      afterDelay:(NSTimeInterval)delay;

- (BOOL)isValided;
- (BOOL)isNotNSNull;
- (BOOL)isNotEmpty;
- (BOOL)isNotEmptyDictionary;

+ (nonnull NSString *)className;
- (nonnull NSString *)className;

@end

@interface NSObject (Swizzle)

+ (BOOL)swizzleMethod:(nonnull SEL)originalSEL withMethod:(nonnull SEL)swizzledSEL error:(NSError * _Nullable * _Nullable)error;
+ (BOOL)swizzleClassMethod:(nonnull SEL)originalSEL withClassMethod:(nonnull SEL)swizzledSEL error:(NSError * _Nullable * _Nullable)error;

@end


@interface NSObject (Boolean)

- (BOOL)isNotProxy;

- (BOOL)isNotKindOfClass:(nonnull Class)aClass;
- (BOOL)isNotMemberOfClass:(nonnull Class)aClass;
- (BOOL)notConformsToProtocol:(nonnull Protocol *)aProtocol;

- (BOOL)notRespondsToSelector:(nonnull SEL)aSelector;

@end
