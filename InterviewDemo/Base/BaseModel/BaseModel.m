//
//  BaseModel.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithDictionary:(NSDictionary*)jsonObject {
    
    if((self = [super init])) {
        
        [self setValuesForKeysWithDictionary:jsonObject];
    }
    return self;
}

@end
