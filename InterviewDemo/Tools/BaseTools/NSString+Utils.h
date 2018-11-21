//
//  NSString+Utils.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  扩展String 对于空字符判断 基本上用于 model 处理后台返回NULL值
 */
@interface NSString (Utils)

/**
 *  返回字符串是否为空，或者长度为0
 *
 *  @return 如果为nil或者长度为0，返回true，否则返回false
 */
- (Boolean)isEmpty;

/**
 *  返回字符串是否为空，或者长度为 0
 *
 *  @return 如果为nil或者长度为0， 返回 @""
 */
- (NSString *)judgeisEmpty;

@end
