//
//  UITableView+SubviewAdditions.m
//  MobileMaket
//
//  Created by 曹 景成 on 13-9-2.
//  Copyright (c) 2013年 BeeBox. All rights reserved.
//

#import "UITableView+SubviewAdditions.h"

@implementation UITableView (SubviewAdditions)

- (NSIndexPath *)indexPathForRowContainingView:(UIView *)view {
    CGPoint correctedPoint = [view convertPoint:view.bounds.origin toView:self];
    
    return [self indexPathForRowAtPoint:correctedPoint];
}

@end
