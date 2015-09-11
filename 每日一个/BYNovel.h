//
//  BYNovel.h
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYNovel : NSObject


/*
 
 "id": 10257,
 "type": 2,
 "publishtime": 635773536000000000,
 "title": "共苦容易同甘难",
 "summary": "感谢作者投稿！",
 "image": ""
 
 */
@property (nonatomic,assign) NSInteger novel_id;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) NSInteger publishtime;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *summary;



+ (instancetype)novelWithDict:(NSDictionary *)dict;


@end




