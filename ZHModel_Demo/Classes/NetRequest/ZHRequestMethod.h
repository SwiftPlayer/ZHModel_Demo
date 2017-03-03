//
//  ZHRequestMethod.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configure.h"

@interface ZHRequestMethod : NSObject


//网络请求总出口
+(void)startRequest:(NSDictionary*)parma
               type:(RequestInterface)interfaceType
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSUInteger statusCode, NSString *error))failure;

@end
