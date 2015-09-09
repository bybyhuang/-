//
//  BYCriticContent.h
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYCriticContent : UIView

@property (nonatomic,assign) NSInteger critic_id;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *author;

@property (nonatomic,strong) NSString *authorbrief;

/**
 *  阅读量
 */
@property (nonatomic,assign) NSInteger times;
/**
 *  文本内容
 */
@property (nonatomic,strong) NSString *text1;
@property (nonatomic,strong) NSString *text2;
@property (nonatomic,strong) NSString *text3;
@property (nonatomic,strong) NSString *text4;
@property (nonatomic,strong) NSString *text5;

/**
 *  图片内容
 */
@property (nonatomic,strong) NSString *image1;
@property (nonatomic,strong) NSString *image2;
@property (nonatomic,strong) NSString *image3;
@property (nonatomic,strong) NSString *image4;
@property (nonatomic,strong) NSString *image5;
@property (nonatomic,copy) NSString *imageforplay;

@property (nonatomic,assign) NSInteger publishtime;

+ (instancetype)criticContentWithDict:(NSDictionary *)dict;
@end
