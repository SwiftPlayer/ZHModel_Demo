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
