//
//  UITextField+Category.h
//  DJkit
//
//  Created by DennisDeng on 16/6/17.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

- (void)setPlaceholderColor:(nullable UIColor *)color;

- (void)selectAllText;

- (void)setSelectedRange:(NSRange)range;

@end
