//
//  DJTableViewSegmentCell.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/17.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJTableViewSegmentCell : DJTableViewCell

@property (nonatomic, strong, readonly) UISegmentedControl *segmentView;

@end

NS_ASSUME_NONNULL_END

