//
//  XLLineScrollTabbarView.h
//  XLSlideViewDemo
//
//  Created by Cai Cai on 2019/8/19.
//  Copyright © 2019 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLLineScrollTabbarViewDelegate <NSObject>

@optional
- (void)XLLineScrollTabbar:(id)sender selectAt:(NSInteger)index;

@end

@interface XLLineScrollTabbarView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@property (nonatomic, strong) UIColor *customBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, assign) CGFloat normalSpace;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, assign) CGFloat animationTime;
@property (nonatomic, weak) id<XLLineScrollTabbarViewDelegate> delegate;

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(CGFloat)percent;
@end


