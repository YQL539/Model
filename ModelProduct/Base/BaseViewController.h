//
//  MainViewController.h
//  WoVPNStore
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface BaseViewController : UIViewController
/**提示错误信息的提示框*/
-(void)showAlertWithInfomation:(NSString *)information completedAction:(void(^_Nullable)(UIAlertAction *action))showAction;
/**自定义按钮提示框*/
-(void)showAlertWithCustomeTitle:(NSString *)Title Infomation:(NSString *)information FirstBtnName:(NSString *)firstBtnName SecondBtn:(NSString *)SecondbtnName FirstAction:(void(^_Nullable)(UIAlertAction *action))firstAction SecondAction:(void(^_Nullable)(UIAlertAction *action))secondAction completedAction:(void (^ __nullable)(void))completedAction;
//==================controller 操作===========
/**全部清空后创建 里面只有这个controller,跳转至ToController，其他删除*/
-(void) ShowControllerWithNone:(UIViewController*) pToController animated:(BOOL)animated;
/**把当前controller删除跳到下一个controller*/
-(void) ShowControllerWithOutSelf:(UIViewController*) pToController animated:(BOOL) animated;
/**栈顶至少有两个第一个是pToController 第二个是self*/
-(void) ShowControllerWithSelf:(UIViewController*) pToController animated:(BOOL)animated;
/**显示页面(保留所有的控制器,把需要显示的控制器压到栈顶)*/
-(void)ClassDeleteViewController:(Class)pViewController;
/**获取当前的Controller*/
-(UIViewController*) GetController:(Class) pController;
/**获取当前的Controller图片*/
-(UIImage *) GetControllerImage:(NSInteger)iControllerIndex;
/**删除当前Controller*/
-(void) RemoveController:(Class) pController;
/**插入Controller*/
-(void) InsertController:(UIViewController*) pController index:(NSInteger)iIndex;

@end
NS_ASSUME_NONNULL_END
