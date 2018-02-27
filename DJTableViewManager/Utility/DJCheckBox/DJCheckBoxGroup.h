//
//  DJCheckBoxGroup.h
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/2/8.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DJCheckBox;

@interface DJCheckBoxGroup : NSObject

@property (nullable, nonatomic, strong, readonly) NSMutableArray<DJCheckBox *> *checkBoxes;

@property (nonatomic, assign) NSUInteger maxSelectedCount;
@property (nullable, nonatomic, strong, readonly) NSMutableArray<DJCheckBox *> *selectedCheckBoxes;

+ (instancetype)groupWithCheckBoxes:(nullable NSArray<DJCheckBox *> *)checkBoxes maxSelectedCount:(NSUInteger)maxSelectedCount;
- (instancetype)initWithCheckBoxes:(nullable NSArray<DJCheckBox *> *)checkBoxes maxSelectedCount:(NSUInteger)maxSelectedCount;

- (void)addCheckBoxToGroup:(nonnull DJCheckBox *)checkBox;
- (void)removeCheckBoxFromGroup:(nonnull DJCheckBox *)checkBox;

- (void)groupSelectionChangedWithCheckBox:(nonnull DJCheckBox *)checkBox;

@end

NS_ASSUME_NONNULL_END
