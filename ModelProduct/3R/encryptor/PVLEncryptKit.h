//
//  PVLEncryptKit.h
//  LKVideoChat
//
//  Created by SongJu on 16/7/21.
//  Copyright © 2016年 联坤科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVLEncryptKit : NSObject

/// 加密
+ (NSString *)encode:(NSString *)str withKey:(NSString *)key;

/// 解密
+ (NSString *)decode:(NSString *)str withKey:(NSString *)key;

@end
