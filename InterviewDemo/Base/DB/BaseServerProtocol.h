//
//  BaseServerProtocol.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  基本服务协议
 */
@protocol BaseServerProtocol <NSObject>

/**
 *  保存一个实体信息到数据库
 */
- (void)saveObj:(NSObject *)obj;

/**
 *  从数据库删除一个实体信息
 */
- (void)deleteObj:(NSObject *)obj;

/**
 *  更新实体信息
 */
- (void)updateObj:(NSObject *)obj;

@end
