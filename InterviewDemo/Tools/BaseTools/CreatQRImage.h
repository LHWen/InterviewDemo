//
//  CreatQRImage.h
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 创建二维码
@interface CreatQRImage : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;

@end
