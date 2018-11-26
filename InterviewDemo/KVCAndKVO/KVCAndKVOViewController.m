//
//  KVCAndKVOViewController.m
//  InterviewDemo
//
//  Created by LHWen on 2018/11/21.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import "KVCAndKVOViewController.h"
#import "Person.h"

#import "VerifyView.h"

@interface KVCAndKVOViewController ()

@property (nonatomic, strong) Person *kvoPerson;
@property (nonatomic, strong) VerifyView *verifyView;

@end

@implementation KVCAndKVOViewController

- (VerifyView *)verifyView {
    
    if (!_verifyView) {
        _verifyView = [[VerifyView alloc] init];
        _verifyView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_verifyView];
        [_verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.equalTo(@200.0f);
        }];
    }
    return _verifyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    // 测试懒加载视图跟创建好视图 setter值
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setTitle:@"懒加载视图" forState:UIControlStateNormal];
    [but1 setBackgroundColor:[UIColor redColor]];
    [but1 addTarget:self action:@selector(cilckChangValueLayzer:) forControlEvents:UIControlEventTouchUpInside];
    but1.frame = CGRectMake(20, 240, 200, 44);
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setTitle:@"先创建视图setter赋值" forState:UIControlStateNormal];
    [but2 setBackgroundColor:[UIColor redColor]];
    [but2 addTarget:self action:@selector(cilckChangValueSetter:) forControlEvents:UIControlEventTouchUpInside];
    but2.frame = CGRectMake(20, 300, 200, 44);
    [self.view addSubview:but2];
    
    /** 以下放开注释是 KVC KVO 内容 */
    
//    [self testKVCFunction];
//    [self testKVOFunction];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"KVOChange" forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor redColor]];
//    [button addTarget:self action:@selector(cilckChangValue:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(20, 40, 200, 44);
//    [self.view addSubview:button];
}

- (void)cilckChangValueLayzer:(UIButton *)sender {
    
    // 两种方法都可行，实现视图懒加载
    self.verifyView.value1 = @"懒加载视图加载,使用setter方法进行懒加载";
    
//    self.verifyView.valueLbl1.text = @"视图直接懒加载";
}

- (void)cilckChangValueSetter:(UIButton *)sender {
    self.verifyView.value2 = @"视图先创建了进行setter赋值刷新";
}

// KVC
// KVC在设置时可能会设置错误的Key值导致程序崩溃，需要重写valueForUndefinedKey:和setValue:forUndefinedKey:。
// 还有一种是在设置中不小心传递了nil，这时候需要重写setNilValueForKey:
- (void)testKVCFunction {
    
    Person *person = [[Person alloc] init];
    [person valueForKey:@"name"]; // get 方法， (NSString *)tName set方法
    [person setValue:@"ADA" forKey:@"name"]; // 调用set 方法 name方法也会调用,
//    person.tName = @"QAQ"; // .方法调用set 与setValue forkey 一样调用set方法
    [person testName];
}

// KVO
- (void)testKVOFunction {
    
    _kvoPerson = [[Person alloc] init];
    // 添加监听事件
    [_kvoPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

// 点击改变name值
- (void)cilckChangValue:(UIButton *)sender {
    _kvoPerson.name = @"ADA";
}

// 处理消息
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"keyPatch = %@", keyPath);
    NSLog(@"object = %@", object);
    NSLog(@"change = %@", change);
}

- (void)dealloc {
    [_kvoPerson removeObserver:self forKeyPath:@"name" context:nil];
}

@end
