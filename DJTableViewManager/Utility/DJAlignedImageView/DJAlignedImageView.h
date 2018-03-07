//
//  DJAlignedImageView.h
//  DJAlignedImageViewSample
//
//  Created by DJ on 2018/3/1.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DJImageViewHorizontallyAlignment)
{
    // 左
    DJImageViewHorizontallyAlignmentLeft = 0,
    // Default 中
    DJImageViewHorizontallyAlignmentCenter,
    // 右
    DJImageViewHorizontallyAlignmentRight,
};

typedef NS_ENUM(NSUInteger, DJImageViewVerticallyAlignment)
{
    // 上
    DJImageViewVerticallyAlignmentTop = 0,
    // Default 中
    DJImageViewVerticallyAlignmentCenter,
    // 下
    DJImageViewVerticallyAlignmentBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface DJAlignedImageView : UIView

@property (nonatomic, strong, readonly) UIImageView *realImageView;

@property (nonatomic, assign) DJImageViewHorizontallyAlignment horizontallyAlignment;
@property (nonatomic, assign) DJImageViewVerticallyAlignment verticallyAlignment;

@property (nonatomic, assign) BOOL enableScaleUp;
@property (nonatomic, assign) BOOL enableScaleDown;

@property (nullable, nonatomic) UIImage *image;
@property (nullable, nonatomic) UIImage *highlightedImage;

@property (nonatomic, getter=isHighlighted) BOOL highlighted;

@property (nullable, nonatomic) NSArray<UIImage *> *animationImages;
@property (nullable, nonatomic) NSArray<UIImage *> *highlightedAnimationImages;

@property (nonatomic) NSTimeInterval animationDuration;
@property (nonatomic) NSInteger      animationRepeatCount;

@property (null_resettable, nonatomic) UIColor *tintColor;

- (void)startAnimating;
- (void)stopAnimating;
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly, getter=isAnimating) BOOL animating;
#else
- (BOOL)isAnimating;
#endif

- (instancetype)initWithImage:(nullable UIImage *)image;
- (instancetype)initWithImage:(nullable UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage;



@end

NS_ASSUME_NONNULL_END
