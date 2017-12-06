//
//  BaseNetWorking.m
//  WoVPNStore
//
//  Created by apple on 2017/8/9.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "BaseNetWorkingClient.h"
#import "AFHTTPSessionManager.h"
#import "XMLDictionary.h"
#import "DataEncryption.h"
//超时
#define HTTP_TIMEOUT 20.0f


@implementation BaseNetWorkingClient
{
    AFHTTPSessionManager *_HTTPManager;
}

- (id)init
{
    if (self = [super init])
    {
        _HTTPManager = [AFHTTPSessionManager manager];
        _HTTPManager.requestSerializer  = [AFJSONRequestSerializer serializer];
        [_HTTPManager.requestSerializer setTimeoutInterval:HTTP_TIMEOUT];
        //把版本号信息传导请求头中
        [_HTTPManager.requestSerializer setValue:[NSString stringWithFormat:@"iOS-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"MM-Version"];
        if ([DATATYPE isEqualToString:@"json"]) {
            [_HTTPManager.requestSerializer setValue:@"application/octet-stream"forHTTPHeaderField:@"Accept" ];
        }else{
            
            [_HTTPManager.requestSerializer setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        }
        _HTTPManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _HTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml", @"text/json",@"text/html",@"text/xml", @"text/plain",@"text/javascript",nil];
    }
    return self;
}

+ (id)sharedInstance
{
    static BaseNetWorkingClient * BaseClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BaseClient = [[BaseNetWorkingClient alloc] init];
    });
    return BaseClient;
}

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
                 failure:(void(^)(NSError *error))failure{
    if ([DATATYPE isEqualToString:@"json"]) {
        [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"GET" success:success failure:failure];
    }else{
        
    }
}
/**
 *  HTTP POST请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
-(void)createPOSTRequest:(NSString *)urlPath
               WithParam:(NSDictionary *)param
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure{
    if ([DATATYPE isEqualToString:@"json"]) {
        [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"POST" success:success failure:failure];
    }else{
//            NSData *data = [self reloadDataWithDic:param];
//            [self doPost:data urlStr:urlPath files:nil block:success errBlock:failure];
        [[BaseNetWorkingClient sharedInstance] createXmlRequest:urlPath WithParam:param WithMethod:@"POST" success:success failure:failure];
    }
    
}

/**
 *  HTTP PUT请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
-(void)createPUTRequest:(NSString *)urlPath
              WithParam:(NSDictionary *)param
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure{
    if ([DATATYPE isEqualToString:@"json"]) {
        [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"PUT" success:success failure:failure];
    }else{
        
    }
}
/**
 *  HTTP Delete请求
 *
 *  @param urlPath  接口地址
 *  @param param    参数
 *  @param success  请求完成
 *  @param failure  请求失败
 */
-(void)createDELETERequest:(NSString *)urlPath
                 WithParam:(NSDictionary *)param
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure{
    if ([DATATYPE isEqualToString:@"json"]) {
        [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"DELETE" success:success failure:failure];
    }else{
        
    }
    
}


- (void)createRequest:(NSString *)urlPath
               WithParam:(NSDictionary *)param
              WithMethod:(NSString *)method
                 success:(void(^)(id result))success
                 failure:(void(^)(NSError *error))failure

{
    [self showHudPregress];
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:urlPath relativeToURL:_HTTPManager.baseURL] absoluteString] parameters:param error:nil];
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self hideHudPregress];
        if (error) {
            if (failure != nil)
            {
                failure(error);
            }
        } else {
            if (success != nil)
            {
                NSString *result = [[NSString alloc] initWithData:responseObject
                                                              encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
                NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&err];
                NSLog(@"result===%@,Dic=%@",result,resultDic);
                success(result);
            }
        }
    }];
    [dataTask resume];
}

- (void)createXmlRequest:(NSString *)urlPath
            WithParam:(NSDictionary *)param
           WithMethod:(NSString *)method
              success:(void(^)(id result))success
              failure:(void(^)(NSError *error))failure

{
    [self showHudPregress];
    NSString *xmlStr = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?>%@",param.XMLString];
    [xmlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"request xmlStr:\n %@",xmlStr);
    if (IF_NEED_EncryptionAES) {
        xmlStr = [self aesEncode:xmlStr];
    }
    NSData *data = [xmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:urlPath relativeToURL:_HTTPManager.baseURL] absoluteString] parameters:param error:nil];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:data];
    [request setHTTPBody:postBody];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self hideHudPregress];
        if (error) {
            if (failure != nil)
            {
                failure(error);
            }
            
        } else {
            
            if (success != nil)
            {
                NSDictionary *xmlDic = [self getDicWithData:responseObject];
                NSLog(@"responseData SUCCESS with dic %@",xmlDic);
//                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                success(xmlDic);
            }
        }
    }];
    
    [dataTask resume];
}

