//
//  NSString+URL.m
//  MyWiFi
//
//  Created by leo on 1/7/16.
//  Copyright © 2016年 woyun. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)WOURLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}


@end
