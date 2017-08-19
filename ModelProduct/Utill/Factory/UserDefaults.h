//
//  UserDefaults.h
//  yidianhui
//
//  Created by leo on 16/9/15.
//  Copyright (c) 2015年 juyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject


+ (NSString *)user;
+ (void)setUser:(NSString *)user;

+ (NSString *)password;
+ (void)setPassword:(NSString *)password;


+ (NSData *)headImage;
+ (void)setHeadImage:(NSData *)headImage;

+(void)setIDFA:(NSString *)IDFA;
+(NSString *)IDFA;
@end
