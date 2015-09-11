//
//  BYNovelList.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYNovelList.h"
#import "BYNovelView.h"

@interface BYNovelList()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;
@end

@implementation BYNovelList

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor redColor];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //设置分页功能
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        scrollView.delegate = self;
    
        
    }
    return self;
    
}

- (void)setNovels:(NSArray *)novels
{
    _novels = novels;
    
    for (int i=0; i<novels.count; i++) {
        BYNovelView *novelView = [[BYNovelView alloc] init];
        novelView.backgroundColor = RandomRGB;
        [self.scrollView addSubview:novelView];
        
        //让第一个文章的View先加载数据
        if(i==0)
        {
            novelView.novel = novels[i];
        }
        
    }
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    NSInteger count = self.novels.count;
    for (int i=0;i<count;i++) {
        BYNovelView *novelView = [self.scrollView subviews][i];
        novelView.x = self.scrollView.width * i;
        novelView.y = 0;
        novelView.height = self.scrollView.height;
        novelView.width = self.scrollView.width;
        
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * count, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (scrollView.contentOffset.x +scrollView.width / 2) /scrollView.width;
    if(scrollView.subviews.count>0)
    {
        //判断当前切换的NovelView的novel是否为空
        BYNovelView *novelView = scrollView.subviews[currentPage];
        if(novelView.novel == nil)
        {
            novelView.novel = self.novels[currentPage];
        }
        
    }
    
}
@end
