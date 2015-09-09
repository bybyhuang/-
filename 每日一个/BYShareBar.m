//
//  BYShareBar.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/14.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYShareBar.h"
#import "BYCriticContent.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BYShareBar()

@property (nonatomic,weak)UILabel *timeLabel;

@property (nonatomic,weak)UIView *grayLine;

@property (nonatomic,weak)UIButton *moreBtn;
@end

@implementation BYShareBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        //添加时间的label
        [self setUpTimeLabel];
        
        //添加一条分割线
        [self setUpGrayLine];
        
        [self setUpMoreBtn];
    }
    return self;
}

/**
 *  添加显示时间的label
 */
- (void)setUpTimeLabel
{
    UILabel *timeLable = [[UILabel alloc] init];
    [self addSubview:timeLable];
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.textColor = [UIColor grayColor];
//    timeLable.backgroundColor = [UIColor redColor];
    self.timeLabel = timeLable;
}

/**
 *  添加一条灰色分割线
 */
- (void)setUpGrayLine
{
    UIView *grayLine = [[UIView alloc] init];
    grayLine.backgroundColor = RGB(244, 244, 244);
    [self addSubview:grayLine];
    self.grayLine = grayLine;
}

- (void)setUpMoreBtn
{
    UIButton *moreBtn = [[UIButton alloc] init];
    [self addSubview:moreBtn];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"more_selected"] forState:UIControlStateHighlighted];
    moreBtn.size = moreBtn.currentImage.size;
    self.moreBtn = moreBtn;
}

- (void)setCriticContent:(BYCriticContent *)criticContent
{
    _criticContent = criticContent;
    
    NSLog(@"%ld",criticContent.publishtime -621355968000000000);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(criticContent.publishtime -621355968000000000)/10000000];
    NSString *timeString = [fmt stringFromDate:date];
    
    self.timeLabel.text = timeString;
    
    
    
    
}

- (void)layoutSubviews
{
    CGFloat margin = 10;
    
    self.timeLabel.x = margin;
    self.timeLabel.centerY = self.centerY;
    self.timeLabel.width = 100;
    self.timeLabel.height = 10;
    
    self.moreBtn.x = CGRectGetMaxX(self.frame) - margin - self.moreBtn.width;
    self.moreBtn.centerY = self.centerY;
    
    self.grayLine.x = margin;
    self.grayLine.y = CGRectGetMaxY(self.frame);
    self.grayLine.width = ScreenWidth - 2 * self.grayLine.x;
    self.grayLine.height = 1;
    
}
@end
