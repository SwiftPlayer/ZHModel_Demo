//
//  Type2ResponseModel.h
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ZHResponseBaseModel.h"

/***********对应的Json格式（json嵌套情形）*******
{
 "responseCode":"0000",
 "responseMsg":"返回成功",
 "remark":"交流学习",
 "userName":"简书Haofree",
 "taskNo":"007",
 "subInfo":{
 "type":"info类型",
 "comment":"info内容"
 }
}
*******************************/

@interface Type2ResponseSubInfoModel : ZHResponseBaseModel

@property (nonatomic , copy) NSString *type;                //info类型

@property (nonatomic , copy) NSString *comment;             //info内容

@end



@interface Type2ResponseModel : ZHResponseBaseModel

@property (nonatomic , copy) NSString *responseCode;        //响应结果码

@property (nonatomic , copy) NSString *responseMsg;         //响应消息

@property (nonatomic , copy) NSString *remark;              //备注

@property (nonatomic , copy) NSString *userName;            //名字

@property (nonatomic , assign) NSInteger taskNo;             //索引号

@property (nonatomic , strong) Type2ResponseSubInfoModel *subInfo;             //子信息（json嵌套情形）

@end
