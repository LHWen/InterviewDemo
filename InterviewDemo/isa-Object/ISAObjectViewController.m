//
//  ISAObjectViewController.m
//  InterviewDemo
//
//  Created by LHWen on 2018/11/26.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import "ISAObjectViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

/**
 参考文献： https://www.jianshu.com/p/41735c66dccb
 在Objective-C中，任何类的定义都是对象。类和类的实例（对象）没有任何本质上的区别。任何对象都有isa指针。
 
 isa 是一个 Class 类型的指针。每个实例对象都有一个 isa 的指针，它指向对象类，而Class里也有一个 isa 的指针，指向meteClass（元类）。
 元类保存了 类方法 列表。当类方法被调用时，先从本身查找类方法的实现，如果没有，元类就会向它父类查找该方法。
 同时注意：元类（meteClass）也是类，它也是对象。
 元类也有 isa 指针，它的 isa 指针最终指向一个根元类(root meteClass)。
 根元类的 isa 指针指向本身，这样形成了一个封闭的内循环。
 */

@interface ISAObjectViewController ()

@end

@implementation ISAObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"isa object";
    
    // 用objc_allocateClassPair 创建新类
    Class newClass = objc_allocateClassPair([UIView class], "WenView", 0);
    // class_addMethod 为类增加新的方法
    class_addMethod(newClass, @selector(loveView), (IMP)loveFunction, 0);
    // class_addProperty 为类增加属性
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = {"C", ""};  // C = copy
    objc_property_attribute_t backingivar = {"V", "_privateName"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    class_addProperty([newClass class], "name", attrs, 3);
    // objc_registerVlassPair 注册类
    objc_registerClassPair(newClass);
    
    id newClassObjc = [[newClass alloc] init];
    [newClassObjc performSelector:@selector(loveView)];
    
    // class_copyIvarList 获取变量名列表
    unsigned int ivarsCnt = 0;
    // 获取类成员变量列表，ivarsCnt为类成员数量 ivars 成员变量的数组
    Ivar *ivars = class_copyIvarList([UIView class], &ivarsCnt);
    // 遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p) {
        Ivar const ivar = *p;
        // 获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"这里输出变量名%@", key);
    }
    
    // class_copyMethodList 获取方法名列表
    u_int count;
    Method *methods = class_copyMethodList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"这里输出方法名%@", strName);
    }
    
}

void loveFunction(id self, SEL _cmd) {
    
    NSLog(@"这只是一个例子，输出这个方法");
    NSLog(@"这里输出 isa 指针指向的对象：使用%p", object_getClass([NSObject class]));
    NSLog(@"这里输出的对象：使用%p", [NSObject class]);
}

@end
