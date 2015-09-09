//
//  BYCriticContent.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYCriticContent.h"

@implementation BYCriticContent

+ (instancetype)criticContentWithDict:(NSDictionary *)dict
{
    BYCriticContent *content = [[BYCriticContent alloc] init];
    
    content.critic_id = [dict[@"id"] integerValue];
    
    content.title = dict[@"title"];
    
    content.author = dict[@"author"];
    
    content.authorbrief = dict[@"authorbrief"];
    
    content.times = [dict[@"times"] integerValue];
    
    content.text1 = dict[@"text1"];
    
    content.text2 = dict[@"text2"];
    content.text3 = dict[@"text3"];
    content.text4 = dict[@"text4"];
    content.text5 = dict[@"text5"];
    
    content.image1 = dict[@"image1"];
    content.image2 = dict[@"image2"];
    content.image3 = dict[@"image3"];
    content.image4 = dict[@"image4"];
    content.image5 = dict[@"image5"];
    content.imageforplay = dict[@"imageforplay"];
    
    content.publishtime = [dict[@"publishtime"] integerValue];
    
    return content;
    
}

@end
