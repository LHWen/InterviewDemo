//
//  BaseViewController.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationBar+Addition.h"

@interface BaseViewController ()
{
    UIView *_alertBackgroundView;
    UIView *_alertView;
    UILabel *_promptLable;
    BOOL _isShowing;
}

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 不透明
    self.navigationController.navigationBar.translucent = NO;
    // 隐藏分割线
//    [self.navigationController.navigationBar hideBottomHairline];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    // --- 设置返回按钮 --- 需要时 在开启 ---
    //     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    }else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0) forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:nil action:nil];
    }
    
    if (@available(iOS 11.0, *)) {
        if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) { // iPhone X
            
            self.additionalSafeAreaInsets = UIEdgeInsetsMake(self.view.safeAreaInsets.top, 0, 0, 0);
        }
    } else {
        // Fallback on earlier versions
    }
    //    [self setupNavigationItemTitleCenter];  // 导航栏标题居中设置
}

// 导航栏标题居中 设置
- (void)setupNavigationItemTitleCenter {
    
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@"  "
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
}

// 点击导航栏左侧按钮 返回
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertViewMessage:(NSString *)message fontSize:(CGFloat)fSize {
    
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fSize]}];
    
    if (!_isShowing) {
        
        _isShowing = YES;
        
        _alertBackgroundView = [CreateViewFactory p_setViewBGColor:[UIColor clearColor]];
        _alertBackgroundView.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT);
        [[UIApplication sharedApplication].keyWindow addSubview:_alertBackgroundView];
        //        [self.view addSubview:_alertBackgroundView];
        //        [_alertBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.left.right.bottom.equalTo(self.view);
        //        }];
        
        _alertView = [[UIView alloc] init];
        _alertView.layer.cornerRadius = 4.0f;
        _alertView.layer.masksToBounds = YES;
        _alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        [_alertBackgroundView addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(_alertBackgroundView);
            make.height.equalTo(@(size.height + 30.0f));
            make.width.equalTo(@(size.width + 40.0f));
        }];
        
        _promptLable = [[UILabel alloc] init];
        _promptLable.text = message;
        _promptLable.textAlignment = NSTextAlignmentCenter;
        _promptLable.backgroundColor = [UIColor clearColor];
        _promptLable.textColor = [UIColor whiteColor];
        _promptLable.font = [UIFont systemFontOfSize:fSize];
        [_alertView addSubview:_promptLable];
        [_promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(_alertView);
        }];
        
        [UIView animateWithDuration:0.2 animations:^{
            _alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        } completion:^(BOOL finished) {
            //延迟操作
            double delayInSeconds;
            if (message.length < 5) {
                delayInSeconds = 1.0;
            }else if (message.length < 10) {
                delayInSeconds = 2.0;
            }else {
                delayInSeconds = 3.0;
            }
            __block BaseViewController *weakSelf = self;
            dispatch_time_t dismissTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(dismissTime, dispatch_get_main_queue(), ^{
                [weakSelf dismissAlertView];
            });
        }];
    }
}

- (void)dismissAlertView {
    
    _isShowing = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        _alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    } completion:^(BOOL finished) {
        [_promptLable removeFromSuperview];
        _promptLable = nil;
        [_alertView removeFromSuperview];
        _alertView = nil;
        [_alertBackgroundView removeFromSuperview];
        _alertBackgroundView = nil;
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVPShowAlertView dismiss];
}

@end
