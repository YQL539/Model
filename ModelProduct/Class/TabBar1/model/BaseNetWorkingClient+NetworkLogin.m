//
//  BaseNetWorkingClient+NetworkLogin.m
//  ModelProduct
//
//  Created by yangqinglong on 2017/12/6.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "BaseNetWorkingClient+NetworkLogin.h"

@implementation BaseNetWorkingClient (NetworkLogin)
-(void)loginClientWithAcount:(NSString *)Acount password:(NSString *)password Success:(void(^)(NSDictionary * model))success failure:(void(^)(NSError *error))failure
{
//    NSDictionary *dic = @{@"account":@"admin"
//                          ,@"password":@"admin"
//                          ,@"clientSysType":@"2"
//                          ,@"deviceToken":@""
//                          ,@"clientVersion":@"110426"
//                          ,@"yunChannel":@""
//                          ,@"yunUserId":@""};
//    
//    [self createPOSTRequest:@"http://192.168.0.75:80/conferapp/servlet/login" WithParam:dic success:^(id result) {
//        NSLog(@"success");
//    } failure:^(NSError *error) {
//        NSLog(@"失败");
//    }];
    
    ////=============XML============
        NSDictionary *data_dic = @{@"login":@{@"userName":@"Zhouxin111"
                                              ,@"password":@"111111"
                                              ,@"userType":@"1"
                                              ,@"ddToken":@""
                                              ,@"version":@"1.1.5"
                                              ,@"isEN":@""
                                              ,@"deviceToken":@"6347607c5743d2e17ccc63507a008773701c3de096066c6082e300f85f9f7a0b"}};
        [[BaseNetWorkingClient sharedInstance] createPOSTRequest:@"http://116.204.25.22:80/pcms/servlet/login" WithParam:data_dic success:^(id result) {
            NSLog(@"success");
            //转成相应model
//            LoginModel * model=[[LoginModel alloc]initWithDictionary:result error:nil];
            success(result);
            NSLog(@"success");
        } failure:^(NSError *error) {
            NSLog(@"失败");
        }];
}




@end
