//
//  XLCornerSlideView.h
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCornerTabbarView.h"
#import "XLSlideView.h"
#import "XLSlideLRUCache.h"

@class XLCornerSlideView;

@protocol XLCornerSlideViewDelegate <NSObject>

@required
- (NSInteger)numberOfControllersInXLCornerSlideView:(XLCornerSlideView *)sender;
- (UIViewController *)XLCornerSlideView:(XLCornerSlideView *)sender controllerAt:(NSInteger)index;
@end

@interface XLCornerSlideView : UIView<XLSlideViewDelegate, XLSlideViewDataSource, XLCornerTabbarViewDelegate>
@property(nonatomic, weak) UIViewController *baseViewController;

@property(nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *tabBarColor;
@property (nonatomic, assign) CGFloat normalSpace;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, assign) CGFloat tabBarHeight;


@property(nonatomic, weak) id<XLCornerSlideViewDelegate> delegate;
@end
