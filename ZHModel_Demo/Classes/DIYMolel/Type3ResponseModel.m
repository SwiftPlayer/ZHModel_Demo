//
//  Type3ResponseModel.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "Type3ResponseModel.h"
#import <objc/runtime.h>

@implementation Type3ResponseSubListModel

@end

@implementation Type3ResponseModel

@synthesize subTaskList = _subTaskList;
-(NSMutableArray*)subTaskList{
    if (!_subTaskList) {
        _subTaskList = [NSMutableArray arrayWithCapacity:1];
    }
    return _subTaskList;
}

-(void)setSubTaskList:(NSMutableArray *)subTaskList{
    [subTaskList enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop){
        Type3ResponseSubListModel *subTaskListModel = [[Type3ResponseSubListModel alloc] init];
        [subTaskListModel decodeJsontoDictionary:obj];
        [self.subTaskList addObject:subTaskListModel];
    }];
}
-(void)decodeJsontoDictionary:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    for (NSString *key in dic) {
        if ([self respondsToSelector:@selector(setValue:forKey:)]) {
            if (class_getProperty([self class], [key UTF8String])) {
                if (![dic[key] isKindOfClass:[NSNull class]] ) {
                    if ([dic[key] isKindOfClass:[NSArray class]] && [key isEqualToString:@"subTaskList"]) {
                        self.subTaskList = dic[key];
                    }else{
                        [self setValue:dic[key] forKey:key];
                    }
                    
                }else{
                    
                }
            }
        }
    }
}

@end
