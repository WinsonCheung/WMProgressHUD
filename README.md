# WMProgressHUDDemo
这是一个对MBProgressHUDDE简易封装, 日常项目中需要得功能, 我相信它都能应付:
                       ![WMProgressHUD](https://github.com/WinsonCheung/WMProgressHUDDemo/blob/master/WMProgressHUD.gif)
                       
                       

#Install
Drag the WMProgressHUD folder to your project, It's so simple.

#Usage
You can use like this:
```
- (void) indeterminate {
    // show
    [WMProgressHUD showIn:self.view animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        // do something

        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES after:2.5f];
        });
    });
}

- (void) withLabel {

    [WMProgressHUD showIn:self.view text:@"加载中" animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        // do something

        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES after:2.5f];
        });
    });
}

- (void) withDetailsLabel {

    [WMProgressHUD showIn:self.view text:@"加载中" detail:@"请耐心等待" animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        // do something

        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES after:2.5f];
        });
    });
}

- (void) determinateMode {

    [WMProgressHUD showIn:self.view text:@"加载中" HUDModel:WMProgressHUDModeDeterminate animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            dispatch_async(dispatch_get_main_queue(), ^{

                [WMProgressHUD setupProgress:progress];
            });
            usleep(50000);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES];
        });
    });
}

- (void) textOnlyAtBottom {

    [WMProgressHUD showIn:self.view text:@"I'm Winson at bottom" position:WMProgressHUDPositionBottom];
    [WMProgressHUD dismissAnimated:YES after:2.5f];
}

- (void) textOnlyAtCenter {

    [WMProgressHUD showIn:self.view text:@"I'm Winson at center"];
    [WMProgressHUD dismissAnimated:YES after:2.5f];
}

- (void) customView {

    NSMutableArray *animations = [@[] mutableCopy];
    for (int i = 1; i < 4; i++) {
        NSString *animation = [NSString stringWithFormat:@"dropdown_loading_0%zd", i];
        [animations addObject:animation];
    }

    [WMProgressHUD showIn:self.view animaitions:animations text:@"吃包子"];

    [WMProgressHUD dismissAnimated:YES after:3.f];

}
```

#OTHERS
若有任何疑问, 欢迎联系~
QQ: 963307202
