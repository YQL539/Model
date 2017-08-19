//
//  UIBarButtonItem+Extention.h
//  woWiFi
//
//  Created by tony on 15/10/14.
//  Copyright © 2015年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)

/**
 *  导航栏左边和右边的按钮
 *
 *  @param image         图片
 *  @param highImage     高亮图片
 *  @param target        target对象
 *  @param action        方法
 *  @param controlEvents 事件
 *
 *  @return 导航栏左边和右边的按钮
 */
+ (instancetype)barButtonItemWithImage:(UIImage *)image
                             highImage:(UIImage *)highImage
                             addTarget:(id)target
                                action:(SEL)action
                      forControlEvents:(UIControlEvents)controlEvents;

@end
