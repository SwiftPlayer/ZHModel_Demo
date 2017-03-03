//
//  ZHRequestMethod.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHRequestMethod.h"
@interface ZHRequestMethod()

+ (void)requestType1:(NSDictionary*)param
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSUInteger statusCode, NSString *error))failure;
+ (void)requestType2:(NSDictionary*)param
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSUInteger statusCode, NSString *error))failure;
+ (void)requestType3:(NSDictionary*)param
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSUInteger statusCode, NSString *error))failure;

@end

@implementation ZHRequestMethod

#pragma mark 总出口
+ (void)startRequest:(NSDictionary*)parma
               type:(RequestInterface)interfaceType
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    
    switch (interfaceType) {
        case RequestInterfaceNO1:
//            [ZHRequestMethod requestType1:parma success:^(id responseObject) {
//                success(responseObject);
//            } failure:^(NSUInteger statusCode, NSString *error) {
//                failure(statusCode,error);
//            }];
            [ZHRequestMethod requestType1:parma success:success failure:failure];
            break;
        case RequestInterfaceNO2:
            [ZHRequestMethod requestType2:parma success:success failure:failure];
            break;
        case RequestInterfaceNO3:
            [ZHRequestMethod requestType3:parma success:success failure:failure];
            break;
        default:
            break;
    }
}

+ (void)requestType1:(NSDictionary*)param
               success:(void (^)(id responseObject))success
                failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    NSString *jsonStr = @"{\"responseCode\":\"0000\",\"responseMsg\":\"返回成功\",\"remark\":\"交流学习\",\"userName\":\"简书Haofree\",\"taskNo\":1}";
    id responsejsonObject = [self dictionaryWithJSON:jsonStr];
    success(responsejsonObject);
}


+ (void)requestType2:(NSDictionary*)param
               success:(void (^)(id responseObject))success
                failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    NSString *jsonStr = @"{\"responseCode\":\"0000\",\"responseMsg\":\"返回成功\",\"remark\":\"交流学习\",\"userName\":\"简书Haofree\",\"taskNo\":\"007\",\"subInfo\":{\"type\":\"info类型\",\"comment\":\"info内容\"}}";    id responsejsonObject = [self dictionaryWithJSON:jsonStr];
    success(responsejsonObject);
}


+ (void)requestType3:(NSDictionary*)param
               success:(void (^)(id responseObject))success
                failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    NSString *jsonStr = @"{\"remark\":\"交流学习\",\"responseCode\":\"0000\",\"responseMsg\":\"返回成功\",\"taskNo\":\"007\",\"userName\":\"简书Haofree\",\"subTaskList\":[{\"subTaskNo\":\"001\",\"subTaskInfo\":\"简洁的DataModel和ViewModel\",\"timestamp\":1487750930515,\"status\":5},{\"subTaskNo\":\"002\",\"subTaskInfo\":\"DataModel和ViewModel层分离\",\"timestamp\":1487750930525,\"status\":10}]}";    id responsejsonObject = [self dictionaryWithJSON:jsonStr];
    success(responsejsonObject);
}


//Demo测试辅助方法
+ (NSDictionary *)dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}


@end
