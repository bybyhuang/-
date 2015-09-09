//
//  NSString+Extension.m
//  BY新浪微博
//
//  Created by huangbaoyu on 15/7/22.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 * 算出字符串所占的宽高
 */
- (CGSize)sizeWithTextFont:(UIFont *)font Size:(CGSize)size
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (CGSize)sizeWithTextFont:(UIFont *)font
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    return [self sizeWithAttributes:dict];
}
@end
