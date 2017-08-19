//
//  UITableView+SubviewAdditions.h
//  MobileMaket
//
//  Created by 曹 景成 on 13-9-2.
//  Copyright (c) 2013年 BeeBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SubviewAdditions)

- (NSIndexPath *)indexPathForRowContainingView:(UIView *)view;

@end
