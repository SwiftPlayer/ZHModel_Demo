//
//  Type1ResponseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHResponseBaseModel.h"

/***********对应的Json格式*******
{
 "responseCode":"0000",
 "responseMsg":"返回成功",
 "remark":"交流学习",
 "userName":"简书Haofree",
 "taskNo":1
}
******************************/

@interface Type1ResponseModel : ZHResponseBaseModel

@property (nonatomic , strong) NSString *responseCode;        //响应结果码

@property (nonatomic , strong) NSString *responseMsg;         //响应消息

@property (nonatomic , strong) NSString *remark;              //备注

@property (nonatomic , strong) NSString *userName;            //名字

@property (nonatomic , assign) NSInteger taskNo;             //索引号

@end
