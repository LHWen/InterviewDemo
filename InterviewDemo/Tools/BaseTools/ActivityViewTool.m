//
//  ActivityViewTool.m
//  InterviewDemo
//
//  Created by LHWen on 2018/4/27.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import "ActivityViewTool.h"

@implementation ActivityViewTool {
    UIActivityIndicatorView *_activityView;    // 加载动画View
}

// 创建单例
+ (ActivityViewTool *)activityView {
    
    static dispatch_once_t once;
    static ActivityViewTool *activityView;
    dispatch_once(&once, ^{
        activityView = [[self alloc] init];
    });
    return activityView;
}

//-----网络请求提示视图 默认----
+ (void)showAvtivityView:(UIView *)view {
    
    [[self activityView] showAvtivityIndicatorView:view topSpace:120.0f avtivityColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
}

//----网络请求提示视图 自定义 高度----
+ (void)showAvtivityView:(UIView *)view topSpace:(CGFloat)space {
    
    [[self activityView] showAvtivityIndicatorView:view topSpace:space avtivityColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
}

//-----网络请求提示视图 自定义 高度 颜色----
+ (void)showAvtivityView:(UIView *)view topSpace:(CGFloat)space avtivityColor:(UIColor *)color {
    
    [[self activityView] showAvtivityIndicatorView:view topSpace:space avtivityColor:color];
}

//------关闭网络请求提示视图-----
+ (void)dismissAvitivity {
    
    [[self activityView] dismissAvtivityView];
}

- (void)showAvtivityIndicatorView:(UIView *)view topSpace:(CGFloat)space avtivityColor:(UIColor *)color {
    
    if (!_activityView) {
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.center = CGPointMake(view.center.x, space);
        CGAffineTransform transform = CGAffineTransformMakeScale(0.65f, 0.65f);
        _activityView.transform = transform;
        _activityView.backgroundColor = nil;
        _activityView.color = color;
        [_activityView startAnimating];
        [view addSubview:_activityView];
    }
}

- (void)dismissAvtivityView {
    
    [_activityView removeFromSuperview];
    _activityView = nil;
}

@end
