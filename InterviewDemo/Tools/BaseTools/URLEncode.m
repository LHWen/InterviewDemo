//
//  URLEncode.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "URLEncode.h"

@implementation URLEncode

+ (NSString *)urlEncode:(NSString *)string {
    
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)string,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:@&amp;=+$,/?%#[]"),
                                                                                 kCFStringEncodingUTF8));
}

@end
