//
//  DJCountDownManager.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/11/12.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJCountDownManager.h"
#import "NSObject+Category.h"

@interface DJCountDownItem ()

// 倒计时标识
//@property (nonatomic, strong) NSString *identifier;
// 倒计时剩余时间(单位:秒)
@property (nonatomic, assign) NSInteger timeInterval;
// 每秒触发响应事件
@property (nullable, nonatomic, copy) DJCountDownProcessBlock processBlock;

@end


@interface DJCountDownManager ()

@property (nonatomic, strong) NSTimer *timer;

/// 倒计时项目存储
@property (nonatomic, strong) NSMutableDictionary<id, DJCountDownItem *> *countDownDict;

@end


#pragma mark -
#pragma mark DJCountDownManager

@implementation DJCountDownManager

+ (instancetype)manager
{
    static DJCountDownManager *countDownManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        countDownManager = [[self alloc] init];
    });
    
    return countDownManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _countDownDict = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

// 获取倒计时
- (NSInteger)timeIntervalWithIdentifier:(id)identifier
{
    return self.countDownDict[identifier].timeInterval;
}

- (BOOL)isCountDownWithIdentifier:(id)identifier
{
    DJCountDownItem *countDownItem = self.countDownDict[identifier];
    return (countDownItem.timeInterval > 0);
}

- (void)startCountDownWithIdentifier:(id)identifier processBlock:(DJCountDownProcessBlock)processBlock
{
    [self startCountDownWithIdentifier:identifier timeInterval:DJCountDown_DefaultTimeInterval processBlock:processBlock];
}

- (void)startCountDownWithIdentifier:(id)identifier timeInterval:(NSInteger)timeInterval processBlock:(DJCountDownProcessBlock)processBlock
{
    // 倒计时时间判断
    if (timeInterval <= 0)
    {
        return;
    }
    
    DJCountDownItem *countDownItem = self.countDownDict[identifier];
    
    if (!countDownItem)
    {
        // 不存在标识的倒计时创建
        countDownItem = [DJCountDownItem countDownItemWithTimeInterval:timeInterval processBlock:processBlock];
        self.countDownDict[identifier] = countDownItem;
        
        if (processBlock)
        {
            // 调用processBlock
            processBlock(identifier, countDownItem.timeInterval, NO);
        }
    }
    else if (countDownItem.timeInterval <= 0)
    {
        // 调试，检查线程错误使用
        // 待完善
        NSAssert(NO, @"Check DJCountDownManager timeInterval");
    }
    else
    {
        DJCountDownProcessBlock oldProcessBlock = countDownItem.processBlock;
        if (oldProcessBlock)
        {
            // 调用旧的processBlock，并发送stop状态
            oldProcessBlock(identifier, countDownItem.timeInterval, YES);
        }
        
        if (processBlock)
        {
            // 调用新的processBlock
            countDownItem.processBlock = processBlock;
            processBlock(identifier, countDownItem.timeInterval, NO);
        }
    }
    
    if (!self.timer)
    {
        // 启动时钟
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTime:) userInfo:nil repeats:YES];
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)setProcessBlock:(DJCountDownProcessBlock)processBlock withIdentifier:(id)identifier
{
    DJCountDownItem *countDownItem = self.countDownDict[identifier];
    if (countDownItem)
    {
        countDownItem.processBlock = processBlock;
    }
}

- (void)removeProcessBlockWithIdentifier:(id)identifier
{
    // 移除响应事件
    [self setProcessBlock:nil withIdentifier:identifier];
}

- (void)stopCountDownIdentifier:(id)identifier
{
    [self stopCountDownIdentifier:identifier forcedStop:YES];
}

- (void)stopCountDownIdentifier:(id)identifier forcedStop:(BOOL)stop
{
    DJCountDownItem *countDownItem = self.countDownDict[identifier];
    if (countDownItem)
    {
        [self.countDownDict removeObjectForKey:identifier];
        
        if (countDownItem.processBlock)
        {
            countDownItem.processBlock(identifier, countDownItem.timeInterval, stop);
        }
    }
    
    [self checkInvalidate];
}

- (void)stopAllCountDown
{
    for (id identifier in self.countDownDict.allKeys)
    {
        [self stopCountDownIdentifier:identifier];
    }
}

- (void)stopAllCountDownDoNothing
{
    [self.countDownDict removeAllObjects];

    [self checkInvalidate];
}

- (void)checkInvalidate
{
    // 判断停止时钟
    if (![self.countDownDict.allKeys isNotEmpty])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)countDownTime:(NSTimer *)theTimer
{
    for (id identifier in self.countDownDict.allKeys)
    {
        DJCountDownItem *countDownItem = self.countDownDict[identifier];

        NSLog(@"%@ : %@", identifier, @(countDownItem.timeInterval));
        
        if (countDownItem.timeInterval <= 0)
        {
            [self stopCountDownIdentifier:identifier forcedStop:NO];
        }
        else
        {
            countDownItem.timeInterval--;

            if (countDownItem.processBlock)
            {
                countDownItem.processBlock(identifier, countDownItem.timeInterval, NO);
            }
        }
    }
    
    //[self checkInvalidate];
}

@end


#pragma mark -
#pragma mark DJCountDownItem

@implementation DJCountDownItem

+ (instancetype)countDownItemWithTimeInterval:(NSInteger)timeInterval
{
    DJCountDownItem *countDownItem = [[DJCountDownItem alloc] initWithTimeInterval:timeInterval];
    return countDownItem;
}

+ (instancetype)countDownItemWithTimeInterval:(NSInteger)timeInterval processBlock:(DJCountDownProcessBlock)processBlock
{
    DJCountDownItem *countDownItem = [[DJCountDownItem alloc] initWithTimeInterval:timeInterval processBlock:processBlock];
    return countDownItem;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.timeInterval = DJCountDown_DefaultTimeInterval;
    }
    return self;
}

- (instancetype)initWithTimeInterval:(NSInteger)timeInterval
{
    return [self initWithTimeInterval:timeInterval processBlock:nil];
}

- (instancetype)initWithTimeInterval:(NSInteger)timeInterval processBlock:(DJCountDownProcessBlock)processBlock
{
    self = [self init];
    if (self)
    {
        if (timeInterval <= 0)
        {
            timeInterval = DJCountDown_DefaultTimeInterval;
        }
        self.timeInterval = timeInterval;
        self.processBlock = processBlock;
    }
    return self;
}

@end
