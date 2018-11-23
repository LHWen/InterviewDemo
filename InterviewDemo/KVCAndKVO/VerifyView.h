//
//  VerifyView.h
//  InterviewDemo
//
//  Created by LHWen on 2018/11/23.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyView : UIView

@property (nonatomic, copy) NSString *value1; // 如果使用string 赋值进行视图布局，不能这样处理需要换一种处理
@property (nonatomic, copy) NSString *value2;
@property (nonatomic, strong) UILabel *valueLbl1; // 直接视图懒加载布局，可以做到懒加载处理

@end

NS_ASSUME_NONNULL_END
