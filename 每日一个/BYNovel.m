//
//  BYNovel.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYNovel.h"

@implementation BYNovel

+ (instancetype)novelWithDict:(NSDictionary *)dict
{
    BYNovel *novel = [[BYNovel alloc ] init];
    
    novel.novel_id = [dict[@"id"] integerValue];
    
    novel.type = [dict[@"type"] integerValue];
    
    novel.publishtime= [dict[@"publishtime"] integerValue];
    
    novel.title = dict[@"title"];
    
    novel.summary = dict[@"summary"];
    
    return novel;
}

@end
