//
//  DatabaseManager.h
//  DatebasePackage
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

/**
 *  单例对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)databaseManager;

/**
 *  插入数据
 *
 *  @param object <#object description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)insertObjectToDatabaseWithObject:(id)object;

/**
 *  查询所有的数据
 *
 *  @param cls <#cls description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)queryAllObjectsFromDatabaseWithClass:(Class)cls;

/**
 *  删除指定表的数据
 *
 *  @return <#return value description#>
 */
- (BOOL)deleteAllObjectsFromDatabaseWithClass:(Class)cls;


@end
