//
//  BYHttpTool.h
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYHttpTool : NSObject

+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void(^)(NSError *error))failure ;


/**
 *  判断当前是否有网络
 *
 *  @return <#return value description#>
 */
+ (BOOL)currentHttpStatus;


@end
