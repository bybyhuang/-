//
//  BYCritic.h
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYCritic : NSObject

@property (nonatomic,assign) NSInteger critic_id;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) NSInteger publishtime;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *summary;

@property (nonatomic,strong) NSString *image;

+ (instancetype)criticWithDict:(NSDictionary *)dict;

@end
