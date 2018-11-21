//
//  SVPShowAlertView.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "SVPShowAlertView.h"
#import "SVProgressHUD.h"        // 第三方加载提示类

static CGFloat const disappearTime = 1.5f;

@implementation SVPShowAlertView

+ (void)showLoadingLonin {
    
    UIFont *font = [self loadFont];
    
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:font];
    [SVProgressHUD showWithStatus:@"正在登录..."];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat]; // 圆圈的转动动作
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)showLoadingWith:(NSString *)message {
    
    UIFont *font = [self loadFont];
    
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:font];
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat]; // 圆圈的转动动作
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];   // SVProgressHUDMaskTypeClear
}

+ (void)showLoading {
    
    UIFont *font = [self loadFont];
    
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:font];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat]; // 圆圈的转动动作
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

+ (void)showTextAlertViewMessage:(NSString *)message {
    
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:nil status:message];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(disappearTime * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

+ (void)showAlertViewImage:(NSString *)image Message:(NSString *)message {
    
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:[UIImage imageNamed:image] status:message];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(disappearTime * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self dismiss];
    });
    
}

+ (void)EmploySVPShowAlertViewMessage:(NSString *)message timeInterval:(CGFloat)disappearTime {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:nil status:message];
    
    [NSTimer scheduledTimerWithTimeInterval:disappearTime target:self selector:@selector(dismiss) userInfo:nil repeats:YES];
}

+ (void)EmploySVPShowAlertViewImage:(NSString *)image Message:(NSString *)message timeInterval:(CGFloat)disappearTime {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:[UIImage imageNamed:image] status:message];
    
    [NSTimer scheduledTimerWithTimeInterval:disappearTime target:self selector:@selector(dismiss) userInfo:nil repeats:YES];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (UIFont *)loadFont {
    
    UIFontDescriptor *baskervile = [UIFontDescriptor
                                    fontDescriptorWithFontAttributes:
                                    @{UIFontDescriptorFamilyAttribute : @"Baskerville"}];
    UIFontDescriptor *bodyFont = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    NSNumber* bodyFontSize = bodyFont.fontAttributes[UIFontDescriptorSizeAttribute];
    float bodyFontSizeValue = [bodyFontSize floatValue];
    
    return [UIFont fontWithDescriptor:baskervile size:bodyFontSizeValue];
}

/** ***************** 使用UIAlertView创建提示语 ******** */
+ (void)setAlertViewShowMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

+ (void)setAlertViewShowTitle:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle {
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil] show];
}


@end
