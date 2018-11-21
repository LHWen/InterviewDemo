//
//  DateUtils.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSString *)dateStyle:(NSString *)mSecondStr formatter:(NSString *)formatter {
    
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

/** yyyy-MM-dd HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)dateHorizontalLineStyle:(NSString *)mSecondStr {
    
    return [self dateStyle:mSecondStr formatter:@"yyyy-MM-dd HH:mm:ss"];
}

/** yyyy-MM-dd HH:mm 样式 毫秒时间戳 */
+ (NSString *)dateHorizontalLineNoSecondsStayle:(NSString *)mSecondStr {
    
    return [self dateStyle:mSecondStr formatter:@"yyyy-MM-dd HH:mm"];
}

/** yyyy-MM-dd 样式 毫秒时间戳 */
+ (NSString *)dateHorizontalLineNoTimeStayle:(NSString *)mSecondStr {
    
    return [self dateStyle:mSecondStr formatter:@"yyyy-MM-dd"];
}

/** yyyy年MM月dd日 HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)dateYearMonthDataStyle:(NSString *)mSecondStr {
    
    return [self dateStyle:mSecondStr formatter:@"yyyy年MM月dd日 HH:mm:ss"];
}

/** yyyy年MM月dd日 HH:mm 样式 毫秒时间戳 */
+ (NSString *)dateYearMonthDataNoSecondeStyle:(NSString *)mSecondStr {
    
    return [self dateStyle:mSecondStr formatter:@"yyyy年MM月dd日 HH:mm"];
}

/** yyyy年MM月dd日 样式 毫秒时间戳 */
+ (NSString *)dateYearMonthDataNoTimeStyle:(NSString *)mSecondStr {
    
   return [self dateStyle:mSecondStr formatter:@"yyyy年MM月dd日"];
}

@end
