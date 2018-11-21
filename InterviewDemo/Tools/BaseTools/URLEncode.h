//
//  URLEncode.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 中文转码，用于网络请求
 */
@interface URLEncode : NSObject

+ (NSString *)urlEncode:(NSString *)string;

@end
