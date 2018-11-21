//
//  Person.m
//  InterviewDemo
//
//  Created by LHWen on 2018/11/21.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)getName {
    
    NSLog(@"--- get name 1 ---");
    NSLog(@"%s", __func__);
    NSLog(@"--- get name 0 ---");
    return @"D";
}

// a该方法与以下set方法无法共存
//- (NSString *)name {
//
//    NSLog(@"--- name 1 ---");
//    NSLog(@"%s", __func__);
//    NSLog(@"--- name 0 ---");
//    return @"D";
//}

- (NSString *)isName {
    
    NSLog(@"--- isName 1 ---");
    NSLog(@"%s", __func__);
    NSLog(@"--- isName 0 ---");
    return @"D";
}

- (void)setName:(NSString *)name {

    NSLog(@"---- set name  1 -----");
    NSLog(@"%s", __func__);
    NSLog(@"---- is name 0 ----");
}

- (void)testName {
    
    NSLog(@"kName = %@", _kName);
    NSLog(@"name = %@", _name);
    NSLog(@"isName = %@", _isName);
    NSLog(@"kIsName = %@", _kIsName);
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    NSLog(@"取值没有找到key %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"设值没有找到这个key %@", key);
}

+ (BOOL)accessInstanceVariablesDirectly {
    
    return YES;
}

@end
