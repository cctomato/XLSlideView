# XLSlideView
XLSlideView is a multi-UIViewController management container.

## Usage

XLSlideView offers two different styles, including XLCornerSlideView and XLLineSlideView.

- ### XLCornerSlideView

    ![snapshot](/Snapshots/corner.gif)

    #### Initialize XLCornerSlideView
    ```objc
    self.automaticallyAdjustsScrollViewInsets = NO;
    XLCornerSlideView *slideView = [[XLCornerSlideView alloc] initWithFrame:CGRectMake(0, 20 + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44)];
    slideView.delegate = self;
    slideView.baseViewController = self;
    slideView.itemArray = @[@"View1", @"View2", @"View3", @"View4", @"View5", @"View6", @"View7", @"View8"];
    slideView.selectedIndex = 0;
    [self.view addSubview:slideView];
    ```

    #### Implement delegate
    ```objc
    - (NSInteger)numberOfControllersInXLCornerSlideView:(XLCornerSlideView *)sender
    {
        return 8;
    }

    - (UIViewController *)XLCornerSlideView:(XLCornerSlideView *)sender controllerAt:(NSInteger)index
    {
        XLChildViewController *viewController = [[XLChildViewController alloc] init];
        return viewController;
    }
    ```

- #### XLLineSlideView

    ![snapshot](/Snapshots/line.gif)

    #### Initialize XLLineSlideView
    ```objc
    self.automaticallyAdjustsScrollViewInsets = NO;
    XLLineSlideView *slideView = [[XLLineSlideView alloc] initWithFrame:CGRectMake(0, 20 + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44)];
    slideView.delegate = self;
    slideView.baseViewController = self;
    slideView.itemArray = @[@"View1", @"View2", @"View3"];
    slideView.selectedIndex = 0;
    [self.view addSubview:slideView];
    ```

    #### Implement delegate
    ```objc
    - (NSInteger)numberOfControllersInXLLineSlideView:(XLLineSlideView *)sender
    {
        return 3;
    }

    - (UIViewController *)XLLineSlideView:(XLLineSlideView *)sender controllerAt:(NSInteger)index
    {
        XLChildViewController *viewController = [[XLChildViewController alloc] init];
        return viewController;
    }
    ```

- #### Please refer to Demo for more settings

## Installation

Use CocoaPods

```ruby
pod 'XLSlideView'
```

## License

MIT