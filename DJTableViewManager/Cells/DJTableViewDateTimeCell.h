//
//  DJTableViewDateTimeCell.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/15.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class DJDatePicker;

@interface DJTableViewDateTimeCell : DJTableViewCell

@property (nonatomic, strong, readonly) UITextField *hidenTextField;

@property (nonatomic, strong, readonly) UILabel *pickerTextLabel;
@property (nonatomic, strong, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong, readonly) DJDatePicker *pickerView;

@end

NS_ASSUME_NONNULL_END
