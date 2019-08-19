//
//  XLLineViewController.m
//  XLSlideViewDemo
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLLineViewController.h"
#import "XLLineScrollSlideView.h"
#import "XLChildViewController.h"

@interface XLLineViewController ()<XLLineScrollSlideViewDelegate>
@property (nonatomic, strong) XLLineScrollSlideView *slideView;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@end

@implementation XLLineViewController

- (NSArray<NSString *> *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = @[@"View2view23", @"view23", @"View3View2view23View2view23", @"view23", @"view23", @"view23", @"view23"];
    }
    return _itemArray;
}

- (XLLineScrollSlideView *)slideView
{
    if (_slideView == nil) {
        _slideView = [[XLLineScrollSlideView alloc] init];
        _slideView.delegate = self;
        _slideView.selectedColor = [UIColor redColor];
    }
    return _slideView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat top =  [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    self.slideView.frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - top);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"LineSlideView";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.slideView.normalFont = [UIFont systemFontOfSize:15];
//    self.slideView.tabBarColor = [UIColor whiteColor];
//    self.slideView.tabBarHeight = 44;
//    self.slideView.normalColor = [UIColor grayColor];
//    self.slideView.selectedColor = [UIColor blackColor];
    
    self.slideView.baseViewController = self;
    self.slideView.itemArray = self.itemArray;
    self.slideView.selectedIndex = 0;
    [self.view addSubview:self.slideView];
}

- (NSInteger)numberOfControllersInXLLineScrollSlideView:(XLLineScrollSlideView *)sender
{
    return self.itemArray.count;
}

- (UIViewController *)XLLineScrollSlideView:(XLLineScrollSlideView *)sender controllerAt:(NSInteger)index
{
    XLChildViewController *viewController = [[XLChildViewController alloc] init];
    viewController.titleString = [self.itemArray objectAtIndex:index];
    return viewController;
}

@end
