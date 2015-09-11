//
//  BYNovelContent.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/10.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYNovelContent.h"

@implementation BYNovelContent


+ (instancetype)novelContentWithDict:(NSDictionary *)dict
{
    BYNovelContent *novelContent = [[BYNovelContent alloc] init];
    novelContent.novel_id = [dict[@"id"] integerValue];
    novelContent.title =  dict[@"title"];
    novelContent.author =  dict[@"author"];
    novelContent.authorbrief =  dict[@"authorbrief"];
    novelContent.summary =  dict[@"summary"];
    novelContent.text =  dict[@"text"];
    novelContent.times = [dict[@"times"] integerValue];
    novelContent.publishtime = [dict[@"publishtime"] integerValue];
    
    return novelContent;
    
}
@end
