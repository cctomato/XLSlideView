//
//  XLChildViewController.m
//  XLSlideViewDemo
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLChildViewController.h"

@interface XLChildViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation XLChildViewController

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat red = arc4random()%255/255.0;
    CGFloat green = arc4random()%255/255.0;
    CGFloat blue = arc4random()%255/255.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.titleLabel.textColor = [UIColor colorWithRed:(1 - red) green:(1 - green) blue:(1 - blue) alpha:1.0];
    self.titleLabel.text = self.titleString;
    [self.view addSubview:self.titleLabel];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.titleLabel.frame = self.view.bounds;
}

@end
