//
//  BaseViewController.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  返回 导航栏左侧按钮  在需要向前几个层次的 回跳时可以重写此方法
 */
- (void)backButtonClicked;

- (void)setupNavigationItemTitleCenter;

/** 动画执行弹框 */
- (void)alertViewMessage:(NSString *)message fontSize:(CGFloat)fSize;

@end
