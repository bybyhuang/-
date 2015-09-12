//
//  BYPictureList.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/11.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYPictureList.h"
#import "BYPictureView.h"

@interface BYPictureList()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;

@end

@implementation BYPictureList

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //设置当前的view为scroll的代理
        scrollView.delegate = self;
        //设置不显示滚动栏
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        //设置分页
        scrollView.pagingEnabled = YES;
        
        
        
    }
    return self;
}


- (void)setPictureArray:(NSArray *)pictureArray
{
    _pictureArray = pictureArray;
    for(int i =0;i<pictureArray.count;i++)
    {
        BYPictureView *pictureView = [[BYPictureView alloc] init];
//        pictureView.backgroundColor = RandomRGB;
        [self.scrollView addSubview:pictureView];
        
        if(i == 0)
        {
            pictureView.picture = pictureArray[i];
            
        }
    }
    
    //需要重新计算子控件的位置
    [self setNeedsLayout];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    NSInteger count = self.pictureArray.count;
    
    //遍历ScrollView的子控件
    for(int i =0;i<count;i++)
    {
        BYPictureView *pictureView = self.scrollView.subviews[i];
        pictureView.x = i *self.scrollView.width;
        pictureView.y = 0;
        pictureView.width = self.scrollView.width;
        pictureView.height = self.scrollView.height;
    }
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * count, 0);
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (scrollView.contentOffset.x +scrollView.width / 2) / scrollView.width;
    if(scrollView.subviews.count>0 && currentPage>= 0 )
    {
        BYPictureView *pictureView = scrollView.subviews[currentPage];
        
        if(pictureView.picture == nil)
        {
            pictureView.picture = self.pictureArray[currentPage];
            
        }
    }
}

@end
