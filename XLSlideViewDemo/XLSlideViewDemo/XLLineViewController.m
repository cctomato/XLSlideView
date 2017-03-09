//
//  XLLineViewController.m
//  XLSlideViewDemo
//
//  Created by cai cai on 2017/3/8.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLLineViewController.h"
#import "XLLineSlideView.h"
#import "XLChildViewController.h"

@interface XLLineViewController ()<XLLineSlideViewDelegate>
@property (nonatomic, strong) XLLineSlideView *slideView;
@property (nonatomic, strong) NSArray<NSString *> *itemArray;
@end

@implementation XLLineViewController

- (NSArray<NSString *> *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = @[@"View1", @"View2", @"View3"];
    }
    return _itemArray;
}

- (XLLineSlideView *)slideView
{
    if (_slideView == nil) {
        _slideView = [[XLLineSlideView alloc] initWithFrame:CGRectMake(0, 20 + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44)];
        _slideView.delegate = self;
    }
    return _slideView;
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

- (NSInteger)numberOfControllersInXLLineSlideView:(XLLineSlideView *)sender
{
    return self.itemArray.count;
}

- (UIViewController *)XLLineSlideView:(XLLineSlideView *)sender controllerAt:(NSInteger)index
{
    XLChildViewController *viewController = [[XLChildViewController alloc] init];
    viewController.titleString = [self.itemArray objectAtIndex:index];
    return viewController;
}

@end
