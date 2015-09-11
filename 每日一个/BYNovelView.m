//
//  BYNovelView.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYNovelView.h"
#import "BYNovel.h"
#import "BYHttpTool.h"
#import "BYNovelContent.h"
#import "NSString+Extension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BYNovelView()

@property (nonatomic,strong)BYNovelContent *novelContent;

/**
 *  一篇文章的，就是在一个ScrollView上的
 */
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIView *shareBar;

@property (nonatomic,strong)UILabel *title;

@property (nonatomic,strong)UILabel *authorAndTimes;

@end

@implementation BYNovelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //添加一个滚动栏
        [self setUpScrollView];
        
        //添加分享栏
        [self setUpShareBar];
        
        //添加标题栏
        [self setUpTitle];
        
        //添加作者和阅读量
        [self setUpAuthorAndTimes];
    }
    return self;
    
}

/**
 *  添加scrollView
 */
- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    //显示垂直的滚动条
    scrollView.showsVerticalScrollIndicator = YES;
    
}

/**
 *  添加分享按钮
 */
- (void)setUpShareBar
{
    UIView *view = [[UIView alloc] init];
    [self.scrollView addSubview:view];
    self.shareBar = view;
    view.width = ScreenWidth;
    view.height = 50;
    
    view.backgroundColor = [UIColor redColor];
    
    
    
}

/**
 *  添加标题
 */
- (void)setUpTitle
{
    UILabel *label = [[UILabel alloc] init];
    [self.scrollView addSubview:label];
    self.title = label;
    label.numberOfLines = 0;
    
}

/**
 *  添加标题和阅读量
 */
- (void)setUpAuthorAndTimes
{
    UILabel *label = [[UILabel alloc] init];
    [self.scrollView addSubview:label];
    label.numberOfLines = 0;
    self.authorAndTimes = label;
    
}

/**
 *  加载文章详细数据
 *
 *  @param novel <#novel description#>
 */
- (void)setNovel:(BYNovel *)novel
{
    
    
    _novel = novel;
    
    NSString *urlString = @"http://api.shigeten.net/api/Novel/GetNovelContent";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"id"] = [NSNumber numberWithInteger:novel.novel_id];
    
    
    
    [BYHttpTool GET:urlString parameters:parame success:^(id response) {
        
        BYNovelContent *novelContent = [BYNovelContent novelContentWithDict:response];
        self.novelContent = novelContent;
        
        //设置标题的文字和宽高
        self.title.text = novelContent.title;
        self.title.font = [UIFont boldSystemFontOfSize:25];
        //根据文字来获取文字的宽高
        CGSize titleSize = [novelContent.title sizeWithTextFont:self.title.font Size:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
        self.title.size = titleSize;
        
        
        //设置作者和阅读量
        NSString *authorAndTimes = [NSString stringWithFormat:@"作者:%@ | 阅读量:%ld",novelContent.author,novelContent.times];
        self.authorAndTimes.text = authorAndTimes;
        self.authorAndTimes.font = [UIFont systemFontOfSize:12] ;
        CGSize authorSize = [authorAndTimes sizeWithTextFont:self.authorAndTimes.font Size:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
        self.authorAndTimes.size = authorSize;
        
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(0, 1900);
    //设置
    self.shareBar.x = 0;
    self.shareBar.y = 0;;
    
    self.title.x =  15;
    self.title.y = CGRectGetMaxY(self.shareBar.frame) + 10;
    
    self.authorAndTimes.x = 15;
    self.authorAndTimes.y = CGRectGetMaxY(self.title.frame) +20;
}
@end
