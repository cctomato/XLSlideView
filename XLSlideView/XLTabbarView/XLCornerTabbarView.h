//
//  XLCornerTabbarView.h
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLCornerTabbarViewDelegate <NSObject>

@optional
- (void)XLCornerTabbar:(id)sender selectAt:(NSInteger)index;

@end

@interface XLCornerTabbarView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@property (nonatomic, strong) UIColor *customBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, assign) CGFloat normalSpace;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, assign) CGFloat animationTime;
@property (nonatomic, weak) id<XLCornerTabbarViewDelegate> delegate;

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(CGFloat)percent;

@end
