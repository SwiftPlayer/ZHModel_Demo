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
