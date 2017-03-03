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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[PublicViewBaseModel alloc] init];
    self.responseModel_1 = [[Type1ResponseModel alloc] init];
    self.responseModel_2 = [[Type2ResponseModel alloc] init];
    self.responseModel_3 = [[Type3ResponseModel alloc] init];
    [self getResponseDataModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (PublicViewBaseModel *)viewModel{
//    if (_viewModel) {
//        _viewModel = [[PublicViewBaseModel alloc] init];
//    }
//    return _viewModel;
//}

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
            NSLog(@"responseModel_3:%@",strongSelf.responseModel_3);
        }else{
            NSLog(@"无法识别的模型类");
        }

    } WithFailureBlock:^(NSUInteger statusCode, NSString *error) {
        NSLog(@"错误码:%lu,错误信息：%@",(unsigned long)statusCode,error);
    }];
}

- (IBAction)requestBtn1:(id)sender{
    [self.viewModel sendType1Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.responseModelTextView.text = [NSString stringWithFormat:@" self.responseModel_1.responseCode:%@\n self.responseModel_1.responseMsg:%@\n self.responseModel_1.remark:%@\n self.responseModel_1.userName:%@\n self.responseModel_1.taskNo:%ld\n",self.responseModel_1.responseCode,self.responseModel_1.responseMsg,self.responseModel_1.remark,self.responseModel_1.userName,(long)self.responseModel_1.taskNo];
    });
    
}

- (IBAction)requestBtn2:(id)sender{
    [self.viewModel sendType2Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (IBAction)requestBtn3:(id)sender{
    [self.viewModel sendType3Request:@{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
}


@end
