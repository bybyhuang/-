//
//  BYNovelContent.h
//  每日一个
//
//  Created by huangbaoyu on 15/9/10.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYNovelContent : NSObject

/*
 "id": 10256,
 "title": "过着过着就好起来了",
 "author": "庄佳宝",
 "authorbrief": "个人简介
 姓名 庄佳宝 十个投稿人",
 "times": 7764,
 "summary": "其实大家日子都过得差不多，谈过几场以遗憾收场的恋爱， 错付过几次感情与时间，最后勇气都被碾压成胆怯和躲闪，渴望与畏惧搅和在一块儿，变成“一个人过”的强有力说词。",
 "text": "
 
 
 "publishtime": 635772672000000000,
 */

@property (nonatomic,assign) NSInteger novel_id;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *author;

@property (nonatomic,copy) NSString *authorbrief;

@property (nonatomic,assign) NSInteger times;

@property (nonatomic,copy) NSString *summary;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,assign) NSInteger publishtime;

+ (instancetype)novelContentWithDict:(NSDictionary *)dict;

@end





