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
