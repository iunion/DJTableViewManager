//
//  DJImageDetailItem.h
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/7/30.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJImageDetailItem : DJTableViewItem

// 图标
@property (nullable, nonatomic, strong) NSString *detailImage;
@property (nullable, nonatomic, strong) NSString *detailImageUrl;

// UI
@property (nonatomic, assign) CGFloat detailImageWidth;
@property (nonatomic, assign) CGFloat imageDetailGap;

@property (nullable, nonatomic, copy)  tableViewImageLoadedHandler imageLoadedHandler;

@end

NS_ASSUME_NONNULL_END

