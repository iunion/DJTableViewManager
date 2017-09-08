//
//  DJTableViewTextCell.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJInsetTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets separatorInset;

- (instancetype)initWithFrame:(CGRect)frame separatorInset:(UIEdgeInsets)separatorInset;

@end

@interface DJTableViewTextCell : DJTableViewCell
<
    UITextFieldDelegate,
    RETextCellProtocol
>

@property (nonatomic, strong, readonly) DJInsetTextField *textField;

@end

NS_ASSUME_NONNULL_END

