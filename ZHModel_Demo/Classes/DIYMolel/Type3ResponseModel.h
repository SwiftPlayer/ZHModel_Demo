//
//  Type3ResponseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHResponseBaseModel.h"

/***********对应的Json格式(包含子数组)*******
{
 "remark":"交流学习",
 "responseCode":"0000",
 "responseMsg":"返回成功",
 "taskNo":"007",
 "userName":"简书Haofree",
 "subTaskList":[
 {
 "subTaskNo":"001",
 "subTaskInfo":"简洁的DataModel和ViewModel",
 "timestamp":1487750930515,
 "status":5
 },
 {
 "subTaskNo":"002",
 "subTaskInfo":"DataModel和ViewModel层分离",
 "timestamp":1487750930525,
 "status":10
 }]
}
*******************************/

@interface Type3ResponseSubListModel : ZHResponseBaseModel

@property (nonatomic , copy) NSString *subTaskNo;

@property (nonatomic , copy) NSString *subTaskInfo;

@property (nonatomic , assign) NSInteger timestamp;

@property (nonatomic , assign) NSInteger status;

@end


@interface Type3ResponseModel : ZHResponseBaseModel

@property (nonatomic , copy) NSString *responseCode;           //响应结果码

@property (nonatomic , copy) NSString *responseMsg;            //响应消息

@property (nonatomic , copy) NSString *remark;                 //备注

@property (nonatomic , copy) NSString *userName;               //名字

@property (nonatomic , assign) NSInteger taskNo;              //索引号

@property (nonatomic , strong) NSMutableArray* subTaskList;    //Array子任务列表

@end
