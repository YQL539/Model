//
//  UserDefaults.m
//  yidianhui
//
//  Created by leo on 16/9/15.
//  Copyright (c) 2015年 juyun. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (NSString *)user {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kUser"];
}

+ (void)setUser:(NSString *)user {
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"kUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)password{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kPassword"];
}
+ (void)setPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"kTelephoneNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSData *)headImage{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kHeadImage"];
}
+ (void)setHeadImage:(NSData *)headImage{
    [[NSUserDefaults standardUserDefaults] setObject:headImage forKey:@"kHeadImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)setIDFA:(NSString *)IDFA{
    [[NSUserDefaults standardUserDefaults] setObject:IDFA forKey:@"IDFA"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)IDFA{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"IDFA"];
}
@end
