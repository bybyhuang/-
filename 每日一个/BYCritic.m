//
//  BYCritic.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYCritic.h"

@implementation BYCritic

+ (instancetype)criticWithDict:(NSDictionary *)dict
{
    BYCritic *critic = [[BYCritic alloc] init];
    
    critic.critic_id = [dict[@"id"] integerValue];
    critic.type = [dict[@"type"] integerValue];
    critic.title = dict[@"title"];
    critic.publishtime = [dict[@"publishtime"] integerValue];
    critic.summary = dict[@"summary"];
    critic.image = dict[@"image"];
    
    return critic;
    
}

@end
