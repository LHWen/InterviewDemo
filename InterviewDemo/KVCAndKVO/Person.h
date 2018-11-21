//
//  Person.h
//  InterviewDemo
//
//  Created by LHWen on 2018/11/21.
//  Copyright © 2018 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *kName;
@property (nonatomic, copy) NSString *kIsName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *isName;

- (void)testName;

@end

NS_ASSUME_NONNULL_END
