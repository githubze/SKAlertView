# Use CocoaPods
 pod 'SKAlertView, '~> 1.0.0'
 
# Use with this code
 
 SKAlertView *alert = [[SKAlertView alloc] initWithTitle:@"提示" message:@"确定要退出登录吗" cancelButtonTitle:@"返回" sureButtonTitles:@"确定" sureButtonClick:^{
        NSLog(@"点了确定");
    } cancelButtonClick:^{
        NSLog(@"点了取消");
    }];
    [alert show];
