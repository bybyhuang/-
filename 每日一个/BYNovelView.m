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
#import "BYShareBar.h"
#import "BYAfterBar.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BYNovelView()

@property (nonatomic,strong)BYNovelContent *novelContent;

/**
 *  一篇文章的，就是在一个ScrollView上的
 */
@property (nonatomic,strong)UIScrollView *scrollView;

/**
 *  分享栏
 */
@property (nonatomic,strong)BYShareBar *shareBar;

@property (nonatomic,strong)UILabel *title;

@property (nonatomic,strong)UILabel *authorAndTimes;

/**
 描述View
 */

@property (nonatomic,strong)UIView *summaryView;

/**
 文章内容
 */
@property (nonatomic,strong)UITextView *textView;

/**
 作者详情栏
 */
@property (nonatomic,strong)BYAfterBar *afterBar;

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
        
        //添加描述
        [self setUpSummaryView];
        
        //添加文章内容
        [self setUpText];
        
        //添加作者详情栏
        [self setUpAfterBar];
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
    BYShareBar *shareBar = [[BYShareBar alloc] init];
    
    [self.scrollView addSubview:shareBar];
    self.shareBar = shareBar;
    shareBar.width = ScreenWidth;
    shareBar.height = 50;
    
    
    
    
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
 *  添加描述view
 */
- (void)setUpSummaryView
{
    UIView *view = [[UIView alloc] init];
    [self.scrollView addSubview:view];
    self.summaryView = view;
    view.backgroundColor = RGB(244, 244, 244);
}

/**
 *  添加显示文章的TextView
 */
- (void)setUpText
{
    UITextView *text = [[UITextView alloc] init];
    [self.scrollView addSubview:text];
    self.textView = text;
    //设置textView不能编辑
    self.textView.editable = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    //设置不能滚动
    self.textView.scrollEnabled =NO;
}


- (void)setUpAfterBar
{
    BYAfterBar *afterBar = [[BYAfterBar alloc] init];
    [self.scrollView addSubview:afterBar];
    self.afterBar = afterBar;
    afterBar.width = ScreenWidth;
    afterBar.height = 50;
    
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
        
        
        //把发行日期传给分享栏
        self.shareBar.publishtime = novelContent.publishtime;
        
        //把文章内容传给作者详情栏
        self.afterBar.novelContent = novelContent;
        
        
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
        self.authorAndTimes.textColor = [UIColor grayColor];
        
        
        
        //设置summary的宽高
        
        
        
        
        //把引号放进summary的view中
        UIImageView *summaryRight= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"summary_right"]];
        [self.summaryView addSubview:summaryRight];
        
        UIImageView *summaryLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"summary_left"]];
        [self.summaryView addSubview:summaryLeft];
        
        
        //设置summary详情
        void(^setsummaryView)()=^()
        {
            //设置斜体
            CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
            
            UIFontDescriptor *desc =[UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:15].fontName matrix:matrix];
            UIFont *font = [UIFont fontWithDescriptor:desc size:15];
            //设置斜体
            
            
            UILabel *summaryText = [[UILabel alloc] init];
            //设置label的颜色
            summaryText.textColor = RGB(50, 50, 50);
            summaryText.numberOfLines = 0;
            [self.summaryView addSubview:summaryText];
            summaryText.text = novelContent.summary;
            summaryText.font = font;
            //获取textView的宽高
            CGSize summaryTextSize = [summaryText sizeThatFits:CGSizeMake(ScreenWidth - 30 -2*summaryLeft.width, MAXFLOAT)];
            
            
            //通过summaryText的宽高来设置summaryView的Size
            CGSize summarySize = CGSizeMake(ScreenWidth- 30, summaryTextSize.height + 2*summaryLeft.height);
            self.summaryView.size = summarySize;
            
            summaryText.size = summaryTextSize;
        };
        
        setsummaryView();
        
        
        //设置文章的具体内容
//        NSLog(@"%@",novelContent.text);
        self.textView.text = novelContent.text;
        self.textView.font = [UIFont systemFontOfSize:18];
        self.textView.textColor = [UIColor blackColor];
        CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
        
        self.textView.size = textViewSize;
        
        
        
        //重新进行布局
        [self setNeedsLayout];
        
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
    
    //设置
    self.shareBar.x = 0;
    self.shareBar.y = 0;;
    
    self.title.x =  15;
    self.title.y = CGRectGetMaxY(self.shareBar.frame) + 10;
    
    self.authorAndTimes.x = 15;
    self.authorAndTimes.y = CGRectGetMaxY(self.title.frame) +10;
    
    self.summaryView.x = 15;
    self.summaryView.y = CGRectGetMaxY(self.authorAndTimes.frame) + 15;
    
    if(self.summaryView.subviews.count>0)
    {
        UIImageView *summaryRight = self.summaryView.subviews[0];
        
        NSLog(@"%f",CGRectGetMaxY(self.summaryView.frame));
        //减15是因为summaryView的x是从15开始的
        summaryRight.x = CGRectGetMaxX(self.summaryView.frame) - summaryRight.width - 15;
        summaryRight.y = self.summaryView.height - summaryRight.height;
        
        
        UILabel *summaryText = self.summaryView.subviews[2];
        summaryText.x = summaryRight.width;
        summaryText.y = summaryRight.height;
        
    }
    
    self.textView.x = 15;
    self.textView.y = CGRectGetMaxY(self.summaryView.frame)+15;
    
    self.afterBar.x = 0;
    self.afterBar.y = CGRectGetMaxY(self.textView.frame) + 15;
    
    //设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.afterBar.frame)+128);
}
@end
