//
//  NSArray+Category.m
//  DJkit
//
//  Created by DennisDeng on 13-12-18.
//  Copyright (c) 2013年 DennisDeng. All rights reserved.
//

#import "NSArray+Category.h"
#import "NSObject+Category.h"

@implementation NSArray (Category)

+ (NSString *)arrayToJSON:(NSArray *)array
{
    // NSJSONWritingPrettyPrinted
    return [NSArray arrayToJSON:array options:0];
}

+ (NSString *)arrayToJSON:(NSArray *)array options:(NSJSONWritingOptions)options
{
    return [array toJSONWithOptions:options];
}

- (NSString *)toJSON
{
    // NSJSONWritingPrettyPrinted
    return [self toJSONWithOptions:0];
}

- (NSString *)toJSONWithOptions:(NSJSONWritingOptions)options
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:options error:&error];
    
    if (!jsonData)
    {
        return @"{}";
    }
    else if (!error)
    {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return nil;
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (self.count > 0 && self.count > index)
    {
        return [self objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

- (id)randomObject
{
    if (!self.count)
    {
        return nil;
    }
    
    NSUInteger whichItem = (NSUInteger)(arc4random() % self.count);
    
    return self[whichItem];
}

- (NSArray *)firstArrayWithCount:(NSUInteger)count
{
    if (self.count <= count)
    {
        return self;
    }
    
    NSRange range = NSMakeRange(0, count);
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
    
    return [self objectsAtIndexes:indexSet];
}

- (NSArray *)lastArrayWithCount:(NSUInteger)count
{
    if (self.count <= count)
    {
        return self;
    }
    
    NSRange range = NSMakeRange(self.count-count, count);
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
    
    return [self objectsAtIndexes:indexSet];
}

+ (NSUInteger)circleIndex:(NSInteger)index maxSize:(NSUInteger)maxSize
{
    if (index < 0)
    {
        index = index % maxSize;
        index += maxSize;
    }
    if (index >= maxSize)
    {
        index = index % maxSize;
    }
    
    return (NSUInteger)index;
}

- (id)objectAtCircleIndex:(NSUInteger)index
{
    return [self objectAtIndex:[NSArray circleIndex:index maxSize:self.count]];
}

- (NSMutableArray *)divisionWithCount:(NSUInteger)count
{
    if (count == 0)
    {
        return nil;
    }
    
    NSMutableArray *arrayArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (NSUInteger index = 0; index < self.count; index++)
    {
        [array addObject:self[index]];
        
        if (((index+1) % count) == 0)
        {
            [arrayArray addObject:array];
            array = [NSMutableArray array];
        }
    }
    
    if (array.count > 0)
    {
        [arrayArray addObject:array];
    }
    
    return arrayArray;
}

- (NSMutableArray *)divisionWithCount:(NSUInteger)count1 andCount:(NSUInteger)count2
{
    if (count1 == 0)
    {
        return nil;
    }
    
    if (count2 == 0)
    {
        return [self divisionWithCount:count1];
    }
    
    NSMutableArray *arrayArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (NSUInteger index = 0; index < self.count; index++)
    {
        [array addObject:self[index]];
        
        if (((index+1) % (count1+count2)) == 0)
        {
            NSArray *array1 = [array firstArrayWithCount:count1];
            NSArray *array2 = [array lastArrayWithCount:count2];
            [arrayArray addObject:array1];
            [arrayArray addObject:array2];
            array = [NSMutableArray array];
        }
    }
    
    if (array.count > 0)
    {
        NSArray *array1 = [array firstArrayWithCount:count1];
        
        [arrayArray addObject:array1];
        
        if (array.count > array1.count)
        {
            NSArray *array2 = [array lastArrayWithCount:(array.count - array1.count)];
            
            [arrayArray addObject:array2];
        }
    }
    
    return arrayArray;
}

+ (NSArray *)reversedArray:(NSArray *)array
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator)
    {
        [arrayTemp addObject:element];
    }
    
    return arrayTemp;
}

- (NSArray *)reversedArray
{
    return [NSArray reversedArray:self];
}

- (NSArray *)sortedArray
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 compare:obj2];}];
    return resultArray;
}

- (NSArray *)sortedCaseInsensitiveArray
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 caseInsensitiveCompare:obj2];}];
    return resultArray;
}

- (NSArray *)sortArrayByKey:(NSString *)key ascending:(BOOL)ascending
{
    if (![self isNotEmpty])
    {
        return self;
    }
    
    NSArray *tempArray = [[NSArray alloc] initWithArray:self];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:@[descriptor]];
    
    return sortedArray;
}

- (NSArray *)uniqueArray
{
    return [NSOrderedSet orderedSetWithArray:self].array.copy;
}

- (NSArray *)unionWithArray:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 unionOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *)intersectionWithArray:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 intersectOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *)differenceToArray:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 minusOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *)filterArray:(BOOL(^)(id obj, NSUInteger index))filterBlock
{
    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:[self count]];
    NSUInteger i = 0;
    for (id obj in self)
    {
        if (filterBlock(obj, i))
        {
            [filteredArray addObject:obj];
        }
        i++;
    }
    
    return [NSArray arrayWithArray:filteredArray];
}

@end


#pragma mark -
#pragma mark Function

@implementation NSArray (Function)

- (void)makeObjectsPerformBlock:(void (^)(id))block
{
    if (!block)
    {
        return;
    }
    
    for (id object in self)
    {
        block(object);
    }
}

- (BOOL)containsObjectOfClass:(Class)cls
{
    for (id obj in self)
    {
        if ([obj isKindOfClass:cls])
        {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)countObjectsOfClass:(Class)cls
{
    NSInteger count = 0;
    for (id obj in self)
    {
        if ([obj isKindOfClass:cls])
        {
            count++;
        }
    }
    return count;
}

- (NSArray *)objectsOfClass:(Class)cls
{
    NSMutableArray *objects = [NSMutableArray array];
    for (id obj in self)
    {
        if ([obj isKindOfClass:cls])
        {
            [objects addObject:obj];
        }
    }
    return objects;
}

@end

