//
//  DJVerifiTimeManager.h
//  DJkit
//
//  Created by DennisDeng on 16/4/21.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DJVerificationCodeType)
{
    DJVerificationCodeType_Unknown = 0,
    DJVerificationCodeType_Type1 = 1,
    DJVerificationCodeType_Type2 = 2,
    DJVerificationCodeType_Type3 = 3,
    DJVerificationCodeType_Type4 = 4,
    DJVerificationCodeType_Type5 = 5,
    DJVerificationCodeType_Type6 = 6
};

@interface DJVerifiTimeManager : NSObject

typedef void(^DJVerifiTimeBlock)(DJVerificationCodeType type, NSInteger ticket, BOOL stop);


+ (DJVerifiTimeManager *)manager;

// 启动计时
- (NSInteger)startTimeWithType:(DJVerificationCodeType)type process:(DJVerifiTimeBlock)veryifiBlock;
- (NSInteger)startTimeWithType:(DJVerificationCodeType)type duration:(CFTimeInterval)duration process:(DJVerifiTimeBlock)veryifiBlock;

// 停止计时，并调用block
- (void)stopTimeWithType:(DJVerificationCodeType)type;
// 不停止计时，只去除block调用
- (void)removeBlockWithType:(DJVerificationCodeType)type;

// 停止所有计时，不会调用block
- (void)stopAllType;

// 检查当前计时状态
- (NSInteger)checkTimeWithType:(DJVerificationCodeType)type process:(DJVerifiTimeBlock)veryifiBlock;

@end
