//
//  BaseOperation.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "BaseOperation.h"

// 错误结构体
typedef struct Response{
    CFErrorRef error;
    bool stat;
} Response;

static int const kMaxConnectionForHost = 10;    // 最大网络请求连接数限制
static int const kTimeoutForRequest = 20;       // 网络请求超时限制
static int const kTimeoutForResource = 60;      // 获取资源超时限制

@interface BaseOperation ()

@property (nonatomic, strong, readwrite) NSURLSession *session;
@property (nonatomic, strong, readwrite) NSOperationQueue *parseQueue;

// 初始化网路请求
- (void)p_initNetworkConfigure;
// 处理http请求响应
- (Response)p_errorWithResponse:(NSURLResponse *)response;

@end

@implementation BaseOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_initNetworkConfigure];
    }
    return self;
}


- (void)p_initNetworkConfigure {
    if (!_session) {
        // 配置Session
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPMaximumConnectionsPerHost = kMaxConnectionForHost;
        configuration.timeoutIntervalForRequest = kTimeoutForRequest;
        configuration.timeoutIntervalForResource = kTimeoutForResource;
        // 初始化Sesson
        _session = [NSURLSession sessionWithConfiguration:configuration
                                                 delegate:nil
                                            delegateQueue:[[NSOperationQueue alloc] init]];
    }
}

- (NSOperationQueue *)parseQueue {
    if (!_parseQueue) {
        _parseQueue = [[NSOperationQueue alloc] init];
    }
    return _parseQueue;
}

- (void)startTaskWithCallBack:(EECompletion)callback {
    // 子类实现
}

- (void)sendReqeust:(NSMutableURLRequest *)request {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
//    NSString *token = [UserDefaultsHelper getStringForKey:@"Token"];
//    NSLog(@"Token===%@", token);
//    [request addValue:token forHTTPHeaderField:@"Token"];
    
    __weak BaseOperation *weakSelf = self;
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态来网络请求指示
                                                     });
                                                     
                                                     if (error) {
                                                         weakSelf.completion(nil, error, nil);
                                                         return ;
                                                     }
                                                     
                                                     Response r = [weakSelf p_errorWithResponse:response];
                                                     if (!r.stat && r.error) {
                                                         weakSelf.completion(nil,(__bridge NSError *)r.error, nil);
                                                         return;
                                                     }
                                                     
//                                                     NSError *jsonError;
//                                                     NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//                                                     int stat = [[json valueForKey:@"stat"] intValue];
//                                                     if (stat == -2) {
//                                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                                             [SVPShowAlertView dismiss];
//                                                             [SVPShowAlertView showTextAlertViewMessage:@"Token失效"];
//                                                         });
//                                                         [[NSNotificationCenter defaultCenter] postNotificationName:TGEReLoginNotification object:nil userInfo:nil];
//                                                         return;
//                                                     }
//
//                                                     if (stat == -3) {
//                                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                                             [SVPShowAlertView dismiss];
//                                                             [SVPShowAlertView showTextAlertViewMessage:[NSString stringWithFormat:@"%@", [json valueForKey:@"err"]]];
//                                                         });
//                                                         [[NSNotificationCenter defaultCenter] postNotificationName:TGENOTFUNCTIONPERMISSIONS object:nil userInfo:nil];
//                                                         return;
//                                                     }
                                                     
                                                     [weakSelf parseData:data];
                                                 }];
    [dataTask resume];
}

- (void)uploadFileReqeust:(NSMutableURLRequest *)request fromData:(NSData *)data {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    NSString *token = [UserDefaultsHelper getStringForKey:@"Token"];
//    NSLog(@"Token===%@", token);
//    [request addValue:token forHTTPHeaderField:@"Token"];
    
    __weak BaseOperation *weakSelf = self;
    NSURLSessionDataTask *dataTask = [_session uploadTaskWithRequest:request
                                                            fromData:data
                                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态来网络请求指示
                                                       });
                                                       
                                                       if (error) {
                                                           weakSelf.completion(nil,error, nil);
                                                           return ;
                                                       }
                                                       
                                                       Response r = [weakSelf p_errorWithResponse:response];
                                                       if (!r.stat && r.error) {
                                                           weakSelf.completion(nil,(__bridge NSError *)r.error, nil);
                                                           return;
                                                       }
                                                       
//                                                       NSError *jsonError;
//                                                       NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//                                                       int stat = [[json valueForKey:@"stat"] intValue];
//                                                       if (stat == -2) {
//                                                           [[NSNotificationCenter defaultCenter] postNotificationName:TGEReLoginNotification object:nil userInfo:nil];
//                                                           return;
//                                                       }
//
//                                                       if (stat == -3) {
//                                                           dispatch_async(dispatch_get_main_queue(), ^{
//                                                               [SVPShowAlertView dismiss];
//                                                               [SVPShowAlertView showTextAlertViewMessage:[NSString stringWithFormat:@"%@", [json valueForKey:@"err"]]];
//                                                           });
//                                                           [[NSNotificationCenter defaultCenter] postNotificationName:TGENOTFUNCTIONPERMISSIONS object:nil userInfo:nil];
//                                                           return;
//                                                       }
                                                       
                                                       [weakSelf parseData:data];
                                                   }];
    [dataTask resume];
}

- (Response)p_errorWithResponse:(NSURLResponse *)response {
    struct Response r;
    
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    if (resp.statusCode != 200) {
        r.stat = false;
        r.error = (__bridge CFErrorRef)[NSError errorWithDomain:kEENetWorkDomain
                                                           code:EERequestErrorResponse
                                                       userInfo:@{
                                                                  @"url": resp.URL,
                                                                  @"statsCode": @(resp.statusCode),
                                                                  }];
        
        return r;
    }
    r.stat = true;
    return r;
}

- (NSError *)paramErrorWithInfo:(NSString *)info {
    return [self p_errorWithDoamin:kEENetWorkDomain
                              code:EERequestErrorParams
                              info:info];
}

- (NSError *)p_errorWithDoamin:(NSString *)domain
                          code:(NSInteger)code
                          info:(NSString *)info {
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:@{@"info": info}];
}

- (void)parseData:(NSData *)data {
    // 子类实现
}

- (void)dealloc {
    _completion = nil;
    _parseQueue = nil;
}

@end
