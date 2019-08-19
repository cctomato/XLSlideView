//
//  XLLineScrollSlideView.h
//  XLSlideViewDemo
//
//  Created by Cai Cai on 2019/8/19.
//  Copyright © 2019 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XLLineScrollTabbarView.h"
#import "XLSlideView.h"
#import "XLSlideLRUCache.h"

@class XLLineScrollSlideView;

@protocol XLLineScrollSlideViewDelegate <NSObject>

@required
- (NSInteger)numberOfControllersInXLLineScrollSlideView:(XLLineScrollSlideView *)sender;
- (UIViewController *)XLLineScrollSlideView:(XLLineScrollSlideView *)sender controllerAt:(NSInteger)index;

@optional
- (void)XLLineScrollSlideViewDidChange;
@end

@interface XLLineScrollSlideView : UIView<XLSlideViewDelegate, XLSlideViewDataSource, XLLineScrollTabbarViewDelegate>
@property(nonatomic, weak) UIViewController *baseViewController;

@property(nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *tabBarColor;
@property (nonatomic, assign) CGFloat animationTime;

@property(nonatomic, weak) id<XLLineScrollSlideViewDelegate> delegate;
@end

