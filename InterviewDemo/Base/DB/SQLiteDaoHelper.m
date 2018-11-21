//
//  SQLiteDaoHelper.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "SQLiteDaoHelper.h"

@implementation SQLiteDaoHelper

- (void)createOrUpgradeDBTablesWithOldVersion:(int)oldVersion {

    [self p_initTables];
}

- (void)p_initTables {
    
//    [self p_setupCacheTable];
}

// Cache table
- (void)p_setupCacheTable {
    // 创建TB_CACHE
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"CREATE TABLE IF NOT EXISTS TB_CACHE ( "];
    [sql appendString:@"CACHE_VALUE      VERCHAR(80)      NOT NULL)"];        // 历史查询字段
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
    
    sql = nil;
}

@end
