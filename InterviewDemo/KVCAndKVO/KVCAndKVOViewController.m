//
//  KVCAndKVOViewController.m
//  InterviewDemo
//
//  Created by LHWen on 2018/11/21.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import "KVCAndKVOViewController.h"
#import "Person.h"

@interface KVCAndKVOViewController ()

@property (nonatomic, strong) Person *kvoPerson;

@end

@implementation KVCAndKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self testKVCFunction];
    [self testKVOFunction];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"KVOChange" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(cilckChangValue:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 40, 200, 44);
    [self.view addSubview:button];
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
