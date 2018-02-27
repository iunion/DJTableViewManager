//
//  DJTableViewCheckBoxGroupCell.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/8.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class DJCheckBoxGroup;

@interface DJTableViewCheckBoxGroupCell : DJTableViewCell

@property (nonatomic, strong, readonly) DJCheckBoxGroup *checkBoxGroup;

@end

NS_ASSUME_NONNULL_END

