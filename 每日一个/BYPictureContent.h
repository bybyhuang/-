//
//  BYPictureContent.h
//  每日一个
//
//  Created by huangbaoyu on 15/9/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYPictureContent : NSObject

/*
 
 "id": 10260,
 "title": "细水长流的把你宠坏",
 "author": "Nidhi Chanani",
 "authorbrief": "来自画家Nidhi Chanani",
 "text1": "过去是我们给自己下的定义。我们有很好的理由去努力摆脱它，或是摆脱它的阴影，但摆脱它的唯一途径是添以更美之景。",
 "image1": "images/B5D7082D61B2884D477B297A703643AF.jpg",
 "text2": "—温德尔·贝瑞(美国诗人)",
 "times": 10808,
 "publishtime": 635768352000000000,
 "status": 0,
 "errMsg": null

 */
@property (nonatomic,assign) NSInteger picture_id;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *author;

@property (nonatomic,copy) NSString *authorbrief;

@property (nonatomic,assign) NSInteger times;


@property (nonatomic,copy) NSString *text1;

@property (nonatomic,copy) NSString *image1;

@property (nonatomic,copy) NSString *text2;

@property (nonatomic,assign) NSInteger publishtime;


+ (instancetype)pictureContentWithDict:(NSDictionary *)dict;

@end
