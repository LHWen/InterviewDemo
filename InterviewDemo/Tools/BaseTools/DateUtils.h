//
//  DateUtils.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  时间日期样式
 */
@interface DateUtils : NSObject

/** yyyy-MM-dd HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)dateHorizontalLineStyle:(NSString *)mSecondStr;

/** yyyy-MM-dd HH:mm 样式 毫秒时间戳 */
+ (NSString *)dateHorizontalLineNoSecondsStayle:(NSString *)mSecondStr;

/** yyyy-MM-dd 样式 毫秒时间戳 */
+ (NSString *)dateHorizontalLineNoTimeStayle:(NSString *)mSecondStr;

/** yyyy年MM月dd日 HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)dateYearMonthDataStyle:(NSString *)mSecondStr;

/** yyyy年MM月dd日 HH:mm 样式 毫秒时间戳 */
+ (NSString *)dateYearMonthDataNoSecondeStyle:(NSString *)mSecondStr;

/** yyyy年MM月dd日 样式 毫秒时间戳 */
+ (NSString *)dateYearMonthDataNoTimeStyle:(NSString *)mSecondStr;

@end
