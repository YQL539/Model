//
//  BaseNetWorkingClient+NetworkLogin.h
//  ModelProduct
//
//  Created by yangqinglong on 2017/12/6.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "BaseNetWorkingClient.h"
#import "LoginModel.h"
@interface BaseNetWorkingClient (NetworkLogin)
-(void)loginClientWithAcount:(NSString *)Acount password:(NSString *)password Success:(void(^)(NSDictionary * model))success failure:(void(^)(NSError *error))failure;

@end
