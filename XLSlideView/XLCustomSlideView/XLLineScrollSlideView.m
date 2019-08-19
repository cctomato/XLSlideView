//
//  XLLineScrollSlideView.m
//  XLSlideViewDemo
//
//  Created by Cai Cai on 2019/8/19.
//  Copyright © 2019 cai cai. All rights reserved.
//

#import "XLLineScrollSlideView.h"

@interface XLLineScrollSlideView ()
@property (nonatomic, strong) XLLineScrollTabbarView *tabBarView;
@property (nonatomic, strong) XLSlideView *slideView;
@property (nonatomic, strong) XLSlideLRUCache *viewControllerCache;
@end

@implementation XLLineScrollSlideView

- (XLLineScrollTabbarView *)tabBarView
{
    if (_tabBarView == nil) {
        _tabBarView = [[XLLineScrollTabbarView alloc] init];
        _tabBarView.delegate = self;
    }
    return _tabBarView;
}

- (XLSlideView *)slideView
{
    if (_slideView == nil) {
        _slideView = [[XLSlideView alloc] init];
        _slideView.delegate = self;
        _slideView.dataSource = self;
    }
    return _slideView;
}

- (void)commonInit
{
    self.tabBarHeight = 44;
    self.animationTime = 0.25;
    
    [self addSubview:self.tabBarView];
    [self addSubview:self.slideView];
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

- (void)setSelectedColor:(UIColor *)selectedColor
{
    self.tabBarView.selectedColor = selectedColor;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    self.tabBarView.normalColor = normalColor;
}

- (void)setNormalFont:(UIFont *)normalFont
{
    self.tabBarView.normalFont = normalFont;
}

- (void)setBaseViewController:(UIViewController *)baseViewController
{
    self.slideView.baseViewController = baseViewController;
}

- (void)setItemArray:(NSArray<NSString *> *)itemArray
{
    _itemArray = itemArray;
    self.viewControllerCache = [[XLSlideLRUCache alloc] initWithCount:itemArray.count];
    self.tabBarView.itemArray = itemArray;
}

- (void)setTabBarColor:(UIColor *)tabBarColor
{
    self.tabBarView.backgroundColor = tabBarColor;
}

- (void)setAnimationTime:(CGFloat)animationTime
{
    self.slideView.animationTime = animationTime;
    self.tabBarView.animationTime = animationTime;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    self.tabBarView.selectedIndex = selectedIndex;
    self.slideView.selectedIndex = selectedIndex;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBarView.frame = CGRectMake(0, 0, self.bounds.size.width, self.tabBarHeight);
    
    self.slideView.frame = CGRectMake(0, CGRectGetMaxY(self.tabBarView.frame), self.bounds.size.width, self.bounds.size.height - self.tabBarHeight);
}

- (void)XLLineScrollTabbar:(id)sender selectAt:(NSInteger)index
{
    _selectedIndex = index;
    
    self.slideView.selectedIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(XLLineScrollSlideViewDidChange)]) {
        [self.delegate XLLineScrollSlideViewDidChange];
    }
}

- (NSInteger)numberOfControllersInXLSlideView:(XLSlideView *)sender
{
    return [self.delegate numberOfControllersInXLLineScrollSlideView:self];
}

- (void)XLSlideView:(XLSlideView *)slideView didSwitchTo:(NSInteger)index
{
    _selectedIndex = index;
    
    self.tabBarView.selectedIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(XLLineScrollSlideViewDidChange)]) {
        [self.delegate XLLineScrollSlideViewDidChange];
    }
}

- (void)XLSlideView:(XLSlideView *)slideView switchCanceled:(NSInteger)oldIndex
{
    self.tabBarView.selectedIndex = oldIndex;
}

- (void)XLSlideView:(XLSlideView *)slideView switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(CGFloat)percent
{
//    [self.tabBarView]
    [self.tabBarView switchingFrom:oldIndex to:toIndex percent:percent];
}

- (UIViewController *)XLSlideView:(XLSlideView *)sender controllerAt:(NSInteger)index
{
    long indexs = index;
    NSString *key = [NSString stringWithFormat:@"%ld", indexs];
    if ([self.viewControllerCache xl_objectForKey:key]) {
        UIViewController *viewController = [self.viewControllerCache xl_objectForKey:key];
        return viewController;
    } else {
        UIViewController *viewController = [self.delegate XLLineScrollSlideView:self controllerAt:index];
        [_viewControllerCache xl_setObject:viewController forKey:key];
        return viewController;
    }
}

@end
