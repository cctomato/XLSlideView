//
//  XLLineTabbarView.m
//  caifu
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLLineTabbarView.h"

static const NSInteger XLBaseIndex = 1000;

@interface XLLineTabbarView ()
@property (nonatomic, strong) UIView *trackView;
@property (nonatomic, assign) NSInteger fromIndex;
@property (nonatomic, assign) BOOL isSwitching;
@end

@implementation XLLineTabbarView

- (UIView *)trackView
{
    if (_trackView == nil) {
        _trackView = [[UIView alloc] init];
        _trackView.backgroundColor = self.selectedColor;
    }
    return _trackView;
}

- (void)commonInit
{
    self.isSwitching = NO;
    self.fromIndex = -1;
    self.lineHeight = 4.0f / [UIScreen mainScreen].scale;
    self.backgroundColor = [UIColor whiteColor];
    self.normalColor = [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0];
    self.selectedColor = [UIColor colorWithRed:252.0/255.0 green:174.0/255.0 blue:19.0/255.0 alpha:1.0];
    self.normalFont = [UIFont systemFontOfSize:15];
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

- (void)setItemArray:(NSArray<NSString *> *)itemArray
{
    _itemArray = itemArray;
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    for (NSInteger index = 0; index < itemArray.count; index++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = self.normalFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = self.normalColor;
        titleLabel.tag = index + XLBaseIndex;
        titleLabel.userInteractionEnabled = YES;
        [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitle:)]];
        [self addSubview:titleLabel];
    }
    
    [self addSubview:self.trackView];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex != self.fromIndex) {
        [self switchTo:selectedIndex];
    }
}

- (void)clickTitle:(UITapGestureRecognizer *)tap
{
    NSInteger newSelectedIndex = tap.view.tag - XLBaseIndex;
    if (newSelectedIndex == self.fromIndex) {
        return;
    }
    
    [self switchTo:newSelectedIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XLLineTabbar:selectAt:)]) {
        [self.delegate XLLineTabbar:self selectAt:newSelectedIndex];
    }
}

- (void)switchTo:(NSInteger)index
{
    if (self.fromIndex == index) {
        return;
    }
    
    if (self.isSwitching) {
        return;
    }
    
    if (index >= 0 && index < self.itemArray.count) {
        if (self.fromIndex != -1) {
            self.isSwitching = YES;
            
            UILabel *oldTitleLabel = [self viewWithTag:(XLBaseIndex + self.fromIndex)];
            UILabel *newTitleLabel = [self viewWithTag:(XLBaseIndex + index)];
            
            [UIView animateWithDuration:0.4 animations:^{
                CGRect trackFrame = self.trackView.frame;
                self.trackView.frame = CGRectMake(newTitleLabel.frame.origin.x, trackFrame.origin.y, trackFrame.size.width, trackFrame.size.height);
                oldTitleLabel.textColor = self.normalColor;
                newTitleLabel.textColor = self.selectedColor;
            } completion:^(BOOL finished) {
                self.isSwitching = NO;
                self.fromIndex = index;
            }];
            
        } else {
            [self showAt:index];
        }
    }
}

- (void)showAt:(NSInteger)index
{
    UILabel *newTitleLabel = [self viewWithTag:(index + XLBaseIndex)];
    newTitleLabel.textColor = self.selectedColor;
    self.fromIndex = index;
}

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(CGFloat)percent
{
    UILabel *fromLabel = [self viewWithTag:(fromIndex + XLBaseIndex)];
    UILabel *toLabel = [self viewWithTag:(toIndex + XLBaseIndex)];
    
    CGRect trackFrame = self.trackView.frame;
    
    CGFloat instance = (toLabel.frame.origin.x - fromLabel.frame.origin.x) * percent;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.trackView.frame = CGRectMake(fromLabel.frame.origin.x + instance, trackFrame.origin.y, trackFrame.size.width, trackFrame.size.height);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.itemArray.count > 0) {
        CGFloat height = self.bounds.size.height;
        CGFloat width = self.bounds.size.width / self.itemArray.count;
        for (NSInteger index = 0; index < self.itemArray.count; index++) {
            NSString *title = [self.itemArray objectAtIndex:index];
            UILabel *titleLabel = [self viewWithTag:(index + XLBaseIndex)];
            titleLabel.frame = CGRectMake(index * width, 0, width, height);
            titleLabel.text = title;
            
            if (index == self.fromIndex) {
                self.trackView.frame = CGRectMake(titleLabel.frame.origin.x, height - self.lineHeight, titleLabel.frame.size.width, self.lineHeight);
            }
        }
    }
}

@end
