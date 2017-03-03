//
//  Configure.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//


typedef NS_ENUM(NSInteger,RequestInterface)
{
    RequestInterfaceNO1,//请求1
    RequestInterfaceNO2,//请求2
    RequestInterfaceNO3,//请求3
};


//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif
