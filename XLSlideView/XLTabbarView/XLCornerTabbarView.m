//
//  XLCornerTabbarView.m
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLCornerTabbarView.h"

static const NSInteger XLBaseIndex = 1000;

@interface XLCornerTabbarView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *selectedBackgroundView;
@property (nonatomic, assign) BOOL isSwitching;
@property (nonatomic, assign) NSInteger fromIndex;
@end

@implementation XLCornerTabbarView

- (void)commonInit
{
    _fromIndex = -1;
    _isSwitching = NO;

    self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.selectedColor = [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1.0];
    self.normalColor = [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0];
    self.selectedBackgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.normalFont = [UIFont systemFontOfSize:13.0f];
    self.normalSpace = 5.0f;
    
    [self addSubview:self.scrollView];
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
    
    for (UIView *subView in self.scrollView.subviews) {
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
        [self.scrollView addSubview:titleLabel];
        
        if (index == 0) {
            [self.scrollView insertSubview:self.selectedBackgroundView belowSubview:titleLabel];
        }
    }
}

- (void)setCustomBackgroundColor:(UIColor *)customBackgroundColor
{
    self.backgroundColor = customBackgroundColor;
    self.scrollView.backgroundColor = customBackgroundColor;
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XLCornerTabbar:selectAt:)]) {
        [self.delegate XLCornerTabbar:self selectAt:newSelectedIndex];
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
    
    if (index < self.itemArray.count && index >= 0) {
        if (self.fromIndex != -1) {
            self.isSwitching = YES;
            UILabel *oldTitleLabel = [self.scrollView viewWithTag:(self.fromIndex + XLBaseIndex)];
            UILabel *newTitleLabel = [self.scrollView viewWithTag:(index + XLBaseIndex)];
            
            CGRect rc = newTitleLabel.frame;
            
            if (index == 0) {
                CGRect leftFrame = CGRectMake(rc.origin.x - self.normalSpace, rc.origin.y, rc.size.width + self.normalSpace, rc.size.height);
                rc = CGRectUnion(rc, leftFrame);
            }
            
            if (index > 0) {
                UILabel *leftLabel = [self.scrollView viewWithTag:(XLBaseIndex + index - 1)];
                CGRect leftFrame = CGRectMake(leftLabel.frame.origin.x - self.normalSpace, leftLabel.frame.origin.y, leftLabel.frame.size.width + self.normalSpace, leftLabel.frame.size.height);
                rc = CGRectUnion(rc, leftFrame);
            }
            
            if (index == self.itemArray.count - 1) {
                CGRect rightFrame = CGRectMake(rc.origin.x, rc.origin.y, rc.size.width + self.normalSpace, rc.size.height);
                rc = CGRectUnion(rc, rightFrame);
            }
            
            if (index < self.itemArray.count - 1) {
                UILabel *rightLabel = [self.scrollView viewWithTag:(XLBaseIndex + index + 1)];
                CGRect rightFrame = CGRectMake(rightLabel.frame.origin.x, rightLabel.frame.origin.y, rightLabel.frame.size.width + self.normalSpace, rightLabel.frame.size.height);
                rc = CGRectUnion(rc, rightFrame);
            }
            
            [UIView animateWithDuration:0.4 animations:^{
                [self.scrollView scrollRectToVisible:rc animated:YES];
                self.selectedBackgroundView.frame = newTitleLabel.frame;
                oldTitleLabel.textColor = self.normalColor;
                newTitleLabel.textColor = self.selectedColor;
            } completion:^(BOOL finished) {
                self.fromIndex = index;
                self.isSwitching = NO;
            }];
        } else {
            [self showAt:index];
        }
    }
}

- (void)showAt:(NSInteger)index
{
    UILabel *newTitleLabel = [self.scrollView viewWithTag:(index + XLBaseIndex)];
    newTitleLabel.textColor = self.selectedColor;
    self.fromIndex = index;
}

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(CGFloat)percent
{
    UILabel *fromLabel = [self.scrollView viewWithTag:(fromIndex + XLBaseIndex)];
    UILabel *toLabel = [self.scrollView viewWithTag:(toIndex + XLBaseIndex)];
    
    CGRect fromFrame = fromLabel.frame;
    CGRect selectedBackgroungFrame = self.selectedBackgroundView.frame;
    
    CGFloat instance = (toLabel.frame.origin.x - fromLabel.frame.origin.x) * percent;
    CGFloat width = (toLabel.frame.size.width - fromLabel.frame.size.width) * percent;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.selectedBackgroundView.frame = CGRectMake(fromFrame.origin.x + instance, selectedBackgroungFrame.origin.y, fromFrame.size.width + width, selectedBackgroungFrame.size.height);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;

    CGFloat height = self.scrollView.frame.size.height;
    CGFloat titleX = self.normalSpace;
    for (NSInteger index = 0; index < self.itemArray.count; index++) {
        NSString *title = [self.itemArray objectAtIndex:index];
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.normalFont}];
        CGFloat titleHeight = titleSize.height + 12;
        CGFloat titleWidth = titleSize.width + titleHeight;
        UILabel *titleLabel = [self.scrollView viewWithTag:(index + XLBaseIndex)];
        titleLabel.frame = CGRectMake(titleX, (height - titleHeight) * 0.5, titleWidth, titleHeight);
        titleLabel.text = title;
        
        titleX = titleX + titleWidth + self.normalSpace;
        
        if (index == self.fromIndex) {
            self.selectedBackgroundView.frame = titleLabel.frame;
            self.selectedBackgroundView.layer.cornerRadius = titleLabel.frame.size.height * 0.5;
        }
        
        if (index == self.itemArray.count - 1) {
            self.scrollView.contentSize = CGSizeMake(titleX, height);
        }
    }
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)selectedBackgroundView
{
    if (_selectedBackgroundView == nil) {
        _selectedBackgroundView = [[UIView alloc] init];
        _selectedBackgroundView.backgroundColor = self.selectedBackgroundColor;
    }
    return _selectedBackgroundView;
}

@end
