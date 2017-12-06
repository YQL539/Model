//
//  AppDelegate.m
//  ModelProduct
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [TabBarViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [CommonUtil CreatePath:DIR_WECHAT];
    [CommonUtil CreatePath:DIR_INFO];
    NSString *pstrDocPath = DIR_WECHAT;
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%@",pstrDocPath);
    [self setupNavBar];
    if (IS_IOS_(9) == NO) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统版本太低" message:@"请将系统升至IOS9.0以上使用" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"去升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NSString * urlString = @"prefs:root=General&path=SOFTWARE_UPDATE_LINK";
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"退出APP" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            UIWindow *window = self.window;
//            [UIView animateWithDuration:.5f animations:^{
//                window.alpha = 0;
//                window.frame = CGRectMake(0, -SCREENWIDTH, SCREENWIDTH, 0);
//            } completion:^(BOOL finished) {
//                exit(0);
//            }];
//        }];
//        [alertController addAction:alertAction];
//        [alertController addAction:cancelAction];
//        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }else{
        //   // 3D Touch==UIApplicationShortcutIconTypeShuffle=UIApplicationShortcutIconTypeConfirmation
        UIApplicationShortcutIcon *connectItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome];
        UIMutableApplicationShortcutItem *connectItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"connect" localizedTitle:@"第二个界面" localizedSubtitle:nil icon:connectItemIcon userInfo:nil];
        UIApplicationShortcutIcon *productItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
        UIMutableApplicationShortcutItem *productItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"product" localizedTitle:@"第一个界面" localizedSubtitle:nil icon:productItemIcon userInfo:nil];
        application.shortcutItems = @[connectItem,productItem];
    }

    return YES;
}

- (void)setupNavBar
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UINavigationBar *bar = [UINavigationBar appearance];
    CGFloat rgb = 0.1;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    //3D Touch事件
    if ([shortcutItem.type isEqual:@"connect"])
    {
        SecondViewController *productVC = [[SecondViewController alloc]init];
        UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
        [nav pushViewController:productVC animated:YES];
    }else if([shortcutItem.type isEqual:@"product"])
    {
        FirstViewController *productVC = [[FirstViewController alloc]init];
        UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
        [nav pushViewController:productVC animated:YES];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
