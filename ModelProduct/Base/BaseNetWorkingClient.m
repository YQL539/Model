//
//  BaseNetWorking.m
//  WoVPNStore
//
//  Created by apple on 2017/8/9.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "BaseNetWorkingClient.h"
#import "AFHTTPSessionManager.h"


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
        _HTTPManager.requestSerializer.HTTPShouldHandleCookies = YES;
    
        _HTTPManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _HTTPManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [_HTTPManager.requestSerializer setTimeoutInterval:HTTP_TIMEOUT];
        
        //把版本号信息传导请求头中
        [_HTTPManager.requestSerializer setValue:[NSString stringWithFormat:@"iOS-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"MM-Version"];
//        [_HTTPManager.requestSerializer setValue:@"text/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_HTTPManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
        _HTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",@"text/javascript",nil];
      
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

+ (void)createGETRequest:(NSString *)urlPath
               WithParam:(NSDictionary *)param
                 success:(void(^)(id result))success
                 failure:(void(^)(NSError *error))failure{
    [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"GET" success:success failure:failure];
}

+(void)createPOSTRequest:(NSString *)urlPath
               WithParam:(NSDictionary *)param
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure{
    [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"POST" success:success failure:failure];
}

+(void)createPUTRequest:(NSString *)urlPath
              WithParam:(NSDictionary *)param
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure{
    [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"PUT" success:success failure:failure];
}

+(void)createDELETERequest:(NSString *)urlPath
                 WithParam:(NSDictionary *)param
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure{
    [[BaseNetWorkingClient sharedInstance] createRequest:urlPath WithParam:param WithMethod:@"DELETE" success:success failure:failure];
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
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                success(result);
            }
        }
    }];
    
    [dataTask resume];
}

//上传
+ (void)createUpLoadRequest:(NSString *)urlPath
                  WithParam:(NSDictionary*)param
                   withData:(NSData*)data
               withFileName:(NSString *)fileName
                    success:(void (^)(id result))success
         uploadFileProgress:(void(^)(double uploadProgress))uploadFileProgress
                    failure:(void (^)(NSError* erro))failure
{
    NSMutableDictionary *Exparams = [[NSMutableDictionary alloc]init];
    [Exparams addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:data,fileName, nil]];
    [[BaseNetWorkingClient sharedInstance] createUpLoadRequest:urlPath WithParam:param withExParam:Exparams success:success uploadFileProgress:uploadFileProgress failure:failure];
    
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

//下载
+(void)createDownloadFileWithURLString:(NSString *)URLString downloadFileProgress:(void (^)(double))downloadFileProgress setupFilePath:(NSURL *(^)(NSURLResponse *))setupFilePath downloadCompletionHandler:(void (^)(NSURL *, NSError *))downloadCompletionHandler{
    if (URLString) {
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

@end
