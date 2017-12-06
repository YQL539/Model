//
//  MainViewController.m
//  WoVPNStore
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor =HOSTCOLOR;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    NSDictionary *titleAttr = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:20]
                                };
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
    
    if (IS_IOS_(7)) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeBottom;
        }
    }
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}
//三方侧滑返回
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
        return YES;
    }
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)showAlertWithInfomation:(NSString *)information completedAction:(void(^_Nullable)(UIAlertAction *action))showAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ERROR_0002 message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:ERROR_0003 style:UIAlertActionStyleDefault handler:showAction];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showAlertWithCustomeTitle:(NSString *)Title Infomation:(NSString *)information FirstBtnName:(NSString *)firstBtnName SecondBtn:(NSString *)SecondbtnName FirstAction:(void(^_Nullable)(UIAlertAction *action))firstAction SecondAction:(void(^_Nullable)(UIAlertAction *action))secondAction completedAction:(void (^ __nullable)(void))completedAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:firstBtnName style:UIAlertActionStyleDefault handler:firstAction];
    UIAlertAction *alert2Action = [UIAlertAction actionWithTitle:SecondbtnName style:UIAlertActionStyleDefault handler:secondAction];
    [alertController addAction:alertAction];
    [alertController addAction:alert2Action];
    [self presentViewController:alertController animated:YES completion:completedAction];
}

#pragma mark ========================= Controller跳转方法 ==============================
//把当前controller删除跳到下一个controller
-(void) ShowControllerWithOutSelf:(UIViewController*) pToController animated:(BOOL) animated
{
    UINavigationController *pNav = self.navigationController;
    NSMutableArray *pNewControllers = [NSMutableArray arrayWithArray:pNav.viewControllers];
    NSInteger index = [self GetControllerIndex:[pToController class]];
    if (index >= 0) {
        [pNewControllers removeLastObject];
        UIViewController *pController = [pNewControllers objectAtIndex:index];
        [pNewControllers removeObjectAtIndex:index];
        [pNewControllers addObject:pController];
        [pNav setViewControllers:pNewControllers animated:animated];
        return;
    }
    [pNewControllers removeLastObject];
    [pNewControllers addObject:pToController];
    [pNav setViewControllers:pNewControllers animated:animated];
    
}
//栈顶至少有两个第一个是pToController 第二个是self
-(void) ShowControllerWithSelf:(UIViewController*) pToController animated:(BOOL)animated
{
    UINavigationController *pNav = self.navigationController;
    NSInteger index = [self GetControllerIndex:[pToController class]];
    if(index >=0){
        NSMutableArray *pNewControllers = [NSMutableArray arrayWithArray:pNav.viewControllers];
        UIViewController *pController = pNewControllers[index];
        [pNewControllers removeObjectAtIndex:index];
        [pNewControllers addObject:pController];
        [pNav setViewControllers:pNewControllers animated:animated];
        return;
    }
    [pNav pushViewController:pToController animated:animated];
}
//全部清空后创建 里面只有这个controller
-(void) ShowControllerWithNone:(UIViewController*) pToController animated:(BOOL)animated
{
    UINavigationController *pNav = self.navigationController;
    NSArray *pArray = [NSArray arrayWithObject:pToController];
    [pNav setViewControllers:pArray animated:animated];
}
//显示页面(保留所有的控制器,把需要显示的控制器压到栈顶)
-(void)ClassDeleteViewController:(Class)pViewController
{
    NSInteger index = [self GetControllerIndex:pViewController];
    NSMutableArray *pNewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    UIViewController *pDeleteController = [pNewControllers objectAtIndex:index];
    [pNewControllers removeObjectAtIndex:index];
    [pNewControllers addObject:pDeleteController];
    [self.navigationController setViewControllers:pNewControllers];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) RemoveAllController:(NSMutableArray *)pNewControllers
{
    for (int i = 0; i< pNewControllers.count; ++i) {
        BaseViewController *pVC = pNewControllers[i];
        [pNewControllers removeObject:pVC];
    }
}
/**
 *  获取控制器索引
 *
 *  @param pController 控制器类
 *
 *  @return 返回在控制器数组中的索引
 */
-(NSInteger) GetControllerIndex:(Class) pController
{
    NSString* pControllerName = NSStringFromClass(pController);
    //    当前导航所有的viewController
    NSArray *pCurrentControllers = self.navigationController.viewControllers;
    for (int i = 0;i < pCurrentControllers.count; ++i) {
        NSString* pItemControllerName = NSStringFromClass([[pCurrentControllers objectAtIndex:i] class]);
        if (NSOrderedSame == [pControllerName compare:pItemControllerName]) {
            return i;
        }
    }
    return -1;
}
//获取当前的Controller
-(UIViewController*) GetController:(Class) pController
{
    NSString* pControllerName = NSStringFromClass(pController);
    NSArray *pCurrentControllers = self.navigationController.viewControllers;
    for (int i = 0;i < pCurrentControllers.count; ++i) {
        NSString* pItemControllerName = NSStringFromClass([[pCurrentControllers objectAtIndex:i] class]);
        if (NSOrderedSame == [pControllerName compare:pItemControllerName]) {
            return [pCurrentControllers objectAtIndex:i];
        }
    }
    return nil;
}

//获取当前Controller的界面图片
-(UIImage *) GetControllerImage:(NSInteger)iControllerIndex
{
    NSArray *pCurrentControllers = self.navigationController.viewControllers;
    UIView* pPView = ((UIViewController*)[pCurrentControllers objectAtIndex:iControllerIndex]).view;
    UIGraphicsBeginImageContextWithOptions(pPView.bounds.size, pPView.opaque, 0.0);
    [pPView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * pImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pImage;
}
//删除当前Controller
-(void) RemoveController:(Class) pController
{
    NSString* pControllerName = NSStringFromClass(pController);
    NSArray *pCurrentControllers = self.navigationController.viewControllers;
    for (int i = 0;i < pCurrentControllers.count; ++i) {
        NSString* pItemControllerName = NSStringFromClass([[pCurrentControllers objectAtIndex:i] class]);
        if (NSOrderedSame == [pControllerName compare:pItemControllerName]) {
            NSMutableArray* pArray = [[NSMutableArray alloc] initWithArray:pCurrentControllers];
            [pArray removeObjectAtIndex:i];
            [self.navigationController setViewControllers:pArray animated:NO];
        }
    }
}

//插入Controller
-(void) InsertController:(UIViewController*) pController index:(NSInteger)iIndex
{
    NSArray *pCurrentControllers = self.navigationController.viewControllers;
    NSMutableArray *pNewControllers = [NSMutableArray arrayWithArray:pCurrentControllers];
    if (pNewControllers.count > iIndex) {
        [pNewControllers insertObject:pController atIndex:iIndex];
    }
    else
    {
        [pNewControllers addObject:pController];
    }
    [self.navigationController setViewControllers:pNewControllers animated:NO];
}

@end
