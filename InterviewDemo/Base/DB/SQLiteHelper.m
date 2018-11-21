//
//  SQLiteHelper.m
//  InterviewDemo
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#import "SQLiteHelper.h"

static NSString *const kdbName = @"sm.sqlite";          // 数据库名称
static NSString *const kStoreDirectory = @"stores";     // 数据库存储目录
static const int kNotFoundDBVersion = -1;               // 没有找到数据库版本号

@interface SQLiteHelper ()

@property (nonatomic ,strong ,readwrite) FMDatabaseQueue *dbQueue;

// 用户文档根目录
@property (nonatomic, strong, readonly) NSString *applicationDocumentsDirecory;
// 数据库保存的文件目录
@property (nonatomic, strong, readonly) NSURL *storeURL;
// 数据库目录
@property (nonatomic, strong, readonly) NSURL *applicationStoresDirectory;
// 获取当前正在使用中的db版本
@property (nonatomic, assign, readonly) int currentDBVersion;

// 初始化
- (void)p_setup;
// 设置数据库版本号
- (void)p_setDBToVersion:(int)newVersion;

@end

@implementation SQLiteHelper

/**
 *  单例
 *
 *  @return 数据库帮助实例
 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SQLiteHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
    });
    return helper;
}

- (instancetype)init {
   return [super init];
}

- (void)setup {
    [self p_setup];
}

// 初始化
- (void)p_setup {
    NSString *storeDBPath = self.storeURL.path;
    if (!storeDBPath) {
        NSLog(@"创建数据库路径失败");
        return;
    }
    NSLog(@"数据库路径: %@", storeDBPath);
    
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:storeDBPath];
    
    // 创建或升级数据库
    // 创建或更新数据库表结构
    [self createOrUpgradeDBTablesWithOldVersion:self.currentDBVersion];
    
    if (self.currentDBVersion < PPDBVersion) {
        [self p_setDBToVersion:PPDBVersion];
    }
}

- (void)createOrUpgradeDBTablesWithOldVersion:(int)oldVersion {
    // 子类实现
    [NSException raise:NSGenericException
                format:@"必须实现createOrUpgradeDBTablesWithOldVersion:方法"];
}

// 设置当前数据库版本号
- (void)p_setDBToVersion:(int)newVersion {
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %d", newVersion];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
}

/**
 *  返回当前数据库文件版本号
 *
 *  @return 数据库版本号 1
 */
- (int)currentDBVersion {
    NSString *sql = @"PRAGMA user_version";
    
    __block int result;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        NSError *error;
        [rs nextWithError:&error];
        if (!rs) {
            NSLog(@"查询当前使用DB版本发生错误: error: %@", error);
            result = kNotFoundDBVersion;
        } else {
            result = [rs intForColumn:@"user_version"];
        }
        [rs close];
    }];
    return result;
}

#pragma mark - PATHs

/**
 *  数据库文件完整路径
 *
 *  @return 数据库文件完整路径
 */
- (NSURL *)storeURL {
    NSURL *storeURL = self.applicationStoresDirectory;
    if (!storeURL) {
        return nil;
    }
    return [self.applicationStoresDirectory URLByAppendingPathComponent:kdbName];
}

/**
 *  创建数据库所在的目录
 *
 *  @return 数据库文件所在的目录
 */
- (NSURL *)applicationStoresDirectory {
    NSURL *storesDirectory = [[NSURL fileURLWithPath:self.applicationDocumentsDirecory]
                                URLByAppendingPathComponent:kStoreDirectory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:storesDirectory.path]) {
        NSError *error;
        if (![fileManager createDirectoryAtURL:storesDirectory
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:&error]) {
            NSLog(@"创建数据库目录失败: error : %@", error);
            return nil;
        }
    }
    return storesDirectory;
}

/**
 *  返回App主目录
 *
 *  @return 返回App主目录
 */
- (NSString *)applicationDocumentsDirecory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

@end
