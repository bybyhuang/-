//
//  BYHttpTool.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYHttpTool.h"
#import "AFNetworking.h"
#import "Reachability.h"

@implementation BYHttpTool

+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}


+ (BOOL)currentHttpStatus
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    return [reach currentReachabilityStatus] == NotReachable;
}

@end
