//
//  PVLEncryptKit.m
//  LKVideoChat
//
//  Created by SongJu on 16/7/21.
//  Copyright © 2016年 联坤科技. All rights reserved.
//

#import "PVLEncryptKit.h"

#import "FBEncryptorAES.h"

@implementation PVLEncryptKit

/// 加密
+ (NSString *)encode:(NSString *)str withKey:(NSString *)key
{
    if (str.length == 0 || key.length == 0)
        return @"";
    return [FBEncryptorAES encryptBase64String:str
                                     keyString:key
                                 separateLines:NO];
}

/// 解密
+ (NSString *)decode:(NSString *)str withKey:(NSString *)key
{
    if (str.length == 0 || key.length == 0)
        return @"";
    return [FBEncryptorAES decryptBase64String:str
                                     keyString:key];
}

@end
