//
//  CalculateTextHeight.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  计算文本的高度
 */
@interface CalculateTextHeight : NSObject

+ (CGFloat)calculateTextHeightWithText:(NSString *)text withWidth:(CGFloat)width andTextSize:(CGFloat)size;

/**
 *  计算带有行间距的文本高度
 *
 *  @param string     textString
 *  @param fontSize   文字尺寸
 *  @param width      设置lable的宽度
 *  @param maxHeight     限制UILable的高度 默认传屏幕高度
 *  @param spacing    行间距
 *
 *  @return           文本高度
 */
+ (CGFloat)getSpaceTextHeight:(NSString*)string withFontSize:(CGFloat)fontSize andWidth:(CGFloat)width andMaxHeight:(CGFloat)maxHeight andLineSpacing:(CGFloat)spacing;

@end
