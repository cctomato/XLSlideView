//
//  XLSlideView.h
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLSlideView;

@protocol XLSlideViewDataSource <NSObject>

@required
- (NSInteger)numberOfControllersInXLSlideView:(XLSlideView *)sender;
- (UIViewController *)XLSlideView:(XLSlideView *)sender controllerAt:(NSInteger)index;

@end

@protocol XLSlideViewDelegate <NSObject>

@optional
- (void)XLSlideView:(XLSlideView *)slideView switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(CGFloat)percent;
- (void)XLSlideView:(XLSlideView *)slideView didSwitchTo:(NSInteger)index;
- (void)XLSlideView:(XLSlideView *)slideView switchCanceled:(NSInteger)oldIndex;

@end

@interface XLSlideView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) UIViewController *baseViewController;
@property (nonatomic, weak) id<XLSlideViewDataSource> dataSource;
@property (nonatomic, weak) id<XLSlideViewDelegate> delegate;
@property (nonatomic, assign) CGFloat animationTime;

- (void)disbleTap;
- (void)switchTo:(NSInteger)index;
@end
