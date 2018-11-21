//
//  SVPShowAlertView.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 加载提示工具
 */
@interface SVPShowAlertView : NSObject

+ (void)showLoadingLonin;

/** 加载 */
+ (void)showLoadingWith:(NSString *)message;

/** 加载提示 -> 加载中... */
+ (void)showLoading;

/** 文字提醒 */
+ (void)showTextAlertViewMessage:(NSString *)message;

/** 图片提醒 */
+ (void)showAlertViewImage:(NSString *)image Message:(NSString *)message;

/** 使用此方法是时间在大约在2秒以内需要调用消失方法  原因是显示出来大约1秒  显示完全后 1秒之后消失*/
+ (void)EmploySVPShowAlertViewMessage:(NSString *)message timeInterval:(CGFloat)time;
/** 使用此方法是时间在大约在2秒以内需要调用消失方法 */
+ (void)EmploySVPShowAlertViewImage:(NSString *)image Message:(NSString *)message timeInterval:(CGFloat)time;

+ (void)dismiss;

/** ***************** 使用UIAlertView创建提示语 ******** */
+ (void)setAlertViewShowMessage:(NSString *)message;
+ (void)setAlertViewShowTitle:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle;

@end
