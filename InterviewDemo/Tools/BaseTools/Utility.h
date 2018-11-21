//
//  Utility.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//  16进制颜色直接使用、颜色转换成图片类

@interface Utility : NSObject

/** 十六进制颜色转换 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/** 颜色转化为图片 */
+ (UIImage*)createImageWithColor:(UIColor*)color;

@end
