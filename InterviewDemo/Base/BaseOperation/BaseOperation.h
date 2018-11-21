//
//  BaseOperation.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求方法常量
static NSString *const kHttpPost = @"POST";
static NSString *const kHttpGet = @"GET";
static NSString *const kHttpPut = @"PUT";

/**
 *  网络请求错误枚举
 */
typedef NS_ENUM(NSUInteger, EERequestError) {
    EERequestErrorParams = 10000,        // 参数有问题时返回的错误码
    EERequestErrorResponse = 20000,      // http响应错误码
};

/**
 *  Prod
 */
static NSString *const kBaseWSURL = @"";     // 生产环境

static NSString *const KBaseLogURL = @"";    // 登录日志使用

static NSString *const kBaseShareURL = @"";  // 分享端口使用

/**
 *  网络请求错误域
 */
static NSString *const kEENetWorkDomain = @"net.gdyuhui.wgt";

/**
 *  http请求回调block
 *
 *  @param obj   返回值，如果有，否则返回nil
 *  @param error 错误信息，如果有，否则返回nil
 *  @param stat  返回的状态码 0 为请求成功
 */
typedef void(^EECompletion)(id<NSObject> obj, NSError *error, id stat);

/**
 *  基本网络请求，用于处理基本的网络任务
 */

@interface BaseOperation : NSObject

/**
 *  请求完成回调
 */
@property (nonatomic, copy) EECompletion completion;

/**
 *  解析操作队列，用于解析服务端返回的数据
 */
@property (nonatomic, strong, readonly) NSOperationQueue *parseQueue;

/**
 *  开始网络请求，子类必须实现
 *
 *  @param callback 请求回调，如果请求发生错误，在error中返回，错误信息
 */
- (void)startTaskWithCallBack:(EECompletion)callback;

/**
 *  发送Http请求，方法请求成功会，回调parseData方法
 *
 *  @param request http request
 */
- (void)sendReqeust:(NSMutableURLRequest *)request;

/**
 *  发送上传文件请求，方法请求成功会，回调parseData方法
 *
 *  @param request http request  NSData
 */
- (void)uploadFileReqeust:(NSMutableURLRequest *)request fromData:(NSData *)data;

/**
 *  返回一个参数错误
 *
 *  @param info 错误描述
 *
 *  @return Error
 */
- (NSError *)paramErrorWithInfo:(NSString *)info;

/**
 *  解析数据，子类实现
 *
 *  @param data 数据
 */
- (void)parseData:(NSData *)data;

@end
