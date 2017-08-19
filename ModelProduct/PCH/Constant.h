//
//  Constant.h
//  WoVPNStore
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 YQL. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
#endif /* Constant_h */
#pragma mark ############################尺寸型号########################################
//屏幕宽高
#define SCREENWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREENHEIGHT ([[UIScreen mainScreen] bounds].size.height)
//VIEW宽高
#define VIEWWIDTH (self.view.frame.size.width)
#define VIEWNHEIGHT (self.view.frame.size.height)
//判断iphone ipad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
//判断型号尺寸
#define SCREEN_MAX_LENGTH (MAX(SCREENWIDTH, SCREENHEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREENWIDTH, SCREENHEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
//适配尺寸
#define GetWidthNum(inch) [CommonUtil getWidthSwitchInch:inch]
#define GetHeightNum(inch) [CommonUtil getHeightSwitchInch:inch]
//系统版本号 传入数字
#define IS_IOS_(NUM) ([[[UIDevice currentDevice] systemVersion] floatValue] >= NUM ? YES : NO)
#pragma mark ############################系统颜色########################################
//获取颜色
#define COLOR(S) [CommonUtil GetColor:S]
//主题色
#define HOSTCOLOR [UIColor colorWithRed:63/255.0 green:185/255.0 blue:175/255.0 alpha:1]
//背景色（米灰色）
#define HOSTBACKGROUNGDCOLOR [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]
//输入字体色
#define HOSTTEXTCOLOR [UIColor lightGrayColor]

#define DIR_WECHAT [CommonUtil GetProjDir]
#define DIR_INFO [NSString stringWithFormat:@"%@%@",  DIR_WECHAT, @"info"]
