//
//  DJVeryifiTimeManager.h
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

@interface DJVeryifiTimeManager : NSObject

typedef void(^DJVeryifiTimeBlock)(DJVerificationCodeType type, NSUInteger ticket, BOOL stop);


+ (DJVeryifiTimeManager *)manager;

- (NSUInteger)startTimeWithType:(DJVerificationCodeType)type process:(DJVeryifiTimeBlock)veryifiBlock;
- (NSUInteger)startTimeWithType:(DJVerificationCodeType)type duration:(CFTimeInterval)duration process:(DJVeryifiTimeBlock)veryifiBlock;
- (void)stopTimeWithType:(DJVerificationCodeType)type;

- (void)stopAllType;

- (NSUInteger)checkTimeWithType:(DJVerificationCodeType)type process:(DJVeryifiTimeBlock)veryifiBlock;

@end
