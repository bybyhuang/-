//
//  BYDataBaseTool.h
//  每日一个
//
//  Created by huangbaoyu on 15/11/3.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    BYDataTypeFilm,    //影评
    BYDataTypeArticle, //文章
    BYDataTypePicture  //图片
}BYDataType;


@interface BYDataBaseTool : NSObject



/**
 *  存储数据
 *
 *  @param dict     <#dict description#>
 *  @param criticId <#criticId description#>
 */
+ (void)saveDataWithDictonary:(NSDictionary *)dict criticId:(NSInteger)criticId andBYDataType:(BYDataType)dataType ;


+(NSDictionary *)readFilmDataWithCriticId:(NSInteger)criticId andBYDataType:(BYDataType)dataType;

@end
