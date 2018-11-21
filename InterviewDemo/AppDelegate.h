//
//  AppDelegate.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ADelegate ((AppDelegate *) [UIApplication sharedApplication].delegate)

@class FMDatabaseQueue;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;

/**
 设置root vc 没有导航栏
 */
- (void)changeRootViewControllerWithController:(UIViewController *)controller;

/**
 * 获取当前登陆用户的用户名
 */
@property (nonatomic, copy, readonly) NSString *username;

/** 重新登录 */
- (void)relogin;

@end

