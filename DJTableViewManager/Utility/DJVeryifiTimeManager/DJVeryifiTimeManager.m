//
//  DJVeryifiTimeManager.m
//  DJkit
//
//  Created by DennisDeng on 16/4/21.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import "DJVeryifiTimeManager.h"
#import "NSDictionary+Category.h"
#import "NSObject+Category.h"


#define DJVerifiTime_Wait       (60.0f)


@interface DJVeryifiTimeManager ()

@property (nonatomic, copy) DJVeryifiTimeBlock veryifiBlock;

@property (nonatomic, strong) NSMutableDictionary *timerDic;
@property (nonatomic, strong) NSMutableDictionary *blockDic;

@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval durationTime;

@end

@implementation DJVeryifiTimeManager

+ (DJVeryifiTimeManager *)manager
{
    static DJVeryifiTimeManager *timeManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        timeManager = [[self alloc] init];
    });
    
    return timeManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _timerDic = [[NSMutableDictionary alloc] init];
        _blockDic = [[NSMutableDictionary alloc] init];
        //_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verifiTime:) userInfo:nil repeats:YES];
    }
    
    return self;
}

- (NSUInteger)getTicketWithType:(DJVerificationCodeType)type
{
    NSUInteger tichet = [self.timerDic uintForKey:@(type) withDefault:0];
    
    return tichet;
}

- (NSUInteger)startTimeWithType:(DJVerificationCodeType)type process:(DJVeryifiTimeBlock)veryifiBlock
{
    return [self startTimeWithType:type duration:DJVerifiTime_Wait process:veryifiBlock];
}

- (NSUInteger)startTimeWithType:(DJVerificationCodeType)type duration:(CFTimeInterval)duration process:(DJVeryifiTimeBlock)veryifiBlock
{
    if (duration <= 0)
    {
        return 0;
    }
    
    self.durationTime = duration;
    NSUInteger tichet = [self getTicketWithType:type];
    
    if (tichet > 0)
    {
        DJVeryifiTimeBlock oldVeryifiBlock = [self.blockDic objectForKey:@(type)];
        if (oldVeryifiBlock)
        {
            oldVeryifiBlock(type, tichet, YES);
        }
        if (veryifiBlock)
        {
            [self.blockDic setObject:veryifiBlock forKey:@(type)];
            veryifiBlock(type, tichet, NO);
        }
        return tichet;
    }
    
    [self.timerDic setObject:@(self.durationTime) forKey:@(type)];
    
    if (veryifiBlock)
    {
        [self.blockDic setObject:veryifiBlock forKey:@(type)];
        veryifiBlock(type, self.durationTime, NO);
    }
    
    if (!self.timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verifiTime:) userInfo:nil repeats:YES];
//        NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    
    return DJVerifiTime_Wait;
}

- (void)stopTimeWithType:(DJVerificationCodeType)type
{
    [self.timerDic removeObjectForKey:@(type)];
    
    DJVeryifiTimeBlock veryifiBlock = [self.blockDic objectForKey:@(type)];
    if (veryifiBlock)
    {
        veryifiBlock(type, 0, YES);
    }
    
    [self.blockDic removeObjectForKey:@(type)];
}

- (void)verifiTime:(NSTimer *)theTimer
{
    for (NSNumber *key in self.timerDic.allKeys)
    {
        NSUInteger tichet = [self.timerDic uintForKey:key withDefault:0];
        tichet--;
        
        NSLog(@"%@:%@", key, @(tichet));
        
        if (tichet <= 0)
        {
            [self stopTimeWithType:[key integerValue]];
        }
        else
        {
            DJVeryifiTimeBlock veryifiBlock = [self.blockDic objectForKey:key];
            if (veryifiBlock)
            {
                veryifiBlock([key integerValue], tichet, NO);
            }
            [self.timerDic setObject:@(tichet) forKey:key];
        }
    }
    
    if (![self.timerDic.allKeys isNotEmpty])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)stopAllType
{
    [self.timerDic removeAllObjects];
    [self.blockDic removeAllObjects];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (NSUInteger)checkTimeWithType:(DJVerificationCodeType)type process:(DJVeryifiTimeBlock)veryifiBlock
{
    NSUInteger tichet = [self getTicketWithType:type];
    
    if (tichet > 0)
    {
        DJVeryifiTimeBlock oldVeryifiBlock = [self.blockDic objectForKey:@(type)];
        if (oldVeryifiBlock)
        {
            oldVeryifiBlock(type, tichet, YES);
        }
        if (veryifiBlock)
        {
            [self.blockDic setObject:veryifiBlock forKey:@(type)];
            veryifiBlock(type, tichet, NO);
        }
        return tichet;
    }

    if (veryifiBlock)
    {
        veryifiBlock(type, 0, YES);
    }
    
    return tichet;
}

@end
