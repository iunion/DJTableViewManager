//
//  NSArray+Category.h
//  DJkit
//
//  Created by DennisDeng on 13-12-18.
//  Copyright (c) 2013年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

/**
 *  Convert the given array to JSON as NSString
 *
 *  @param array The array to be reversed
 *
 *  @return Return the JSON as NSString or nil if error while parsing
 */
+ (nullable NSString *)arrayToJSON:(nullable NSArray *)array;
+ (nullable NSString *)arrayToJSON:(nullable NSArray *)array options:(NSJSONWritingOptions)options;

- (nullable NSString *)toJSON;
- (nullable NSString *)toJSONWithOptions:(NSJSONWritingOptions)options;

/**
 *  Get the object at a given index in safe mode (nil if self is empty or out of range)
 *
 *  @param index The index
 *
 *  @return Return the object at a given index in safe mode (nil if self is empty or out of range)
 */
- (nullable id)safeObjectAtIndex:(NSUInteger)index;

// 随机获取一个元素
- (nullable id)randomObject;

/**
 *  Create a new array with count form begin to end
 *
 *  @param count the count of new array
 *
 *  @return a new array
 */
- (nonnull NSArray *)firstArrayWithCount:(NSUInteger)count;

/**
 *  Create a new array with count form end to begin
 *
 *  @param count the count of new array
 *
 *  @return a new array
 */
- (nonnull NSArray *)lastArrayWithCount:(NSUInteger)count;

/**
 *  Simulates the array as a circle. When it is out of range, begins again
 *
 *  @param index The index
 *
 *  @return Return the object at a given index
 */
+ (NSUInteger)circleIndex:(NSInteger)index maxSize:(NSUInteger)maxSize;
- (nonnull id)objectAtCircleIndex:(NSUInteger)index;

/**
 *  将array分割成几个为count个元素的子array并创建新的MutableArray
 *
 *  @param count 子array的元素数
 *
 *  @return MutableArray
 */
- (nullable NSMutableArray *)divisionWithCount:(NSUInteger)count;
- (nullable NSMutableArray *)divisionWithCount:(NSUInteger)count1 andCount:(NSUInteger)count2;

/**
 *  Create a reversed array from the given array
 *
 *  @param array The array to be converted
 *
 *  @return Return the reversed array
 */
+ (nonnull NSArray *)reversedArray:(nullable NSArray *)array;

/**
 *  Create a reversed array from self
 *
 *  @return Return the reversed array
 */
- (nonnull NSArray *)reversedArray;

- (nullable NSArray *)sortedArray;
- (nullable NSArray *)sortedCaseInsensitiveArray;

- (nullable NSArray *)sortArrayByKey:(nonnull NSString *)key ascending:(BOOL)ascending;

// 简单去重
- (nonnull NSArray *)uniqueArray;
// 简单合并
- (nonnull NSArray *)unionWithArray:(nullable NSArray *)anArray;
// 简单交叉，找相同
- (nonnull NSArray *)intersectionWithArray:(nullable NSArray *)anArray;
// 简单排除
- (nonnull NSArray *)differenceToArray:(nullable NSArray *)anArray;

/*!
 Filter array.
 @param filterBlock Filter block
 */
- (nonnull NSArray *)filterArray:(nullable BOOL(^)(id _Nonnull obj, NSUInteger index))filterBlock;

@end


@interface NSArray (Function)

- (void)makeObjectsPerformBlock:(void (^_Nullable)(id _Nonnull object))block;
- (BOOL)containsObjectOfClass:(Class _Nonnull )cls;
- (NSInteger)countObjectsOfClass:(Class _Nonnull )cls;
- (NSArray *_Nonnull)objectsOfClass:(Class _Nonnull )cls;

@end

