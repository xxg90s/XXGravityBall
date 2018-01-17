# XXGravityBall
通过`UIDynamic`与`CoreMotion`实现mobike我的贴纸动画效果

![Image](https://github.com/xxg90s/XXGravityBall/blob/master/MainViewDisplay.png)

如何使用：
初始化View并自行设置背景和手势支持
```
    //初始化View
    self.displayView = [[GBDisplayView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.6, self.view.bounds.size.width, self.view.bounds.size.height*0.4)];
    //设置背景，自行选择
    [self.displayView setBgImage:[UIImage imageNamed:@"skyBg.jpg"]];
    //设置手势，自行选择
    self.displayView.enableClick = YES;
    [self.view addSubview:self.displayView];
    
    __weak typeof(self) weakSelf = self;
    self.displayView.didClickBallBlock = ^(GBModel *item) {
        [weakSelf didClickBall:item];
    };

```
如果需要更多的信息，可以在`GBModel`对象中添加，通过Model控制View。

小球尺寸默认为40，如果想要更改，在这里`#define GBBALLWIDTH 40.`

文章博客地址：http://www.jianshu.com/p/cbe29b157e1d  欢迎提问与关注！
