//
//  AttributedTextColorTool.h
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 修改富文本字体颜色

@interface AttributedTextColorTool : NSObject

/**
 *  富文本 修改字体颜色 返回修改后的文本
 *  @param textString 传入修改的全部文本字体
 *  @param color 修改字体颜色
 *  @param statLen 修改的开始位置
 *  @param len 改变的长度
 *  @return attributedText
 */
+ (NSMutableAttributedString *)changeString:(NSString *)textString Color:(UIColor *)color MakeRangeStat:(NSInteger)statLen StringLength:(NSInteger)len;

@end
