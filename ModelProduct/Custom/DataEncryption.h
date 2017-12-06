//
//  DataEncryption.h
//  LKVideoChat
//
//  Created by 王振宁 on 16/7/18.
//  Copyright © 2016年 联坤科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEncryption : NSObject
//加密
+ (NSString *) encode:(NSString *)strSrc;
//解密
+ (NSString *) decode:(NSString *)strSrc;
@end
