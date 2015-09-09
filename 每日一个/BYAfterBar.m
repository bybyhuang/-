//
//  BYAfterBar.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/14.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYAfterBar.h"
#import "BYCriticContent.h"
#import "NSString+Extension.h"

#define Margin 10

@interface BYAfterBar()

@property (nonatomic,weak)UIView *grayLine;

@property (nonatomic,weak)UILabel *author;

@property (nonatomic,weak)UILabel *authorBrief;

@end

@implementation BYAfterBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setUpGrayLine];
        [self setUpAuthorLabel];
        [self setUpAuthorBrief];
    }
    
    return self;
}


/**
 *  传入模型数据，并且给控件赋值
 *
 *  @param criticContent <#criticContent description#>
 */
- (void)setCriticContent:(BYCriticContent *)criticContent
{
    _criticContent = criticContent;
    self.author.text = criticContent.author;
    CGSize boundSize = CGSizeMake(self.width - 2 *Margin, CGFLOAT_MAX);
    CGSize authorSize = [criticContent.author sizeWithTextFont:self.author.font Size:boundSize];
    self.author.size = authorSize;
    
    
    self.authorBrief.text = criticContent.authorbrief;
    CGSize authorBriefSize = [criticContent.authorbrief sizeWithTextFont:self.authorBrief.font Size:boundSize];
    self.authorBrief.size = authorBriefSize;
    
    
    [self setNeedsLayout];
    
}

/**
 *  作者label
 */
- (void)setUpAuthorLabel
{
    UILabel *author = [[UILabel alloc] init];
    [self addSubview:author];
    author.font = [UIFont systemFontOfSize:14];
    
    self.author = author;
    
    
    
}

/**
 *  作者详情
 */
- (void)setUpAuthorBrief
{
    UILabel *authorBrief = [[UILabel alloc] init];
    [self addSubview:authorBrief];
    authorBrief.textColor = [UIColor grayColor];
    authorBrief.font = [UIFont systemFontOfSize:12];
    
    self.authorBrief = authorBrief;
}

/**
 *  灰色分割线
 */
- (void)setUpGrayLine
{
    UIView *grayLine = [[UIView alloc] init];
    grayLine.backgroundColor = RGB(244, 244, 244);
    [self addSubview:grayLine];
    self.grayLine = grayLine;
}

- (void)layoutSubviews
{
    
    self.grayLine.x = Margin;
    self.grayLine.y = 0;
    self.grayLine.width = self.width - 2 * self.grayLine.x;
    self.grayLine.height = 1;
    
    self.author.x = Margin;
    self.author.y = CGRectGetMaxY(self.grayLine.frame) +Margin ;
    
    self.authorBrief.x = Margin;
    self.authorBrief.y = CGRectGetMaxY(self.author.frame) + Margin /2;
    
    
}

@end
