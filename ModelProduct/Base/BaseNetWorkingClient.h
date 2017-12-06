//
//  BaseNetWorking.h
//  WoVPNStore
//
//  Created by apple on 2017/8/9.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import <Foundation/Foundation.h>

//数据类型，json/xml POST方法可用，其他的未改
#define DATATYPE @"xml"


@interface BaseNetWorkingClient : NSObject
+ (id)sharedInstance;

/**
 *  HTTP GET请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
- (void)createGETRequest:(NSString *)urlPath
            WithParam:(NSDictionary *)param
              success:(void(^)(id result))success
              failure:(void(^)(NSError *error))failure;


/**
 *  HTTP POST请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
- (void)createPOSTRequest:(NSString *)urlPath
               WithParam:(NSDictionary *)param
                 success:(void(^)(id result))success
                 failure:(void(^)(NSError *error))failure;

/**
 *  HTTP PUT请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
- (void)createPUTRequest:(NSString *)urlPath
                WithParam:(NSDictionary *)param
                  success:(void(^)(id result))success
                  failure:(void(^)(NSError *error))failure;

/**
 *  HTTP Delete请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
- (void)createDELETERequest:(NSString *)urlPath
                WithParam:(NSDictionary *)param
                  success:(void(^)(id result))success
                  failure:(void(^)(NSError *error))failure;

/**
 *  上传文件功能，如图片等
 *  @param urlPath             服务器提供的接口，用一个枚举来管理
 *  @param param              传的参数
 *  @param data               文件流，将要上传的文件转成NSData中，然后一起传给服务器
 *  @param fileName           文件名
 *  @param success            请求完成
 *  @param uploadFileProgress 请求图片的进度条，百分比
 *  @param failure            请求失败
 */
- (void)createUpLoadRequest:(NSString *)urlPath
            WithParam:(NSDictionary*)param
            withData:(NSData*)data
        withFileName:(NSString *)fileName
              success:(void (^)(id result))success
   uploadFileProgress:(void(^)(double uploadProgress))uploadFileProgress
              failure:(void (^)(NSError* erro))failure;

/**
 *  下载文件功能
 *
 *  @param URLString                 要下载文件的URL
 *  @param downloadFileProgress      下载的进度条
 *  @param setupFilePath             设置下载的路径
 *  @param downloadCompletionHandler 下载完成后（下载完成后可拿到存储的路径）
 */
- (void)createDownloadFileWithURLString:(NSString *)URLString
                   downloadFileProgress:(void(^)(double downloadProgress))downloadFileProgress
                          setupFilePath:(NSURL*(^)(NSURLResponse *response))setupFilePath
              downloadCompletionHandler:(void (^)(NSURL *filePath, NSError *error))downloadCompletionHandler;

@end
