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
