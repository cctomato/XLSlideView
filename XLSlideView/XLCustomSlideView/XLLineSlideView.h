//
//  XLLineSlideView.h
//  caifu
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLLineTabbarView.h"
#import "XLSlideView.h"
#import "XLSlideLRUCache.h"

@class XLLineSlideView;

@protocol XLLineSlideViewDelegate <NSObject>

@required
- (NSInteger)numberOfControllersInXLLineSlideView:(XLLineSlideView *)sender;
- (UIViewController *)XLLineSlideView:(XLLineSlideView *)sender controllerAt:(NSInteger)index;

@optional
- (void)XLLineSlideViewDidChange;
@end

@interface XLLineSlideView : UIView<XLSlideViewDelegate, XLSlideViewDataSource, XLLineTabbarViewDelegate>
@property(nonatomic, weak) UIViewController *baseViewController;

@property(nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *tabBarColor;
@property (nonatomic, assign) CGFloat animationTime;

@property(nonatomic, weak) id<XLLineSlideViewDelegate> delegate;
@end
