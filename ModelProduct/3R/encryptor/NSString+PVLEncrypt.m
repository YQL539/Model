//
//  NSString+PVLEncrypt.m
//  LKVideoChat
//
//  Created by SongJu on 16/7/22.
//  Copyright © 2016年 联坤科技. All rights reserved.
//

#import "NSString+PVLEncrypt.h"
#import "PVLEncryptKit.h"

@implementation NSString (PVLEncrypt)

- (NSString *)encryptWithKey:(NSString *)key
{
    NSParameterAssert(!key);
    return [PVLEncryptKit encode:self withKey:key];
}

- (NSString *)decryptWithKey:(NSString *)key
{
    NSParameterAssert(!key);
    return [PVLEncryptKit decode:self withKey:key];
}

@end
