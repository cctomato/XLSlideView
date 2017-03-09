//
//  XLSlideView.m
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLSlideView.h"

static const CGFloat switchOffset = 50.0f;

@interface XLSlideView ()
@property (nonatomic, assign) NSInteger fromIndex;
@property (nonatomic, assign) NSInteger toIndex;
@property (nonatomic, assign) BOOL isSwitching;

@property (nonatomic, strong) UIViewController *fromViewController;
@property (nonatomic, strong) UIViewController *toViewController;

@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@end

@implementation XLSlideView

- (UIPanGestureRecognizer *)panGesture
{
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (void)commonInit
{
    self.fromIndex = -1;
    self.toIndex = -1;
    self.isSwitching = NO;
    
    [self addGestureRecognizer:self.panGesture];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)disbleTap
{
    self.panGesture.enabled = NO;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex != self.fromIndex) {
        [self switchTo:selectedIndex];
    }
}

- (void)switchTo:(NSInteger)index
{
    if (index == self.fromIndex) {
        return;
    }
    
    if (self.isSwitching) {
        return;
    }
    
    if (self.fromViewController != nil && self.fromViewController.parentViewController == self.baseViewController) {
        self.isSwitching = YES;
        
        UIViewController *newViewController = [self.dataSource XLSlideView:self controllerAt:index];
        
        [self.fromViewController willMoveToParentViewController:nil];
        [self.baseViewController addChildViewController:newViewController];
        
        CGRect nowRect = self.fromViewController.view.frame;
        CGRect leftRect = CGRectMake(nowRect.origin.x - nowRect.size.width, nowRect.origin.y, nowRect.size.width, nowRect.size.height);
        CGRect rightRect = CGRectMake(nowRect.origin.x + nowRect.size.width, nowRect.origin.y, nowRect.size.width, nowRect.size.height);
        
        CGRect newStartRect;
        CGRect oldEndRect;
        if (index > self.fromIndex) {
            newStartRect = rightRect;
            oldEndRect = leftRect;
        } else {
            newStartRect = leftRect;
            oldEndRect = rightRect;
        }
        
        newViewController.view.frame = newStartRect;
        [newViewController willMoveToParentViewController:self.baseViewController];
        
        [self.baseViewController transitionFromViewController:self.fromViewController toViewController:newViewController duration:0.4 options:0 animations:^{
            newViewController.view.frame = nowRect;
            self.fromViewController.view.frame = oldEndRect;
        } completion:^(BOOL finished) {
            [self.fromViewController removeFromParentViewController];
            [newViewController didMoveToParentViewController:self.baseViewController];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(XLSlideView:didSwitchTo:)]) {
                [self.delegate XLSlideView:self didSwitchTo:index];
            }
            
            self.isSwitching = NO;
            
            self.fromIndex = index;
            self.fromViewController = newViewController;
        }];
    } else {
        [self showAt:index];
    }
}

- (void)showAt:(NSInteger)index
{
    if (self.fromIndex != index) {
        [self removeOldViewController];
        
        UIViewController *viewController = [self.dataSource XLSlideView:self controllerAt:index];
        [self.baseViewController addChildViewController:viewController];
        viewController.view.frame = self.bounds;
        [self addSubview:viewController.view];
        [viewController didMoveToParentViewController:self.baseViewController];
        self.fromIndex = index;
        self.fromViewController = viewController;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(XLSlideView:didSwitchTo:)]) {
            [self.delegate XLSlideView:self didSwitchTo:index];
        }
    }
}

- (void)removeOldViewController
{
    [self removeViewContoller:self.fromViewController];
    [self.fromViewController endAppearanceTransition];
    self.fromViewController = nil;
    self.fromIndex = -1;
}

- (void)removeNewViewController
{
    [self.toViewController beginAppearanceTransition:NO animated:NO];
    [self removeViewContoller:self.toViewController];
    [self.toViewController endAppearanceTransition];
    self.toViewController = nil;
    self.toIndex = -1;
}

- (void)removeViewContoller:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:self];
//    CGPoint location = [gestureRecognizer locationInView:self];
    if (self.fromIndex == 0 && translation.x >= 0) {
        return NO;
    }
    if (self.fromIndex == [self.dataSource numberOfControllersInXLSlideView:self] - 1 && translation.x <= 0) {
        return NO;
    }
