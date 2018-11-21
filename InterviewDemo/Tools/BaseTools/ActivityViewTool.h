//
//  ActivityViewTool.h
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 加载视图工具 
@interface ActivityViewTool : NSObject

/** 网络请求提示视图 默认
 *  @param view 是Activity需要显示所在的view
 */
+ (void)showAvtivityView:(UIView *)view;

/** 网络请求提示视图 自定义 高度 */
+ (void)showAvtivityView:(UIView *)view topSpace:(CGFloat)space;

/** 网络请求提示视图 自定义 颜色 */
+ (void)showAvtivityView:(UIView *)view topSpace:(CGFloat)space avtivityColor:(UIColor *)color;

/** 关闭网络请求提示视图 */
+ (void)dismissAvitivity;

@end
