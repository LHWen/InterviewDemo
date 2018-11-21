//
//  JudgePhoneNumber.m
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import "JudgePhoneNumber.h"

@implementation JudgePhoneNumber

// 判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile {
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        /**
         * 大陆地区固话及小灵通
         * 区号：010,020,021,022,023,024,025,027,028,029
         * 号码：七位或八位
         */
        NSString *PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        NSPredicate *pred4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        BOOL isMatch4 = [pred4 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3 || isMatch4) {
            return YES;
        } else {
            return NO;
        }
    }
}

// 去掉空格，判断手机号长度是否为11位
+ (BOOL)moblieLenght:(NSString *)mobile {
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    } else {
        return YES;
    }
}


@end
