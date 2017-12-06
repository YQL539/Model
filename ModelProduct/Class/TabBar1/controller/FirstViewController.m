//
//  FirstViewController.m
//  ModelProduct
//
//  Created by apple on 2017/8/19.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "FirstViewController.h"
#import "testViewController.h"
//#import "BaseNetWorkingClient.h"
#import "BaseNetWorkingClient+NetworkLogin.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSubViews];

}

-(void)setSubViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"测试" style:UIBarButtonItemStyleDone target:self action:@selector(test)];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [loginBtn addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonDidClicked:(UIButton *)sender{
    ////=============XML============
//    NSDictionary *data_dic = @{@"login":@{@"userName":@"Zhouxin111"
//                                          ,@"password":@"111111"
//                                          ,@"userType":@"1"
//                                          ,@"ddToken":@""
//                                          ,@"version":@"1.1.5"
//                                          ,@"isEN":@""
//                                          ,@"deviceToken":@"6347607c5743d2e17ccc63507a008773701c3de096066c6082e300f85f9f7a0b"}};
//    [[BaseNetWorkingClient sharedInstance] createPOSTRequest:@"http://116.204.25.22:80/pcms/servlet/login" WithParam:data_dic success:^(id result) {
//        NSLog(@"success");
//    } failure:^(NSError *error) {
//        NSLog(@"失败");
//    }];
    
    //////============JSON======================
//    NSDictionary *dic = @{@"account":@"admin"
//                               ,@"password":@"admin"
//                               ,@"clientSysType":@"2"
//                               ,@"deviceToken":@""
//                               ,@"clientVersion":@"110426"
//                               ,@"yunChannel":@""
//                               ,@"yunUserId":@""};
//
//    [[BaseNetWorkingClient sharedInstance] createPOSTRequest:@"http://192.168.0.75:80/conferapp/servlet/login" WithParam:dic success:^(id result) {
//        NSLog(@"success");
//
//    } failure:^(NSError *error) {
//        NSLog(@"失败");
//    }];
    
    [[BaseNetWorkingClient sharedInstance] loginClientWithAcount:@"" password:@"" Success:^(NSDictionary *model) {
        NSLog(@"Dic==%@",model);
        [self test];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
    }];
}
-(void)test{
    testViewController *test = [[testViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}
@end
