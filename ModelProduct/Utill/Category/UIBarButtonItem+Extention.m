//
//  UIBarButtonItem+Extention.m
//  woWiFi
//
//  Created by tony on 15/10/14.
//  Copyright © 2015年 tony. All rights reserved.
//

#import "UIBarButtonItem+Extention.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extention)

/** 导航栏左边和右边的按钮 */
+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
