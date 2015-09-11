//
//  BYFilmView.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/14.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYFilmView.h"
#import "BYCritic.h"
#import "AFNetworking.h"
#import "BYCriticContent.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "BYShareBar.h"
#import "BYAfterBar.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BYFilmView()

@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)BYShareBar *shareBar;
@property (nonatomic,weak)BYAfterBar *afterBar;
@property (nonatomic,weak)UIImageView *FirstImageView;
@property (nonatomic,weak)UILabel *title;

@property (nonatomic,weak)UILabel *authorAndTimes;

@property (nonatomic,weak)UITextView *text1;
@property (nonatomic,weak)UITextView *text2;
@property (nonatomic,weak)UITextView *text3;
@property (nonatomic,weak)UITextView *text4;
@property (nonatomic,weak)UITextView *text5;

@property (nonatomic,weak)UIImageView *image1;
@property (nonatomic,weak)UIImageView *image2;
@property (nonatomic,weak)UIImageView *image3;
@property (nonatomic,weak)UIImageView *image4;
@property (nonatomic,weak)UIImageView *image5;
@end

@implementation BYFilmView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //添加scrollView
        [self setUpScrollView];
        
        //添加顶部时间分享栏
        [self setUpShareBar];
        
        //添加影评介绍图片
        self.FirstImageView = [self setUpImageView];
        
        //添加标题栏
        [self setUpTitle];
        
        //添加作者和阅读量
        [self setUpAuthorAndTimes];
        
        //添加第一个文本
        self.text1 = [self setUpText];
        self.text2 = [self setUpText];
        self.text3 = [self setUpText];
        self.text4 = [self setUpText];
        self.text5 = [self setUpText];
        //创建image1
        self.image1 =[self setUpImageView];
        self.image2 =[self setUpImageView];
        self.image3 =[self setUpImageView];
        self.image4 =[self setUpImageView];
        self.image5 =[self setUpImageView];
        
        //添加最后的作者栏
        [self setUpAfterBar];
        
        
        
    }
    return self;
}


/**
 *  初始化滚动界面
 */
- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
}

/**
 *  添加最后的显示作者，和作者详情的bar
 */
- (void)setUpAfterBar
{
    BYAfterBar *afterBar = [[BYAfterBar alloc] init];
    [self.scrollView addSubview:afterBar];
    self.afterBar = afterBar;
//    afterBar.backgroundColor = [UIColor redColor];
    afterBar.width = ScreenWidth;
    afterBar.height = 50;
}

/**
 *  添加分享栏
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
 *  添加第一个影片宣传图
 */
- (UIImageView *)setUpImageView
{
    UIImageView *imageView =[[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    return imageView;
    
}

/**
 *  添加标题
 */
- (void)setUpTitle
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    
    [self.scrollView addSubview:label];
    self.title = label;
}

/**
 *  添加作者和阅读量
 */
- (void)setUpAuthorAndTimes
{
    UILabel *label = [[UILabel alloc] init];
    [self.scrollView addSubview:label];
    label.numberOfLines = 0;
    self.authorAndTimes = label;
    
}

/**
 *  添加一个文本框到scrollview上
 *
 *  @return <#return value description#>
 */
- (UITextView *)setUpText
{
    UITextView *textView = [[UITextView alloc] init];
    [self.scrollView addSubview:textView];
    textView.showsHorizontalScrollIndicator = NO;
    textView.showsVerticalScrollIndicator = NO;
    textView.editable = NO;
    textView.scrollEnabled = NO;
//    label.hidden = YES;
//    label.numberOfLines = 0;
    return textView;
    
}




- (void)setCritic:(BYCritic *)critic
{
    _critic = critic;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = @"http://api.shigeten.net/api/Critic/GetCriticContent";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = [NSNumber numberWithInteger:critic.critic_id];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //转换成模型
        BYCriticContent *content = [BYCriticContent criticContentWithDict:responseObject];
        
        //把模型传给分享栏
        self.shareBar.criticContent = content;
        
        //把模型传给作者详情栏
        self.afterBar.criticContent = content;
        
        //通过SDWEBimage获得图片，并设置UIimageView的宽高
        if(content.imageforplay.length>0)
        [self setImageView:self.FirstImageView url:content.imageforplay];
        
        if(content.image1.length>0)
        [self setImageView:self.image1 url:content.image1];
        
        if(content.image2.length>0)
        [self setImageView:self.image2 url:content.image2];
        
        if(content.image3.length>0)
        [self setImageView:self.image3 url:content.image3];
        
        if(content.image4.length>0)
        [self setImageView:self.image4 url:content.image4];
        
        if(content.image5.length>0)
        [self setImageView:self.image5 url:content.image5];
        
        //初始化标题
        CGSize titleSize = [content.title sizeWithTextFont:[UIFont boldSystemFontOfSize:25] Size:CGSizeMake(ScreenWidth - 20, CGFLOAT_MAX)];
        self.title.font = [UIFont boldSystemFontOfSize:25];
        self.title.text = content.title;
        self.title.size = titleSize;
        
        
        //设置啊作者的数据
        NSString *authorString = [NSString stringWithFormat:@"作者:%@  |  阅读量:%ld",content.author,content.times];
        CGSize authorSize = [authorString sizeWithTextFont:[UIFont systemFontOfSize:12] Size:CGSizeMake(ScreenWidth - 20, CGFLOAT_MAX)];
        self.authorAndTimes.font= [UIFont systemFontOfSize:12];
        self.authorAndTimes.textColor = [UIColor grayColor];
        self.authorAndTimes.text = authorString;
        self.authorAndTimes.size = authorSize;
        
        
        //设置第一段文章
        [self setTextView:self.text1 text:content.text1];
        [self setTextView:self.text2 text:content.text2];
        [self setTextView:self.text3 text:content.text3];
        [self setTextView:self.text4 text:content.text4];
        [self setTextView:self.text5 text:content.text5];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取详细内容出错");
    }];
}

