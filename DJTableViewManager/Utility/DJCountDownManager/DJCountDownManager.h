//
//  DJCountDownManager.h
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/11/12.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define DJCountDown_DefaultTimeInterval     (60)

typedef void(^DJCountDownProcessBlock)(id identifier, NSInteger timeInterval, BOOL forcedStop);

// 注意启动多个倒计时，在计时器启动情况下会有1秒内的误差(快了不到1秒)

@interface DJCountDownManager : NSObject

+ (instancetype)manager;

// 开始倒计时
- (void)startCountDownWithIdentifier:(id)identifier processBlock:(nullable DJCountDownProcessBlock)processBlock;
- (void)startCountDownWithIdentifier:(id)identifier timeInterval:(NSInteger)timeInterval processBlock:(nullable DJCountDownProcessBlock)processBlock;

// 获取倒计时
- (NSInteger)timeIntervalWithIdentifier:(id)identifier;

// 设置processBlock调用
- (void)setProcessBlock:(nullable DJCountDownProcessBlock)processBlock withIdentifier:(id)identifier;

// 不停止计时，只去除processBlock调用
- (void)removeProcessBlockWithIdentifier:(id)identifier;

// 停止倒计时，并调用processBlock
- (void)stopCountDownIdentifier:(id)identifier;
// 停止所有倒计时，调用所有processBlock
- (void)stopAllCountDown;
// 停止所有倒计时，不会调用processBlock
- (void)stopAllCountDownDoNothing;

// 是否正在倒计时
- (BOOL)isCountDownWithIdentifier:(id)identifier;

@end


@interface DJCountDownItem : NSObject

+ (instancetype)countDownItemWithTimeInterval:(NSInteger)timeInterval;
+ (instancetype)countDownItemWithTimeInterval:(NSInteger)timeInterval processBlock:(nullable DJCountDownProcessBlock)processBlock;

- (instancetype)initWithTimeInterval:(NSInteger)timeInterval;
- (instancetype)initWithTimeInterval:(NSInteger)timeInterval processBlock:(nullable DJCountDownProcessBlock)processBlock;

@end

NS_ASSUME_NONNULL_END
