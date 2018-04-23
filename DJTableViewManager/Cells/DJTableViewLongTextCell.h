//
//  DJTableViewLongTextCell.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/4/20.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewCell.h"
#import "DJPlaceholderTextView.h"

@interface DJTableViewLongTextCell : DJTableViewCell
<
    UITextViewDelegate
>

@property (nonatomic, strong, readonly) DJPlaceholderTextView *textView;

@end