//    
//    if (location.x >= 0 && location.x <= 30) {
//        return NO;
//    }
    return YES;
}

- (void)panHandler:(UIPanGestureRecognizer *)pan
{
    if (self.fromIndex < 0) {
        return;
    }
    
    CGPoint point = [pan translationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.panStartPoint = point;
        [self.fromViewController beginAppearanceTransition:NO animated:YES];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        NSInteger panToIndex = -1;
        CGFloat offsetX = point.x - self.panStartPoint.x;
        if (offsetX > 0) {
            panToIndex = self.fromIndex - 1;
        } else if (offsetX < 0) {
            panToIndex = self.fromIndex + 1;
        }
        
        if (panToIndex >= 0 && panToIndex < [self.dataSource numberOfControllersInXLSlideView:self]) {
            if (panToIndex != self.toIndex) {
                self.toViewController = [self.dataSource XLSlideView:self controllerAt:panToIndex];
                [self.baseViewController addChildViewController:self.toViewController];
                [self.toViewController willMoveToParentViewController:self.baseViewController];
                [self.toViewController beginAppearanceTransition:YES animated:YES];
                [self addSubview:self.toViewController.view];
                
                self.toIndex = panToIndex;
            }
            [self repositionForOffsetX:offsetX];
        }
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat offsetX = point.x - self.panStartPoint.x;
        if ((self.toIndex >= 0 && self.toIndex < [self.dataSource numberOfControllersInXLSlideView:self]) && self.toIndex != self.fromIndex) {
            if (fabs(offsetX) > switchOffset) {
                NSTimeInterval animatedTime = 0;
                animatedTime = fabs(self.bounds.size.width - fabs(offsetX)) / self.bounds.size.width * 0.4;
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView animateWithDuration:animatedTime animations:^{
                    [self repositionForOffsetX:(offsetX > 0 ? self.bounds.size.width : -self.bounds.size.width)];
                } completion:^(BOOL finished) {
                    [self removeOldViewController];
                    
                    if (self.toIndex >= 0 && self.toIndex < [self.dataSource numberOfControllersInXLSlideView:self]) {
                        [self.toViewController endAppearanceTransition];
                        [self.toViewController didMoveToParentViewController:self.baseViewController];
                        self.fromIndex = self.toIndex;
                        self.fromViewController = self.toViewController;
                        self.toViewController = nil;
                        self.toIndex = -1;
                    }
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(XLSlideView:didSwitchTo:)]) {
                        [self.delegate XLSlideView:self didSwitchTo:self.fromIndex];
                    }
                }];
            } else {
                [self backToOldWithOffset:offsetX];
            }
        } else {
            [self backToOldWithOffset:offsetX];
        }
    }
}

- (void)repositionForOffsetX:(CGFloat)offsetX
{
    CGFloat x = 0.0f;
    
    if (self.toIndex < self.fromIndex) {
        x = self.bounds.origin.x - self.bounds.size.width + offsetX;
    } else if (self.toIndex > self.fromIndex) {
        x = self.bounds.origin.x + self.bounds.size.width + offsetX;
    }

    self.fromViewController.view.frame = CGRectMake(self.bounds.origin.x + offsetX, self.bounds.origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    if (self.toIndex >= 0 && self.toIndex < [self.dataSource numberOfControllersInXLSlideView:self]) {
        self.toViewController.view.frame = CGRectMake(x, self.bounds.origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XLSlideView:switchingFrom:to:percent:)]) {
        [self.delegate XLSlideView:self switchingFrom:self.fromIndex to:self.toIndex percent:fabs(offsetX)/self.bounds.size.width];
    }
}

- (void)backToOldWithOffset:(CGFloat)offsetX
{
    NSTimeInterval animatedTime = 0.3;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self repositionForOffsetX:0];
    } completion:^(BOOL finished) {
        if ((self.toIndex >= 0 && self.toIndex < [self.dataSource numberOfControllersInXLSlideView:self]) && self.toIndex != self.fromIndex) {
            [self.fromViewController beginAppearanceTransition:YES animated:NO];
            [self removeNewViewController];
            [self.fromViewController endAppearanceTransition];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(XLSlideView:switchCanceled:)]) {
            [self.delegate XLSlideView:self switchCanceled:self.fromIndex];
        }
    }];
}

@end
