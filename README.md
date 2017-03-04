# ZHModel_Demo
>很多人试图解决 MVC 这种架构下 Controller 比较臃肿的问题，这里我分享一种简洁易懂的Model层，致力于打造更为简洁的DataModel和ViewModel层，同时也适用Controller更加简洁。下面一起分享学习。[源码：ZHModel_Demo](https://github.com/SwiftPlayer/ZHModel_Demo)

#一、简介
对于iOS的APP架构，有很多说法和实践，包括[MVC、MVVM、MVCS、VIPER](https://casatwy.com/iosying-yong-jia-gou-tan-viewceng-de-zu-zhi-he-diao-yong-fang-an.html)等等。我相信大部分开发者都热衷于MVC这种模式，我们对于 MVC 这种设计模式真的用得好吗？其实不是的，MVC 这种分层方式虽然清楚，但是如果使用不当，很可能让大量代码都集中在 Controller 之中。
ZHModel_Demo，提供简洁的DataModel和ViewModel示例。将数据请求封装，用ViewModel层连接控制器和数据，同时用属性映射分离出DataModel层，使数据更清晰，更重要的是将 Controller瘦身。
#二、说明
>不论是哪种设计方式，总的架构都是上述那几种，所谓剑法无穷，万剑归宗。但今天我们讨论的是如何将DataModel和ViewModel设计得简洁清晰，可复用。

这里MVVM 的优点拿来借鉴。具体做法就是将 ViewController 给 View 传递数据这个过程，抽象成构造 ViewModel 的过程。这样抽象之后，View 只接受 ViewModel，而 Controller 只需要传递 ViewModel 这么一行代码。而另外构造 ViewModel 的过程，我们就可以移动到另外的类中了。在具体实践中，我们专门创建构造 ViewModel 工厂类，参见工厂模式。另外，我们也将数据模型通过属性映射对应到DataModel，这样使得所有来回的数据模型清晰可见，容易同意修改和复用。同时也可以专门将数据存取都抽将到一个 Service 层，由这层来提供 ViewModel 的获取。
#三、码上说话
>下面我分享下代码，看看DataModel和ViewModel有什么优势或者不足的地方

####1、目录结构

![目录结构.png](http://upload-images.jianshu.io/upload_images/2646525-a34cee8bb04e6562.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我们熟知的程序包含：网络请求、数据、控制器（视图，业务？），有时会把这几个关系弄得绕来绕去，导致代码臃肿，不好复用和维护。但所有情况无非就是：
>1、数据怎么来？  
2、数据怎么桥接？
3、数据怎么呈现？

######1）、数据怎么来？
上述目录解析：
>1、网络请求封装成**NetRequest**模块（还包括**HTTPClient**类，这里略）
2、数据请求总出口封装在**ZHRequestMethod**类中
3、将收到的数据映射到数据模型DataModel(基于**ZHResponseBaseModel  **  )

######1）、数据怎么桥接？
上述目录解析：
>1、数据模型和View的桥接用到了ViewModel（基于**ZHViewBaseModel**）
2、 用继承于**ZHViewBaseModel**的**PublicViewBaseModel**处理具体网络请求，数据模型和控制器视图的关系

######1）、数据怎么呈现？
>我们的目的是什么？就是为了让数据呈现更加简洁，让呈现数据的视图控制器变的优雅。视图呈现利用ViewModel轻松展示。

####2、数据模型DataModel层
数据模型DataModel分为网络请求***返回参数模型***和***发送参数模型***
**返回参数模型基类ZHResponseBaseModel**:
```
//
//  ZHResponseBaseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHResponseBaseModel : NSObject

- (void)decodeJsontoDictionary:(NSDictionary*)dic;

@end
```

```
//
//  ZHResponseBaseModel.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHResponseBaseModel.h"
#import <objc/runtime.h>

@implementation ZHResponseBaseModel

- (void)decodeJsontoDictionary:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    for (NSString *key in dic) {
        if ([self respondsToSelector:@selector(setValue:forKey:)]) {
            if (class_getProperty([self class], [key UTF8String])) {
                if (![dic[key] isKindOfClass:[NSNull class]] ) {
                    [self setValue:dic[key] forKey:key];
                }else{
                }
            }
        }
    }
}

@end
```
将数据请求返回的Json字典通过属性映射到各个模型字段中，例如Demo当中有三个对应的返回模型，当然这种对应的返回数据模型和参数模型可以放大每个子业务当中。这里以其中一个为例子：**Type1ResponseModel**:
```
//
//  Type1ResponseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHResponseBaseModel.h"

/***********对应的Json格式*******
{
 "responseCode":"0000",
 "responseMsg":"返回成功",
 "remark":"交流学习",
 "userName":"简书Haofree",
 "taskNo":1
}
******************************/

@interface Type1ResponseModel : ZHResponseBaseModel

@property (nonatomic , copy) NSString *responseCode;        //响应结果码

@property (nonatomic , copy) NSString *responseMsg;         //响应消息

@property (nonatomic , copy) NSString *remark;              //备注

@property (nonatomic , copy) NSString *userName;            //名字

@property (nonatomic , assign) NSInteger taskNo;            //索引号

@end

```

```
//
//  Type1ResponseModel.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "Type1ResponseModel.h"

@implementation Type1ResponseModel

@end
```
这样当数据请求返回相应的Json字典时可以清晰解析并且通过KVC属性赋值建起返回的数据模型，当然里时最简单的Json，例子中还涉及到了Json中要嵌套的和数组的这种常见的格式。这种把业务字段封装成返回数据模型方便清晰，也可以放到一个大项目的子模块当中去。

**发送参数模型基类ZHParamBaseModel:**
>既然返回的数据模型可以提取出来封装，我们业务请求当中还有很多需要发送的参数，这如果分散放在视图控制器中将会很糟糕。同样我们可以将每个业务请求的参数封装在类中，这样修改起来我们不关系视图控制器，只关心这个发送参数类，使得数据业务和视图控制器得到很好的分离。

```
//
//  ZHParamBaseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHParamBaseModel : NSObject

-(NSDictionary*)covertToDic;

@end

```

```
//
//  ZHParamBaseModel.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHParamBaseModel.h"
#import <objc/runtime.h>
@implementation ZHParamBaseModel

- (NSDictionary *)covertToDic{
    return [self getPropertyList:[self class]];;
}

- (NSDictionary *)getPropertyList: (Class)clazz
{
    u_int count;
    unsigned int outCount;
    Ivar* ivars = class_copyIvarList(clazz, &count);
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < count ; i++){
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        
        id value = [self valueForKey:[NSString stringWithFormat:@"%s",propName]];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
        }else{
            [propertyDic setValue:value forKey:[NSString  stringWithCString:propName encoding:NSUTF8StringEncoding] ];
        }
    }
    free(ivars);
    return propertyDic;
}

@end

```

####2、(视图-数据)桥接模型ViewModel层
(视图-数据)桥接模型ViewModel的基类：**ZHViewBaseModel**
>1、将不同的返回的Json字典转换为数据模型
2、将接收封装数据模型通过block回调

```
//
//  ZHViewBaseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^FailureBlock)(NSUInteger statusCode, NSString *error);

@interface ZHViewBaseModel : NSObject

@property (copy, nonatomic) ReturnValueBlock returnBlock;
@property (copy, nonatomic) FailureBlock failureBlock;

//接收封装数据请求返回的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
               WithFailureBlock: (FailureBlock) failureBlock;

//将返回的Json字典转换为数据模型
-(id)process:(NSString*)className dic:(id)response;

@end

```

```
//
//  ZHViewBaseModel.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHViewBaseModel.h"
#import <objc/runtime.h>


@implementation ZHViewBaseModel

#pragma 接收封装数据请求透穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
               WithFailureBlock: (FailureBlock) failureBlock{
    _returnBlock = [returnBlock copy];
    _failureBlock = [failureBlock copy];
}

-(id)process:(NSString*)className dic:(id)response{
    __strong Class model = [NSClassFromString(className) alloc];
    SEL selector = NSSelectorFromString(@"decodeJsontoDictionary:");
    if ([model respondsToSelector:selector]) {
        [model performSelector:selector withObject:response];
    }
    return model;
}

@end
```
另外就是具体处理网络请求出口的公共ViewModel类：**PublicViewBaseModel**
```
//
//  PublicViewBaseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHViewBaseModel.h"

@interface PublicViewBaseModel : ZHViewBaseModel

//数据请求层，举例三个数据请求
- (void)sendType1Request:(NSDictionary*)dic;

- (void)sendType2Request:(NSDictionary*)dic;

- (void)sendType3Request:(NSDictionary*)dic;

@end

```

```
//
//  PublicViewBaseModel.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "PublicViewBaseModel.h"
#import "ZHRequestMethod.h"

@implementation PublicViewBaseModel

- (void)sendType1Request:(NSDictionary*)dic{
    [self requestNet:dic type:RequestInterfaceNO1];
}

- (void)sendType2Request:(NSDictionary*)dic{
    [self requestNet:dic type:RequestInterfaceNO2];
}

- (void)sendType3Request:(NSDictionary*)dic{
    [self requestNet:dic type:RequestInterfaceNO3];
}

- (void)requestNet:(NSDictionary*)dic type:(RequestInterface)type{
    __weak typeof(self) weakSelf = self;
    [ZHRequestMethod startRequest:dic type:type success:^(id responseObject){
        NSLog(@"%@", responseObject);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf sucessResponse:responseObject type:type];
        }
    }failure:^(NSUInteger statusCode, NSString *error){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.failureBlock(statusCode,error);
        }
    }];
}

- (void)sucessResponse:(id)responseObject type:(RequestInterface)type{
    NSString *className = @"";
    switch (type) {
        case RequestInterfaceNO1:
            className = @"Type1ResponseModel";
            break;
        case RequestInterfaceNO2:
            className = @"Type2ResponseModel";
            break;
        case RequestInterfaceNO3:
            className = @"Type3ResponseModel";
            break;
        default:
            break;
    }
    id result = [self process:className dic:responseObject];
    if (self.returnBlock) {
        self.returnBlock(result);
    }
}

@end

```
####1、视图呈现
例子中一个视图控制器有三个数据请求和对应的数据，返回数据一个地方处理即可，简洁，需要用到数据的，直接从数据模型中取值。
```
//
//  ViewController.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ViewController.h"
#import "PublicViewBaseModel.h"
#import "Type1ResponseModel.h"
#import "Type2ResponseModel.h"
#import "Type3ResponseModel.h"

@interface ViewController ()
@property (nonatomic , strong) PublicViewBaseModel *viewModel;
@property (nonatomic , strong) Type1ResponseModel  *responseModel_1;
@property (nonatomic , strong) Type2ResponseModel  *responseModel_2;
@property (nonatomic , strong) Type3ResponseModel  *responseModel_3;
@property (nonatomic , strong) Type3ResponseSubListModel  *responseSubListModel_3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[PublicViewBaseModel alloc] init];
    self.responseModel_1 = [[Type1ResponseModel alloc] init];
    self.responseModel_2 = [[Type2ResponseModel alloc] init];
    self.responseModel_3 = [[Type3ResponseModel alloc] init];
    self.responseSubListModel_3 = [[Type3ResponseSubListModel alloc] init];
    [self getResponseDataModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//返回的数据
- (void) getResponseDataModel{
    __weak __typeof(self)wekself = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        __strong typeof(wekself)strongSelf = wekself;
        if ([returnValue isKindOfClass:[Type1ResponseModel class]]) {
            strongSelf.responseModel_1 = (Type1ResponseModel*)returnValue;
            NSLog(@"responseModel_1:%@",strongSelf.responseModel_1);
        }else if ([returnValue isKindOfClass:[Type2ResponseModel class]]){
            strongSelf.responseModel_2 = (Type2ResponseModel*)returnValue;
            NSLog(@"responseModel_2:%@",strongSelf.responseModel_2);
            
        }else if ([returnValue isKindOfClass:[Type3ResponseModel class]]){
            strongSelf.responseModel_3 = (Type3ResponseModel*)returnValue;
            strongSelf.responseSubListModel_3 = strongSelf.responseModel_3.subTaskList[0];
            NSLog(@"responseModel_3:%@",strongSelf.responseModel_3);
        }else{
            NSLog(@"无法识别的模型类");
        }

    } WithFailureBlock:^(NSUInteger statusCode, NSString *error) {
        NSLog(@"错误码:%lu,错误信息：%@",(unsigned long)statusCode,error);
    }];
}

//发送的请求
- (IBAction)requestBtn1:(id)sender{
    [self.viewModel sendType1Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
    });
}
```
#结语
文章分享用于交流学习，一直处于学习积累过程中。技术的积累，源于吸取，感谢同事和一起学习的朋友。

