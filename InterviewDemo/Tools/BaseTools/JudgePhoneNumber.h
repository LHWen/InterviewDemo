//
//  JudgePhoneNumber.h
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 正则判断手机号是否正确

@interface JudgePhoneNumber : NSObject

/** 截止2018/4/27的手机号码判断，如若手机号出现新的开头号，需要添加对应的运营商中判断 */
+ (BOOL)valiMobile:(NSString *)mobile;

/** 去空格 11位数字判断法 */
+ (BOOL)moblieLenght:(NSString *)mobile;

@end
