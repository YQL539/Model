//
//  LoginModel.h
//  ModelProduct
//
//  Created by yangqinglong on 2017/12/6.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginModel : JSONModel
@property (nonatomic,assign) long accountId;
@property (nonatomic,copy) NSString <Optional> *accountName;
@property (nonatomic,assign) long accountType;
@property (nonatomic,assign) long companyId;
@property (nonatomic,copy) NSString <Optional> *companyName;
@property (nonatomic,copy) NSString <Optional> *companyNumber;
@property (nonatomic,copy) NSString <Optional> *VersionDescription;
@property (nonatomic,copy) NSString <Optional> *VersionLink;
@property (nonatomic,copy) NSString <Optional> *systemTime;
@property (nonatomic,copy) NSString <Optional> *token;
@property (nonatomic,assign) long companyType;
@property (nonatomic,assign) long confertime;
@property (nonatomic,assign) long day;
@property (nonatomic,assign) long firstLogin;
@property (nonatomic,assign) long interval;
@property (nonatomic,assign) long localtime;
@property (nonatomic,assign) long mustUpdate;
@property (nonatomic,assign) long result;
@property (nonatomic,assign) long videotime;
@property (nonatomic,assign) long isconfer;
@end



