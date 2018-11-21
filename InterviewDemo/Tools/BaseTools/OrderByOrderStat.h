//
//  OrderByOrderStat.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 排序工具
@interface OrderByOrderStat : NSObject

+ (NSArray *)sortArray:(NSArray *)array aes:(BOOL)aes;
+ (NSArray *)sortedByLetterWithArray:(NSArray *)array keyName:(NSString *)keyName;
+ (NSArray *)sortedArray:(NSArray *)array aes:(BOOL)aes;
+ (NSArray *)sortNewArray:(NSArray *)array aes:(BOOL)aes;

+ (NSArray *)sortArray:(NSArray *)array Aes:(BOOL)aes timeKey:(NSString *)timeKey;
+ (NSArray *)sortArray:(NSArray *)array Aes:(BOOL)aes timeKey:(NSString *)timeKey dateFormat:(NSString *)format;

@end
