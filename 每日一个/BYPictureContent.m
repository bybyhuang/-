//
//  BYPictureContent.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYPictureContent.h"

@implementation BYPictureContent


+ (instancetype)pictureContentWithDict:(NSDictionary *)dict
{
    BYPictureContent *content = [[BYPictureContent alloc] init];
    
    content.picture_id = [dict[@"id"] integerValue];
    content.title =  dict[@"title"];
    content.author =  dict[@"author"];
    content.authorbrief =  dict[@"authorbrief"];
    content.times = [dict[@"times"] integerValue];
    content.publishtime = [dict[@"publishtime"] integerValue];
    
    content.text1 = dict[@"text1"];
    content.text2 = dict[@"text2"];
    content.image1 = dict[@"image1"];
    
    
    return content;
    
}
@end
