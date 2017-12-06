//
//  NSString+PVLEncrypt.h
//  LKVideoChat
//
//  Created by SongJu on 16/7/22.
//  Copyright © 2016年 联坤科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PVLEncrypt)

- (NSString *)encryptWithKey:(NSString *)key;

- (NSString *)decryptWithKey:(NSString *)key;

@end
