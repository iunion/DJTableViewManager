//
//  DJVeryifiTimeManager.m
//  DJkit
//
//  Created by DennisDeng on 16/4/21.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import "DJVerifiTimeManager.h"
#import "NSDictionary+Category.h"
#import "NSObject+Category.h"


#define DJVerifiTime_Wait       (60.0f)


@interface DJVerifiTimeManager ()

@property (nonatomic, copy) DJVerifiTimeBlock verifiBlock;

@property (nonatomic, strong) NSMutableDictionary *timerDic;
@property (nonatomic, strong) NSMutableDictionary *blockDic;

@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval durationTime;

@end

@implementation DJVerifiTimeManager

+ (DJVerifiTimeManager *)manager
{
    static DJVerifiTimeManager *timeManager = nil;
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

- (NSInteger)getTicketWithType:(DJVerificationCodeType)type
{
    NSInteger tichet = [self.timerDic intForKey:@(type) withDefault:0];
    
    return tichet;
}

- (NSInteger)startTimeWithType:(DJVerificationCodeType)type process:(DJVerifiTimeBlock)veryifiBlock
{
    return [self startTimeWithType:type duration:DJVerifiTime_Wait process:veryifiBlock];
}

- (NSInteger)startTimeWithType:(DJVerificationCodeType)type duration:(CFTimeInterval)duration process:(DJVerifiTimeBlock)veryifiBlock
{
    if (duration <= 0)
    {
        return 0;
    }
    
    self.durationTime = duration;
    NSInteger tichet = [self getTicketWithType:type];
    
    if (tichet > 0)
    {
        DJVerifiTimeBlock oldVeryifiBlock = [self.blockDic objectForKey:@(type)];
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
    [self stopTimeWithType:type stop:YES];
}

- (void)stopTimeWithType:(DJVerificationCodeType)type stop:(BOOL)stop
{
    [self.timerDic removeObjectForKey:@(type)];
    
    DJVerifiTimeBlock veryifiBlock = [self.blockDic objectForKey:@(type)];
    if (veryifiBlock)
    {
        veryifiBlock(type, 0, stop);
    }
    
    [self.blockDic removeObjectForKey:@(type)];
    
    if (![self.timerDic.allKeys isNotEmpty])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)removeBlockWithType:(DJVerificationCodeType)type
{
    [self.blockDic removeObjectForKey:@(type)];
}

- (void)verifiTime:(NSTimer *)theTimer
{
    for (NSNumber *key in self.timerDic.allKeys)
    {
        NSInteger tichet = [self.timerDic intForKey:key withDefault:0];
        tichet--;
        
        NSLog(@"%@:%@", key, @(tichet));
        
        if (tichet <= 0)
        {
            [self stopTimeWithType:[key integerValue] stop:NO];
        }
        else
        {
            DJVerifiTimeBlock veryifiBlock = [self.blockDic objectForKey:key];
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
    // 注意：这里没有调用block
    // 如果想调用block，请使用 stopTimeWithType:
    [self.timerDic removeAllObjects];
    [self.blockDic removeAllObjects];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (NSInteger)checkTimeWithType:(DJVerificationCodeType)type process:(DJVerifiTimeBlock)verifiBlock
{
    NSInteger tichet = [self getTicketWithType:type];
    
    if (tichet > 0)
    {
        DJVerifiTimeBlock oldVeryifiBlock = [self.blockDic objectForKey:@(type)];
        if (oldVeryifiBlock)
        {
            oldVeryifiBlock(type, tichet, YES);
        }
        if (verifiBlock)
        {
            [self.blockDic setObject:verifiBlock forKey:@(type)];
            verifiBlock(type, tichet, NO);
        }
        return tichet;
    }

    if (verifiBlock)
    {
        verifiBlock(type, 0, YES);
    }
    
    return tichet;
}

@end
