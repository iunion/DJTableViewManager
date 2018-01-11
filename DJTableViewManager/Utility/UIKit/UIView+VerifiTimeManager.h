//
//  UIView+VerifiTimeManager.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/10.
//Copyright © 2018年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJVerifiTimeManager.h"

@interface UIView (VerifiTimeManager)

@property (nonatomic, copy) DJVerifiTimeBlock verifiManagerBlock;
@property (nonatomic, assign) CFTimeInterval verifiManagerdDuration;

@property (nonatomic, assign) DJVerificationCodeType verifiManagerType;

- (void)startVerifiTimeManager;

@end
