//
//  AppDelegate.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "AppDelegate.h"
#import "SQLiteDaoHelper.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()

@property (nonatomic, strong, readwrite) FMDatabaseQueue *dbQueue;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self p_setupDB];
    [self initNavigationStyle];
    
    return YES;
}

- (void)p_setupDB {
    
    SQLiteDaoHelper *daoHelper = [SQLiteDaoHelper sharedInstance];
    [daoHelper setup];
    _dbQueue = daoHelper.dbQueue;
}

// 初始化导航栏属性
- (void)initNavigationStyle {
    
    // 状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 设置导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[Utility colorWithHexString:@"#1aa0ed"]];
    // 设置导航栏字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 设置导航栏字体和颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName: [UIFont systemFontOfSize:18.0f],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }];
}

#pragma mark - 重新登录
- (void)relogin {
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UserDefaultsHelper setStringForKey:@"" :@"Token"];
//        LoginViewController *vc = [[LoginViewController alloc] init];
//        _window.rootViewController = vc;
//        [self.window makeKeyAndVisible];
//    });
}

- (void)changeRootViewControllerWithController:(UIViewController *)controller {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _window.rootViewController = controller;
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
