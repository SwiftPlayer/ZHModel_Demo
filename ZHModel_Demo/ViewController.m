//
//  ViewController.m
//  ZHModel_Demo
//
//  Created by haofree on 2017/3/3.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "ViewController.h"
#import "PublicViewBaseModel.h"
#import "Type1ResponseModel.h"
#import "Type2ResponseModel.h"
#import "Type3ResponseModel.h"

@interface ViewController ()
@property (nonatomic , strong) PublicViewBaseModel *viewModel;
@property (nonatomic , strong) Type1ResponseModel  *responseModel_1;
@property (nonatomic , strong) Type2ResponseModel  *responseModel_2;
@property (nonatomic , strong) Type3ResponseModel  *responseModel_3;
@property (nonatomic , strong) Type3ResponseSubListModel  *responseSubListModel_3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[PublicViewBaseModel alloc] init];
    self.responseModel_1 = [[Type1ResponseModel alloc] init];
    self.responseModel_2 = [[Type2ResponseModel alloc] init];
    self.responseModel_3 = [[Type3ResponseModel alloc] init];
    self.responseSubListModel_3 = [[Type3ResponseSubListModel alloc] init];
    [self getResponseDataModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//返回的数据
- (void) getResponseDataModel{
    __weak __typeof(self)wekself = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        __strong typeof(wekself)strongSelf = wekself;
        if ([returnValue isKindOfClass:[Type1ResponseModel class]]) {
            strongSelf.responseModel_1 = (Type1ResponseModel*)returnValue;
            NSLog(@"responseModel_1:%@",strongSelf.responseModel_1);

        }else if ([returnValue isKindOfClass:[Type2ResponseModel class]]){
            strongSelf.responseModel_2 = (Type2ResponseModel*)returnValue;
            NSLog(@"responseModel_2:%@",strongSelf.responseModel_2);
            
        }else if ([returnValue isKindOfClass:[Type3ResponseModel class]]){
            strongSelf.responseModel_3 = (Type3ResponseModel*)returnValue;
            strongSelf.responseSubListModel_3 = strongSelf.responseModel_3.subTaskList[0];
            NSLog(@"responseModel_3:%@",strongSelf.responseModel_3);
        }else{
            NSLog(@"无法识别的模型类");
        }

    } WithFailureBlock:^(NSUInteger statusCode, NSString *error) {
        NSLog(@"错误码:%lu,错误信息：%@",(unsigned long)statusCode,error);
    }];
}

//发送的请求
- (IBAction)requestBtn1:(id)sender{
    [self.viewModel sendType1Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.responseModelTextView.text = [NSString stringWithFormat:@" self.responseModel_1.responseCode:%@\n self.responseModel_1.responseMsg:%@\n self.responseModel_1.remark:%@\n self.responseModel_1.userName:%@\n self.responseModel_1.taskNo:%ld\n",self.responseModel_1.responseCode,self.responseModel_1.responseMsg,self.responseModel_1.remark,self.responseModel_1.userName,(long)self.responseModel_1.taskNo];
    });
    
}

- (IBAction)requestBtn2:(id)sender{
    [self.viewModel sendType2Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.responseModelTextView.text = [NSString stringWithFormat:@" self.responseModel_2.responseCode:%@\n self.responseModel_2.responseMsg:%@\n self.responseModel_2.remark:%@\n self.responseModel_2.userName:%@\n self.responseModel_2.taskNo:%ld\n self.responseModel_2.subInfo.type:%@\n self.responseModel_2.subInfo.comment:%@",self.responseModel_2.responseCode,self.responseModel_2.responseMsg,self.responseModel_2.remark,self.responseModel_2.userName,(long)self.responseModel_2.taskNo,self.responseModel_2.subInfo.type,self.responseModel_2.subInfo.comment];
    });
}

- (IBAction)requestBtn3:(id)sender{
    [self.viewModel sendType3Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.responseModelTextView.text = [NSString stringWithFormat:@" self.responseModel_3.responseCode:%@\n self.responseModel_3.responseMsg:%@\n self.responseModel_3.remark:%@\n self.responseModel_3.userName:%@\n self.responseModel_3.taskNo:%ld\n------------------------\n 子列表第一组数据：\n self.responseSubListModel_3.subTaskNo:%@\n self.responseSubListModel_3.subTaskInfo:%@ self.responseSubListModel_3.timestamp:%ld self.responseSubListModel_3.status:%ld",self.responseModel_3.responseCode,self.responseModel_3.responseMsg,self.responseModel_3.remark,self.responseModel_3.userName,(long)self.responseModel_3.taskNo,self.responseSubListModel_3.subTaskNo,self.responseSubListModel_3.subTaskInfo,(long)self.responseSubListModel_3.timestamp,(long)self.responseSubListModel_3.status];
    });
}


@end
