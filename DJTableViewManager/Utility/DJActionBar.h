//
//  DJActionBar.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2017/8/7.
//  Copyright © 2017年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DJActionBarDelegate;

@interface DJActionBar : UIToolbar

@property (nonatomic, strong, readonly) UISegmentedControl *navigationControl;
@property (nonatomic, weak) id<DJActionBarDelegate> actionBarDelegate;

- (instancetype)initWithDelegate:(id<DJActionBarDelegate>)delegate;

@end

@protocol DJActionBarDelegate <NSObject>

- (void)actionBar:(DJActionBar *)actionBar navigationControlValueChanged:(UISegmentedControl *)navigationControl;
- (void)actionBar:(DJActionBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem;

@end

NS_ASSUME_NONNULL_END
