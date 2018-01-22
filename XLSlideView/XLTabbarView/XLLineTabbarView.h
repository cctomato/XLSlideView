//
//  XLLineTabbarView.h
//  caifu
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLLineTabbarViewDelegate <NSObject>

@optional
- (void)XLLineTabbar:(id)sender selectAt:(NSInteger)index;

@end

@interface XLLineTabbarView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, assign) CGFloat animationTime;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@property (nonatomic, weak) id<XLLineTabbarViewDelegate> delegate;

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(CGFloat)percent;
@end
