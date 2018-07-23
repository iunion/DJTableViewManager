//
//  DJPlaceholderTextView.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/19.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJPlaceholderTextView : UITextView

@property (nonatomic, strong, readonly) UILabel *placeholderLabel;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributePlaceholder;

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, assign) NSLineBreakMode placeholderLineBreakMode;

- (void)textChanged:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END

