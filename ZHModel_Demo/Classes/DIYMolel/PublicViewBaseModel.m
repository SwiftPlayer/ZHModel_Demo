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
