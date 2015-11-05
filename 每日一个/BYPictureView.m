//
//  BYPictureView.m
//  每日一个
//
//  Created by huangbaoyu on 15/9/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYPictureView.h"
#import "BYHttpTool.h"
#import "BYNovel.h"
#import "BYPictureContent.h"
#import "BYShareBar.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "BYAfterBar.h"

#import "BYDataBaseTool.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BYPictureView()

@property (nonatomic,weak)UIScrollView *scrollView;

@property (nonatomic,weak)BYShareBar *shareBar;

@property (nonatomic,weak)UIImageView *imageView;

@property (nonatomic,weak)UILabel *introduction;

@property (nonatomic,weak)UILabel *authorLabel;

@property (nonatomic,weak)BYAfterBar *afterBar;

@end

@implementation BYPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //添加scrollView
        [self setUpScrollView];
        
        //添加分享栏
        [self setUpShareBar];
        
        //添加图片View
        [self setUpImageView];
        
        //添加详情label
        [self setUpIntroduction];
        
        //添加评论者
        [self setUpAuthor];
        
        //添加作者按钮
        [self setUpAfterBar];
    }
    return self;
}

- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  初始化分享栏
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
 *  初始化imageView
 */
- (void)setUpImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
}

/**
 *  介绍label
 */
- (void)setUpIntroduction
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [self.scrollView addSubview:label];
    self.introduction = label;
    
    
}

- (void)setUpAuthor
{
    UILabel *label = [[UILabel alloc] init];
    [self.scrollView addSubview:label];
    self.authorLabel = label;
    
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
 *  获取到id等时，再获取详细信息
 *
 *  @param picture <#picture description#>
 */
- (void)setPicture:(BYNovel *)picture
{
    _picture = picture;
    
    NSString *urlString = @"http://api.shigeten.net/api/Diagram/GetDiagramContent";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"id"] = [NSNumber numberWithInteger:picture.novel_id];
    
    //先判断图片表中是否有该id的数据
    NSDictionary *pictureData = [BYDataBaseTool readFilmDataWithCriticId:picture.novel_id andBYDataType:BYDataTypePicture];
    if(pictureData != nil)
    {
        BYPictureContent *pictureContent = [BYPictureContent pictureContentWithDict:pictureData];
        

        
        //把时间传给分享栏
        self.shareBar.publishtime = pictureContent.publishtime;
        
        //把作者，和作者详情传给afterBar
        self.afterBar.authorString = pictureContent.author;
        self.afterBar.authorBriefString = pictureContent.authorbrief;
        
        [self setImageView:self.imageView url:pictureContent.image1];
        
        
        self.introduction.text = pictureContent.text1;
        self.introduction.font = [UIFont systemFontOfSize:13];
        CGSize introductionSize = [self.introduction sizeThatFits:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
        self.introduction.size = introductionSize;
        
        //把作者赋值给authorLabel
        NSLog(@"text2=%@",pictureContent.text2);
        self.authorLabel.text = pictureContent.text2;
        self.authorLabel.font = [UIFont systemFontOfSize:13];
        CGSize authorSize = [self.authorLabel sizeThatFits:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
        self.authorLabel.size = authorSize;
        
        //        [self setNeedsLayout];
    }else
    {
        [BYHttpTool GET:urlString parameters:dict success:^(id response) {
            
            BYPictureContent *pictureContent = [BYPictureContent pictureContentWithDict:response];
            
#pragma mark - 存到数据库
            [BYDataBaseTool saveDataWithDictonary:response criticId:picture.novel_id andBYDataType:BYDataTypePicture];
            
            //把时间传给分享栏
            self.shareBar.publishtime = pictureContent.publishtime;
            
            //把作者，和作者详情传给afterBar
            self.afterBar.authorString = pictureContent.author;
            self.afterBar.authorBriefString = pictureContent.authorbrief;
            
            [self setImageView:self.imageView url:pictureContent.image1];
            
            
            self.introduction.text = pictureContent.text1;
            self.introduction.font = [UIFont systemFontOfSize:13];
            CGSize introductionSize = [self.introduction sizeThatFits:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
            self.introduction.size = introductionSize;
            
            //把作者赋值给authorLabel
            NSLog(@"text2=%@",pictureContent.text2);
            self.authorLabel.text = pictureContent.text2;
            self.authorLabel.font = [UIFont systemFontOfSize:13];
            CGSize authorSize = [self.authorLabel sizeThatFits:CGSizeMake(ScreenWidth - 30, MAXFLOAT)];
            self.authorLabel.size = authorSize;
            
            //        [self setNeedsLayout];
            
        } failure:^(NSError *error) {
            
        }];

    }
    
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



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.shareBar.x = 0;
    self.shareBar.y = 0;
    
    //设置imageView的位置
    self.imageView.x = 10;
    self.imageView.y = CGRectGetMaxY(self.shareBar.frame) + 15;
    
    self.introduction.x = 15;
    self.introduction.y = CGRectGetMaxY(self.imageView.frame) +15;
    
    //设置评论人的位置
    self.authorLabel.x = ScreenWidth - 15 -self.authorLabel.width;
    self.authorLabel.y = CGRectGetMaxY(self.introduction.frame) + 10;
    
    
    self.afterBar.x = 0;
    self.afterBar.y = CGRectGetMaxY(self.authorLabel.frame) + 15;
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.afterBar.frame) +128 );
}

@end
