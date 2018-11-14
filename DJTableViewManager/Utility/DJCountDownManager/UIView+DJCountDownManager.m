//
//  UIView+DJCountDownManager.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/11/14.
//Copyright © 2018 DJ. All rights reserved.
//

#import "UIView+DJCountDownManager.h"
#import "NSObject+Category.h"
#import <objc/runtime.h>


@implementation UIView (DJCountDownManager)
@dynamic countDownIdentifier;
@dynamic countDownProcessBlock;


- (NSString *)countDownIdentifier
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setCountDownIdentifier:(NSString *)identifier
{
    if (![identifier isNotEmpty])
    {
        // identifier标识设置nil时，停止倒计时
        [self stopCountDown];
    }

    objc_setAssociatedObject(self, @selector(countDownIdentifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (DJCountDownProcessBlock)countDownProcessBlock
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setCountDownProcessBlock:(DJCountDownProcessBlock)processBlock
{
    if ([self.countDownIdentifier isNotEmpty])
    {
        if ([[DJCountDownManager manager] isCountDownWithIdentifier:self.countDownIdentifier])
        {
            // 倒计时运行时，设置每秒触发响应事件并调用一次
            if (processBlock)
            {
                NSInteger timeInterval = [[DJCountDownManager manager] timeIntervalWithIdentifier:self.countDownIdentifier];
                processBlock(self.countDownIdentifier, timeInterval, NO);
            }
            [[DJCountDownManager manager] setProcessBlock:processBlock WithIdentifier:self.countDownIdentifier];
        }
    }

    objc_setAssociatedObject(self, @selector(countDownProcessBlock), processBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)startCountDownWithTimeInterval:(NSInteger)timeInterval
{
    if (![self.countDownIdentifier isNotEmpty])
    {
        return;
    }

    [[DJCountDownManager manager] startCountDownWithIdentifier:self.countDownIdentifier timeInterval:timeInterval processBlock:self.countDownProcessBlock];
}

- (void)stopCountDown
{
    if ([self.countDownIdentifier isNotEmpty])
    {
        [[DJCountDownManager manager] stopCountDownIdentifier:self.countDownIdentifier];
    }
}

@end
