//
//  UIView+DJCountDownManager.h
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/11/14.
//Copyright © 2018 DJ. All rights reserved.
//

#import "DJCountDownManager.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DJCountDownManager)

// 倒计时标识
@property (nullable, nonatomic, copy) id countDownIdentifier;
// 每秒触发响应事件
@property (nullable, nonatomic, copy) DJCountDownProcessBlock countDownProcessBlock;

// 启动倒计时，计时timeInterval
- (void)startCountDownWithTimeInterval:(NSInteger)timeInterval;
// 停止倒计时
- (void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