/**
 *  加载图片，并设置imageView的宽高
 *
 *  @param imageView      设置的imagView
 *  @param imageUrlString 图片后面的url
 */
- (void)setImageView:(UIImageView *)imageView url:(NSString *)imageUrlString
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.shigeten.net/%@",imageUrlString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat width = ScreenWidth - 20;
        CGFloat height = image.size.height * (width / image.size.width);
        
        imageView.width = width;
        imageView.height = height;
        [self setNeedsLayout];
    }];
}


/**
 *  设置textView内容并通过字数来设置宽高
 *
 *  @param label <#label description#>
 *  @param text  <#text description#>
 */
- (void)setTextView:(UITextView *)textView text:(NSString *)text
{
    UIFont *textFont = [UIFont systemFontOfSize:18];
    CGSize labelBoundSize = CGSizeMake(ScreenWidth - 30, CGFLOAT_MAX);
    
    textView.font = textFont;
    textView.text = text;
    
    CGSize textSize = [textView sizeThatFits:labelBoundSize];
    textView.size = textSize;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    self.scrollView.frame = self.bounds;
    
    self.FirstImageView.x = 10;
    self.FirstImageView.y = CGRectGetMaxY(self.shareBar.frame)+10;
    
    self.title.x = 10;
    self.title.y = CGRectGetMaxY(self.FirstImageView.frame)+15;
    
    self.authorAndTimes.x = 10;
    self.authorAndTimes.y = CGRectGetMaxY(self.title.frame)+10;
    
    self.text1.x = 15;
    self.text1.y = CGRectGetMaxY(self.authorAndTimes.frame)+20;
    
    self.image1.x = 10;
    self.image1.y = CGRectGetMaxY(self.text1.frame)+10;
    
    self.text2.x = 15;
    self.text2.y = CGRectGetMaxY(self.image1.frame)+20;
    
    self.image2.x = 10;
    self.image2.y = CGRectGetMaxY(self.text2.frame)+10;
    
    
    
    
    
    
    
    self.text3.x = 15;
    self.text3.y = CGRectGetMaxY(self.image2.frame)+20;
    
    self.image3.x = 10;
    self.image3.y = CGRectGetMaxY(self.text3.frame)+10;
    
    self.text4.x = 15;
    self.text4.y = CGRectGetMaxY(self.image3.frame)+20;
    
    self.image4.x = 10;
    self.image4.y = CGRectGetMaxY(self.text4.frame)+10;
    
    self.text5.x = 15;
    self.text5.y = CGRectGetMaxY(self.image4.frame)+20;
    
    self.image5.x = 10;
    self.image5.y = CGRectGetMaxY(self.text5.frame)+10;
    
    
    self.afterBar.x = 0;
    self.afterBar.y = CGRectGetMaxY(self.image5.frame)+10;
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.afterBar.frame) + 128);
    
}

/**
 *  转换文字格式
 *
 *  @param title <#title description#>
 *
 *  @return <#return value description#>
 */
- (NSAttributedString *)attributedStringWithTitle:(NSString *)title
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [text setAttributes:dict range:NSMakeRange(0, text.length)];
    
    return text;
}
@end
