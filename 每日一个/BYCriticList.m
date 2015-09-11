//
//  BYCriticList.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYCriticList.h"
#import "BYFilmView.h"


@interface BYCriticList()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;

@end

@implementation BYCriticList

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //添加一个ScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        scrollView.backgroundColor = [UIColor blackColor];
        //设置ScrollView有分页功能
//        scrollView.backgroundColor = RandomRGB;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
    
        scrollView.delegate = self;
        
        
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
    }
    return self;
}

- (void)setCritics:(NSArray *)critics
{
    _critics = critics;
    
    //获取到几个评论文章就添加几个UIview上去
    for (int i=0; i<critics.count; i++) {
        BYFilmView *filmView = [[BYFilmView alloc] init];
        
        if(i==0)
            filmView.critic = critics[0];
            
        //给pageView设置一个随机色
//        filmView.backgroundColor = RandomRGB;
//

        
        [self.scrollView addSubview:filmView];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.frame;
    
    NSInteger count = self.critics.count;
    
//    NSLog(@"count%ld",count);
    //设置scrollView可以滚动的宽高
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
    for(int i=0;i<count;i++)
    {
        BYFilmView *filmView = self.scrollView.subviews[i];
        filmView.x = i * self.scrollView.width ;
        filmView.y = 0;
        filmView.width = self.scrollView.width;
        filmView.height = self.scrollView.height;
        
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = ((scrollView.contentOffset.x +self.scrollView.width /2 )/self.scrollView.width);
    

    //根据页数来赋值模型
    if(self.scrollView.subviews.count>0)
    {
        BYFilmView *filmView = self.scrollView.subviews[currentPage];
        if(filmView.critic == nil)
        {
            filmView.critic = self.critics[currentPage];
        }
    }
    
    
    
    
}
@end
