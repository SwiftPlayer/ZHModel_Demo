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
               WithFailureBlock: (FailureBlock) failureBlock
{
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
