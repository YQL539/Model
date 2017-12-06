//
//  DataEncryption.m
//  LKVideoChat
//
//  Created by 王振宁 on 16/7/18.
//  Copyright © 2016年 联坤科技. All rights reserved.
//

#import "DataEncryption.h"
#import "FBEncryptorAES.h"

@implementation DataEncryption

NSString *const kPVLEncryptKey	=	@"linkcare13015271";

+ (NSString *)encode:(NSString *)strSrc
{
    return [FBEncryptorAES encryptBase64String:strSrc keyString:kPVLEncryptKey separateLines:NO];
}

+ (NSString *) decode:(NSString *)strSrc
{
    return [FBEncryptorAES decryptBase64String:strSrc keyString:kPVLEncryptKey];
}
@end
