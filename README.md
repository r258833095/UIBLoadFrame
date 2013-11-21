UIBLoadFrame
============

加载框

使用方法：
    //加在window层上方
    UIBLoadFrame *viewLoad =[[UIBLoadFrame alloc]init];
    [self.window addSubview:viewLoad];
    
需要用到的地方使用通知：
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadFrame" object:@"show"];
    
    // show:为  请稍等
    // err:为  网络不给力提示
    // hide:为 隐藏
    // 其他字体 则 自输入
