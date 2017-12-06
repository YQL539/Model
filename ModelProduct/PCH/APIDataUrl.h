//
//  APIDataUrl.h
//  WoVPNStore
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 YQL. All rights reserved.
//

#ifndef APIDataUrl_h
#define APIDataUrl_h


#endif /* APIDataUrl_h */
#pragma mark ****************************VPN服务器IP&&PSK************************************
//是否需要AES加密
#define  IF_NEED_EncryptionAES           1

//系统加密
#define VPNSEVERIP @"119.28.44.232"
#define VPNPSK @"888888"
#pragma mark ****************************系统加密************************************
//系统加密
#define DESKEY @"123456789012345678901234"
/**vnoCode*/
#define VNOCODE @"APP"
#pragma mark ############################三方ID########################################
#pragma mark ****************************友盟************************************
//友盟Key
#define UmengAnalyticsKey @"597ab99ee88bad5bc300054e"
//友盟密码
#define AppMasterSecret   @"aenomdp4fwuzzkk5fxu01kkpne792fr6"
#pragma mark ****************************AdBanna************************************
//AdBanna
#define AdBannaAPPKey @"20170323000477"
#define AdBannaSplashID @"101138"
#pragma mark ****************************微信************************************
#pragma mark - 微信支付配置参数
// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define WX_APPID @"wxd21d89033***b4ca"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define WX_APPSecret @"fc32dfae99bc67e****5f77dddd4ea5"
// 微信支付商户号
#define MCH_ID @"1353***702"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"B6246A6D8***C730EEA0F78D3B461"

#pragma mark ############################本地地址()########################################
//文档说明：http://112.84.178.88:9292/doc/wojia.html#3-2-
//开发环境
#define WOVPNMoblie_BASE_URL @"http://112.84.178.88:9292/"
#define WOVPN_BASE_URL       @"http://112.84.178.88:9292/api/"
//测试环境
//正式环境
#pragma mark ****************************接口************************************
//订购商品（微信）
#define WoJiaWeChatOrderInterface [NSString stringWithFormat:@"%@interface.createWoJiaOrder",WOVPN_BASE_URL]
//注册开户
#define WoJiaRegistInterface [NSString stringWithFormat:@"%@interface.reg",WOVPN_BASE_URL]
//发送验证码接口
#define WoJiaSendMsgInterface [NSString stringWithFormat:@"%@interface.sendMsg",WOVPN_BASE_URL]
//登录接口
#define WoJiaAPPLoginInterface [NSString stringWithFormat:@"%@interface.appLogin",WOVPN_BASE_URL]
//登出接口interface.updateCustPwd
#define WoJiaAPPLogoutInterface [NSString stringWithFormat:@"%@interface.appLogout",WOVPN_BASE_URL]
//修改密码接口interface.forgetPwd
#define WoJiaUpDateCustPwdInterface [NSString stringWithFormat:@"%@interface.updateCustPwd",WOVPN_BASE_URL]
//忘记密码接口
#define WoJiaForgetPwdInterface [NSString stringWithFormat:@"%@interface.forgetPwd",WOVPN_BASE_URL]
//换绑设备
#define WoJiaModifyUuidInterface [NSString stringWithFormat:@"%@interface.modifyUuid",WOVPN_BASE_URL]
//商品列表查询
#define WoJiaInquiryProductListInterface [NSString stringWithFormat:@"%@interface.queryWoHomeOffers",WOVPN_BASE_URL]
//已订购商品列表
#define WoJiaMyProductListInterface [NSString stringWithFormat:@"%@interface.queryOrderWoJia",WOVPN_BASE_URL]
//预认证接口
#define WoJiaIdentifitionInterface [NSString stringWithFormat:@"%@interface.queryOrderWoJia",WOVPN_BASE_URL]



