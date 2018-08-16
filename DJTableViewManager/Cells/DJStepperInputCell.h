//
//  DJStepperInputCell.h
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/8/16.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class DJStepperInputView;

@interface DJStepperInputCell : DJTableViewCell

@property (nonatomic, strong, readonly) DJStepperInputView *stepperInputView;

@end

NS_ASSUME_NONNULL_END