//-(void)doPost:(NSData *)parameters
//       urlStr:(NSString *)urlStr
//        files:(NSArray*)files
//        block:(void (^)(id))success
//     errBlock:(void(^)(NSError *error))failure
//{
//    NSLog(@"server address %@",urlStr);
//
//    NSMutableData *postBody = [NSMutableData data];
//    [postBody appendData:parameters];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:urlStr]];
//    request.timeoutInterval = 30.0f;
//    [request setHTTPMethod:@"POST"];
//    [request addValue:@"text/xml" forHTTPHeaderField: @"Content-Type"];
//    [request setHTTPBody:postBody];
//
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[[NSOperationQueue alloc] init]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
//     {
//         if (connectionError)
//         {
//             NSLog(@"error");
//         }
//         else
//         {
//             NSDictionary *xmlDic = [self getDicWithData:data];
//             NSLog(@"responseData SUCCESS for < %@ > with dic %@",urlStr,xmlDic);
//             if (xmlDic)
//             {
//                 NSLog(@"responseData for < %@ > with dic %@",urlStr,xmlDic);
//             }
//             else
//             {
//                 NSString *result = xmlDic[@"result"][@"__text"];
//                 NSLog(@"result success===%@",result);
//             }
//         }
//     }];
//}


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
                    failure:(void (^)(NSError* erro))failure
{
    if ([DATATYPE isEqualToString:@"json"]) {
        NSMutableDictionary *Exparams = [[NSMutableDictionary alloc]init];
        [Exparams addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:data,fileName, nil]];
        [[BaseNetWorkingClient sharedInstance] createUpLoadRequest:urlPath WithParam:param withExParam:Exparams success:success uploadFileProgress:uploadFileProgress failure:failure];
    }
}

-(void)createUpLoadRequest:(NSString *)urlPath WithParam:(NSDictionary *)param withExParam:(NSDictionary*)Exparam success:(void (^)(id))success uploadFileProgress:(void (^)(double))uploadFileProgress failure:(void (^)(NSError *))failure
{
       NSMutableURLRequest *request = [_HTTPManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlPath parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //图片上传
        if (Exparam) {
            for (NSString *key in [Exparam allKeys]) {
                [formData appendPartWithFileData:[Exparam objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/jpeg"];
            }
        }
        
    } error:nil];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        double pregress = uploadProgress.fractionCompleted;
        
        if (uploadProgress) { //上传进度
            
            uploadFileProgress (pregress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure != nil)
            {
                failure(error);
            }
            
        } else {
            
            if (success != nil)
            {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                success(result);
            }
        }
    }];
    [dataTask resume];
}

/**
 *  下载文件功能
 *
 *  @param URLString                 要下载文件的URL
 *  @param downloadFileProgress      下载的进度条
 *  @param setupFilePath             设置下载的路径
 *  @param downloadCompletionHandler 下载完成后（下载完成后可拿到存储的路径）
 */
-(void)createDownloadFileWithURLString:(NSString *)URLString downloadFileProgress:(void (^)(double))downloadFileProgress setupFilePath:(NSURL *(^)(NSURLResponse *))setupFilePath downloadCompletionHandler:(void (^)(NSURL *, NSError *))downloadCompletionHandler{
    if (URLString && [DATATYPE isEqualToString:@"json"]) {
        [[BaseNetWorkingClient sharedInstance] createdDownloadFileWithURLString:URLString downloadFileProgress:downloadFileProgress setupFilePath:setupFilePath downloadCompletionHandler:downloadCompletionHandler];
    }
}

- (void)createdDownloadFileWithURLString:(NSString *)URLString
                            downloadFileProgress:(void(^)(double downloadProgress))downloadFileProgress
                                   setupFilePath:(NSURL*(^)(NSURLResponse *response))setupFilePath
                       downloadCompletionHandler:(void (^)(NSURL *filePath, NSError *error))downloadCompletionHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:1 timeoutInterval:15];
    
    NSURLSessionDownloadTask *dataTask = [_HTTPManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        double pregress = downloadProgress.fractionCompleted;
        /**
         *  下载进度
         */
        downloadFileProgress(pregress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        /**
         *  设置保存目录
         *NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
         
         *return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
         */
        
        return setupFilePath(response);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        /**
         *  下载完成
         */
        downloadCompletionHandler(filePath,error);
        
    }];
    
    [dataTask resume];
}

-(void)showHudPregress{
    MBProgressHUD *progress = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:progress];
    [progress setMode:MBProgressHUDModeIndeterminate];   //MBProgressHUDModeIndeterminate //圆盘的扇形进度显示
    [progress show:YES];   //显示
    progress.yOffset = - 49.0f;
    
}

-(void)hideHudPregress{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

//===================xml解析，加密=============

//重新编辑数据
- (NSData *)reloadDataWithDic:(NSDictionary *)dic
{
    NSString *dataDic = [self getEFr:dic];
    
    //    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSData *data = [dataDic dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

//XML-JSON
- (NSDictionary *)getDicWithData:(NSData *)data
{
    // 让字符支持gbk编码GB18030-2000
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:enc];
    NSLog(@">Response:\n%@",dataString);
    
    [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeDictionary;
    
    if (IF_NEED_EncryptionAES) {
        dataString = [self aesDecode:dataString];
    }
    NSDictionary *responseDic = [[XMLDictionaryParser sharedInstance] dictionaryWithString:dataString];
    return responseDic;
}

//转换成xml形式，并加密
- (NSString *)getEFr:(NSDictionary *)str{
    NSString *xmlStr = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?>%@",str.XMLString];
    
    [xmlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"request xmlStr:\n %@",xmlStr);
    if (IF_NEED_EncryptionAES) {
        xmlStr = [self aesEncode:xmlStr];
    }
    //    NSDictionary *request = [NSDictionary dictionaryWithXMLString:xmlStr];
    return xmlStr;
}
- (NSString *)aesEncode:(NSString *)str{
    return  [DataEncryption encode:str];
}

- (NSString *)aesDecode:(NSString *)str{
    return [DataEncryption decode:str];
}
@end
