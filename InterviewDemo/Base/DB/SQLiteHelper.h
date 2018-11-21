//
//  SQLiteHelper.h
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

static const int PPDBVersion = 1; // 数据库版本,如果需要升级，那么需要修改此版本号

//记得改回9

/**
 *  数据库操作
 *  负责创建数据库
 */
@interface SQLiteHelper : NSObject

+ (instancetype)sharedInstance;
- (void)setup;

/**
 *  数据库操作队列
 */
@property (nonatomic ,strong ,readonly) FMDatabaseQueue *dbQueue;

/**
    创建或升级数据库表, 子类负责实现
 */
- (void)createOrUpgradeDBTablesWithOldVersion:(int)oldVersion;

@end
