//
//  DJTextItem.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/22.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import "DJInputItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJTextItem : DJInputItem

// TextField
//
// default is UITextFieldViewModeNever
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;
// default is NO
@property (nonatomic, assign) BOOL clearsOnBeginEditing;

@property (nullable, nonatomic, strong) UIColor *textFieldBgColor;
@property (nonatomic, assign) UIEdgeInsets textFieldSeparatorInset;

@property (nonatomic, assign) NSTextAlignment textFieldAlignment;

@property (nullable, nonatomic, strong) UIColor *textFieldTextColor;
@property (nullable, nonatomic, strong) UIFont *textFieldTextFont;

@property (nullable, nonatomic, strong) UIColor *textFieldPlaceholderColor;

@end

NS_ASSUME_NONNULL_END

