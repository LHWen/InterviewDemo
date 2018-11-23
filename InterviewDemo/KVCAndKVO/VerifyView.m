//
//  VerifyView.m
//  InterviewDemo
//
//  Created by LHWen on 2018/11/23.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import "VerifyView.h"

@interface VerifyView ()
@property (nonatomic, strong) UILabel *valueLbl2;

@end

@implementation VerifyView

// 以下这个无法做到视图懒加载布局
//- (NSString *)value1 {
//
//    if (!_value1) {
//        self.valueLbl1.text = _value1;
//    }
//    return _value1;
//}

- (void)setValue1:(NSString *)value1 {
    
    self.valueLbl1.text = value1;
    [self.valueLbl1 setNeedsDisplay];
}

- (UILabel *)valueLbl1 {
    
    if (!_valueLbl1) {
        _valueLbl1 = [CreateViewFactory p_setLableWhiteBGColorOneLineLeftText:@"懒加载"
                                                                     textFont:15.0
                                                                    textColor:[UIColor blackColor]];
        [self addSubview:_valueLbl1];
        [_valueLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10.0f);
            make.top.equalTo(@20.0f);
        }];
    }
    return _valueLbl1;
}

- (void)setValue2:(NSString *)value2 {
    
    _value2 = value2;
    _valueLbl2.text = _value2;
    
    // 需要是再更新
    [_valueLbl2 setNeedsDisplay];
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self setupValueLableTwoLayout];
    }
    return self;
}

- (void)setupValueLableTwoLayout {
    
    if (!_valueLbl2) {
        _valueLbl2 = [CreateViewFactory p_setLableWhiteBGColorOneLineLeftText:@"测试创建lable视图"
                                                                     textFont:15.0
                                                                    textColor:[UIColor redColor]];
        [self addSubview:_valueLbl2];
        [_valueLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10.0f);
            make.bottom.equalTo(@(-20.0f));
        }];
    }
}

@end
