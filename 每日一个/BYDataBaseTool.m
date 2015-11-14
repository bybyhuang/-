//
//  BYDataBaseTool.m
//  每日一个
//
//  Created by huangbaoyu on 15/11/3.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYDataBaseTool.h"
#import "FMDB.h"

@implementation BYDataBaseTool

static FMDatabase *db;

//创建这个对象的时候就会自动调用
+ (void)initialize
{
    
    //获取到document的路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataBasePath = [documentPath stringByAppendingPathComponent:@"oneDay.sqlite"];
    //在这里面调用数据库和创建表
    
    
    NSLog(@"%@",documentPath);
    
    db = [[FMDatabase alloc] initWithPath:dataBasePath];
    
    //打开数据库
    [db open];
    
    //创建电影表
    [db executeUpdateWithFormat:@"CREATE TABLE if not EXISTS film_statuse(id integer PRIMARY KEY autoincrement,data blob NOT NULL,critic_id integer NOT NULL);"];
    
    //创建文章表
    [db executeUpdateWithFormat:@"CREATE TABLE if not EXISTS article_statuse(id integer PRIMARY KEY autoincrement,data blob NOT NULL,novel_id integer NOT NULL);"];
    
    //创建图片表
    [db executeUpdateWithFormat:@"CREATE TABLE if not EXISTS picture_statuse(id integer PRIMARY KEY autoincrement,data blob NOT NULL,picture_id integer NOT NULL);"];
}



/**
 *  把影评数据缓存到数据库中
 *
 *  @param dict     从网络中获取到的数据
 *  @param criticId 文章的id
 */
+ (void)saveDataWithDictonary:(NSDictionary *)dict criticId:(NSInteger)criticId andBYDataType:(BYDataType)dataType
{

    //把字典转换成data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    
    
    //需要先进行判断存到哪个表中去
    switch (dataType) {
        case BYDataTypeFilm:
            
            [db executeUpdateWithFormat:@"INSERT INTO film_statuse(data,critic_id) VALUES(%@,%ld);",data,criticId];
            break;
        case BYDataTypeArticle:
            
            [db executeUpdateWithFormat:@"INSERT INTO article_statuse(data,novel_id) VALUES(%@,%ld);",data,criticId];
            break;
        case BYDataTypePicture:
            [db executeUpdateWithFormat:@"INSERT INTO picture_statuse(data,picture_id) VALUES(%@,%ld);",data,criticId];
            
            break;
        
            
        default:
            break;
    }
    
    
    
}






+ (NSDictionary *)readFilmDataWithCriticId:(NSInteger)criticId andBYDataType:(BYDataType)dataType
{
    
    NSString *sql;
    //需要先进行判断存到哪个表中去
    switch (dataType) {
        case BYDataTypeFilm:
            sql = [NSString stringWithFormat:@"SELECT *FROM film_statuse WHERE critic_id = %ld;",criticId];
            break;
        case BYDataTypeArticle:
            sql = [NSString stringWithFormat:@"SELECT *FROM article_statuse WHERE novel_id = %ld;",criticId];
            break;
        case BYDataTypePicture:
            sql = [NSString stringWithFormat:@"SELECT *FROM picture_statuse WHERE picture_id = %ld;",criticId];
            break;
            
            
        default:
            break;
    }
    
    //取出来的数据是一个结果集
    FMResultSet *resultSet = [db executeQuery:sql];
    
    //遍历结果集
    while (resultSet.next) {
        //先取出data的二进制数据
        NSData *data = [resultSet objectForColumnName:@"data"];
        
        //把二进制转化成字典,反归档
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        
        return dict;
    }
    
    
    return nil;
    
}


+ (NSArray *)readMaxTenWithBYDataType:(BYDataType)dataType
{
    NSString *sql;
    //需要先进行判断存到哪个表中去
    switch (dataType) {
        case BYDataTypeFilm:
            sql = [NSString stringWithFormat:@"SELECT *FROM film_statuse  desc limit 0,10;"];
            break;
        case BYDataTypeArticle:
            sql = [NSString stringWithFormat:@"SELECT *FROM article_statuse desc limit 0,10 ;"];
            break;
        case BYDataTypePicture:
            sql = [NSString stringWithFormat:@"SELECT *FROM picture_statuse desc limit 0,10;"];
            break;
            
            
        default:
            break;
    }
    
    //取出来的数据是一个结果集
    FMResultSet *resultSet = [db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray array];
    //遍历结果集
    while (resultSet.next) {
        //先取出data的二进制数据
        NSData *data = [resultSet objectForColumnName:@"data"];
        
        //把二进制转化成字典,反归档
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        
        [array addObject:dict];
    }
    
    
    return array;
}

@end
