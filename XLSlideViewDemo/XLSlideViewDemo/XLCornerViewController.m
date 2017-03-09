//
//  XLCornerViewController.m
//  XLSlideViewDemo
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLCornerViewController.h"
#import "XLChildViewController.h"
#import "XLCornerSlideView.h"

@interface XLCornerViewController ()<XLCornerSlideViewDelegate>
@property (nonatomic, strong) XLCornerSlideView *slideView;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@end

@implementation XLCornerViewController

- (NSArray<NSString *> *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = @[@"View1", @"View2", @"View3", @"View4", @"View5", @"View6", @"View7", @"View8"];
    }
    return _itemArray;
}

- (XLCornerSlideView *)slideView
{
    if (_slideView == nil) {
        _slideView = [[XLCornerSlideView alloc] initWithFrame:CGRectMake(0, 20 + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44)];
        _slideView.delegate = self;
    }
    return _slideView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CornerSlideView";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.slideView.normalFont = [UIFont systemFontOfSize:13];
//    self.slideView.normalSpace = 10.0;
//    self.slideView.normalColor = [UIColor grayColor];
//    self.slideView.selectedColor = [UIColor blackColor];
//    self.slideView.selectedBackgroundColor = [UIColor redColor];
//    self.slideView.tabBarHeight = 44;
//    self.slideView.tabBarColor = [UIColor whiteColor];
    
    self.slideView.baseViewController = self;
    self.slideView.itemArray = self.itemArray;
    self.slideView.selectedIndex = 0;
    [self.view addSubview:self.slideView];
}

- (NSInteger)numberOfControllersInXLCornerSlideView:(XLCornerSlideView *)sender
{
    return self.itemArray.count;
}

- (UIViewController *)XLCornerSlideView:(XLCornerSlideView *)sender controllerAt:(NSInteger)index
{
    XLChildViewController *viewController = [[XLChildViewController alloc] init];
    viewController.titleString = [self.itemArray objectAtIndex:index];
    return viewController;
}

@end
