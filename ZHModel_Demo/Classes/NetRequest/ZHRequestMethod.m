//
//  ZHRequestMethod.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHRequestMethod.h"
@interface ZHRequestMethod()

+ (void)requestType_NO1:(NSDictionary*)param
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSUInteger statusCode, NSString *error))failure;
+ (void)requestType_NO2:(NSDictionary*)param
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSUInteger statusCode, NSString *error))failure;
+ (void)requestType_NO3:(NSDictionary*)param
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
//            [ZHRequestMethod requestType_NO1:parma success:^(id responseObject) {
//                success(responseObject);
//            } failure:^(NSUInteger statusCode, NSString *error) {
//                failure(statusCode,error);
//            }];
            [ZHRequestMethod requestType_NO1:parma success:success failure:failure];
            break;
        case RequestInterfaceNO2:
            [ZHRequestMethod requestType_NO2:parma success:success failure:failure];
            break;
        case RequestInterfaceNO3:
            [ZHRequestMethod requestType_NO3:parma success:success failure:failure];
            break;
        default:
            break;
    }
}

+ (void)requestType_NO1:(NSDictionary*)param
               success:(void (^)(id responseObject))success
                failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    NSString *jsonStr = @"{\"remark\":\"顺便抓个包\",\"responseCode\":\"0000\",\"responseMsg\":\"返回成功\",\"subTaskPayInfo\":{\"orderInfo\":\"orderInfo信息\"},\"taskOrderNo\":\"76cb3b9160ea43ab96e6c1a8302f85e2\",\"userNo\":\"0000000000153503419\"}";
    id responsejsonObject = [self dictionaryWithJSON:jsonStr];
    success(responsejsonObject);
}


+ (void)requestType_NO2:(NSDictionary*)param
               success:(void (^)(id responseObject))success
                failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    NSString *jsonStr = @"{\"remark\":\"顺便抓个包\",\"responseCode\":\"0000\",\"responseMsg\":\"返回成功\",\"subTaskPayInfo\":{\"orderInfo\":\"orderInfo信息\"},\"taskOrderNo\":\"76cb3b9160ea43ab96e6c1a8302f85e2\",\"userNo\":\"0000000000153503419\"}";
    id responsejsonObject = [self dictionaryWithJSON:jsonStr];
    success(responsejsonObject);
}


+ (void)requestType_NO3:(NSDictionary*)param
               success:(void (^)(id responseObject))success
                failure:(void (^)(NSUInteger statusCode, NSString *error))failure{
    NSString *jsonStr = @"{\"remark\":\"顺便抓个包\",\"responseCode\":\"0000\",\"responseMsg\":\"返回成功\",\"subTaskPayInfo\":{\"orderInfo\":\"orderInfo信息\"},\"taskOrderNo\":\"76cb3b9160ea43ab96e6c1a8302f85e2\",\"userNo\":\"0000000000153503419\"}";
    id responsejsonObject = [self dictionaryWithJSON:jsonStr];
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
