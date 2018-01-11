//
//  UIView+VerifiTimeManager.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/10.
//Copyright © 2018年 DJ. All rights reserved.
//

static char VERIFIMANAGERBLOCK_KEY;
static char VERIFIMANAGERTYPE_KEY;
static char VERIFIMANAGERDDURATION_KEY;

#import "UIView+VerifiTimeManager.h"
#import <objc/runtime.h>

@implementation UIView (VerifiTimeManager)
@dynamic verifiManagerBlock;
@dynamic verifiManagerType;
@dynamic verifiManagerdDuration;

- (DJVerifiTimeBlock)verifiManagerBlock
{
    return (DJVerifiTimeBlock)objc_getAssociatedObject(self, &VERIFIMANAGERBLOCK_KEY);
}

- (void)setVerifiManagerBlock:(DJVerifiTimeBlock)block
{
    if (block != self.verifiManagerBlock)
    {
        // KVO
        [self willChangeValueForKey:@"verifiManagerBlock"];
        objc_setAssociatedObject(self, &VERIFIMANAGERBLOCK_KEY, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self didChangeValueForKey:@"verifiManagerBlock"];
    }
}

- (CFTimeInterval)verifiManagerdDuration
{
    NSNumber *value = (NSNumber *)objc_getAssociatedObject(self, &VERIFIMANAGERDDURATION_KEY);
    
    return value.doubleValue;
}

- (void)setVerifiManagerdDuration:(CFTimeInterval)duration
{
    [self willChangeValueForKey:@"verifiManagerdDuration"];
    objc_setAssociatedObject(self, &VERIFIMANAGERDDURATION_KEY, @(duration), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"verifiManagerdDuration"];
}

- (DJVerificationCodeType)verifiManagerType
{
    NSNumber *value = (NSNumber *)objc_getAssociatedObject(self, &VERIFIMANAGERTYPE_KEY);
    return value.integerValue;
}

- (void)setVerifiManagerType:(DJVerificationCodeType)type
{
    [self willChangeValueForKey:@"verifiManagerType"];
    objc_setAssociatedObject(self, &VERIFIMANAGERTYPE_KEY, @(type), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"verifiManagerType"];
    
    if (self.verifiManagerBlock)
    {
        [[DJVerifiTimeManager manager] checkTimeWithType:self.verifiManagerType process:self.verifiManagerBlock];
    }
}

- (void)startVerifiTimeManager
{
    if (self.verifiManagerBlock && self.verifiManagerdDuration > 0)
    {
        [[DJVerifiTimeManager manager] startTimeWithType:self.verifiManagerType duration:self.verifiManagerdDuration process:self.verifiManagerBlock];
    }
}

@end
