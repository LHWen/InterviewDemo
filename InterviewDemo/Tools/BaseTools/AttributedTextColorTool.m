//
//  AttributedTextColorTool.m
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import "AttributedTextColorTool.h"

@implementation AttributedTextColorTool

+ (NSMutableAttributedString *)changeString:(NSString *)textString Color:(UIColor *)color MakeRangeStat:(NSInteger)statLen StringLength:(NSInteger)len {
    
    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:textString attributes:arrts];
    [attStr setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(statLen, len)];
    return attStr;
}

@end
