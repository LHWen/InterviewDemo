//
//  NSString+Utils.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (Boolean)isEmpty {
    return !self || [self isKindOfClass:[NSNull class]] || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
}

- (NSString *)judgeisEmpty {
    
    BOOL isEmpty = !self || [self isKindOfClass:[NSNull class]] || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
    
    if (isEmpty) {
        return @"";
    }else {
        return self;
    }
}

@end
