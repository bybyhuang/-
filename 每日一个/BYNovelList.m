//
//  BYNovelList.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/9.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYNovelList.h"
#import "BYNovelView.h"

@interface BYNovelList()

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
        self.scrollView = scrollView ;
    
        
    }
    return self;
    
}

- (void)setNovels:(NSArray *)novels
{
    _novels = novels;
    
    for (int i=0; i<novels.count; i++) {
        BYNovelView *novelView = [[BYNovelView alloc] init];
        [self.scrollView addSubview:novelView];
        novelView.novel = novels[i];
        
        
    }
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    NSLog(@"%@",[self.scrollView subviews]);
}

@end
