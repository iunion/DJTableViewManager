//
//  UIView+Positioning.h
//  DJkit
//
//  Created by DennisDeng on 14-5-5.
//  Copyright (c) 2014年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Positioning)

- (void)centerInRect:(CGRect)rect;
- (void)centerInRect:(CGRect)rect leftOffset:(CGFloat)left;
- (void)centerInRect:(CGRect)rect topOffset:(CGFloat)top;
- (void)centerVerticallyInRect:(CGRect)rect;
- (void)centerVerticallyInRect:(CGRect)rect left:(CGFloat)left;
- (void)centerHorizontallyInRect:(CGRect)rect;
- (void)centerHorizontallyInRect:(CGRect)rect top:(CGFloat)top;

- (void)centerInSuperView;
- (void)centerInSuperViewWithLeftOffset:(CGFloat)left;
- (void)centerInSuperViewWithTopOffset:(CGFloat)top;
- (void)centerVerticallyInSuperView;
- (void)centerVerticallyInSuperViewWithLeft:(CGFloat)left;
- (void)centerHorizontallyInSuperView;
- (void)centerHorizontallyInSuperViewWithTop:(CGFloat)top;

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
- (void)centerHorizontallyBelow:(UIView *)view;

@end

@interface UIView (wiSubview)

/**
 * The view controller whose view contains this view.
 */
// 只有在addSubView后才有用，不要再init中使用
@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) NSInteger subviewIndex;

- (void)addSubviewToBack:(UIView*)view;

- (UIView *)superviewWithClass:(Class)aClass; // strict:NO
- (UIView *)superviewWithClass:(Class)aClass strict:(BOOL)strict;

- (UIView *)descendantOrSelfWithClass:(Class)aClass; // strict:NO
- (UIView *)descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict;

- (void)removeAllSubviews;

- (void)bringToFront;
- (void)sendToBack;

- (void)bringOneLevelUp;
- (void)sendOneLevelDown;

- (BOOL)isInFront;
- (BOOL)isAtBack;

- (void)swapDepthsWithView:(UIView*)swapView;


// view searching

- (UIView *)viewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (UIView *)viewOfClass:(Class)viewClass;
- (NSArray *)viewsMatchingPredicate:(NSPredicate *)predicate;
- (NSArray *)viewsWithTag:(NSInteger)tag;
- (NSArray *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (NSArray *)viewsOfClass:(Class)viewClass;

- (UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)firstSuperviewOfClass:(Class)viewClass;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass;

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate;
- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass;
- (BOOL)isSuperviewOfView:(UIView *)view;
- (BOOL)isSubviewOfView:(UIView *)view;

// 只有在addSubView后才有用，不要再init中使用
// 同viewController
- (UIViewController *)firstViewController;
- (UIView *)firstResponder;

/** Converts the view's center coordinate to a view.
 @param view The given view to translate to.
 @return The point the correlates to the center of the view on the given view.
 */
- (CGPoint)convertCenterToView:(UIView *)view;

/** Converts the view's frame to a view.
 @param view The given view to translate to.
 @return The `CGRect` the correlates to the center of the view on the given view.
 */
- (CGRect)convertFrameToView:(UIView *)view;

/** Moves the view to a different superview while maintaining its overall position.
 @param view The view that will hold the view.
 */
- (void)moveToView:(UIView *)view;

/** Moves the view to the back of a different superview while maintaining its overall position.
 @param view The view that will hold the view.
 */
- (void)moveToBackOfView:(UIView *)view;

@end

@interface UIView (TTUICommon)

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView *)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView *)ancestorOrSelfWithClass:(Class)cls;

@end
