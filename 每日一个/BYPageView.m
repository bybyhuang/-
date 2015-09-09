//
//  BYPageView.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYPageView.h"
#import "AFNetworking.h"
#import "BYCritic.h"
#import "BYCriticContent.h"
#import "UIImageView+WebCache.h"


@interface BYPageView()

@property (nonatomic,weak)UITextView *textView;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation BYPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        UITextView *textView = [[UITextView alloc] init];
//        textView.backgroundColor = [UIColor whiteColor];
//        textView.text = @"1231231212";
//        [self addSubview:textView];
//        textView.editable = NO;
//        self.textView = textView;
//        [self addScrollView];
//        [self addTextAttributedLable];
        
        UITextView *textView = [[UITextView alloc]init];
        [self addSubview:textView];
        textView.editable = NO;
        self.textView = textView;
        
//        self.textView.contentOffset
        
        
        
    }
    return self;
}

- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollView;
}
- (void)addTextAttributedLable
{
//    TYAttributedLabel *label = [[TYAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, 0)];
//    [self.scrollView addSubview:label];
//    self.label = label;

    
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
        
        
//        NSLog(@"%@",content.text1);
//        self.textView.text = [NSString stringWithFormat:@"%@%@%@%@%@",content.text1,content.text2,content.text3,content.text4,content.text5];
        
//        NSLog(@"%ld",content.publishtime -621355968000000000);
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(content.publishtime -621355968000000000)/10000000];
//        
//        NSLog(@"%@",date);
        
        //拿到textView的attributetext
        
        NSMutableAttributedString *criticContent = [[NSMutableAttributedString alloc] init];
        
        NSTextAttachment *image1Attachment = [[NSTextAttachment alloc] init];
        
        NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:image1Attachment];
        
        NSAttributedString *text1 = [self attributedStringWithString:[NSString stringWithFormat:@"\n\t%@\n",content.text1]];
        NSAttributedString *text2 = [self attributedStringWithString:[NSString stringWithFormat:@"\n\t%@\n",content.text2]];
        NSAttributedString *text3 = [self attributedStringWithString:[NSString stringWithFormat:@"\n\t%@\n",content.text3]];
        NSAttributedString *text4 = [self attributedStringWithString:[NSString stringWithFormat:@"\n\t%@\n",content.text4]];
        NSAttributedString *text5 = [self attributedStringWithString:[NSString stringWithFormat:@"\n\t%@\n",content.text5]];
        
        [self addImageView:content.imageforplay location:0];

        [self addImageView:content.image1 location:text1.length + 1];
        
        [self addImageView:content.image2 location:text1.length + text2.length + 1];
        
        
        
        
        [criticContent appendAttributedString:imageString];
        
        [criticContent appendAttributedString:text1];
        [criticContent appendAttributedString:imageString];
        [criticContent appendAttributedString:text2];
        [criticContent appendAttributedString:imageString];
        [criticContent appendAttributedString:text3];
        [criticContent appendAttributedString:imageString];
        [criticContent appendAttributedString:text4];
        [criticContent appendAttributedString:imageString];
        [criticContent appendAttributedString:text5];
        [criticContent appendAttributedString:imageString];
        
        self.textView.attributedText = criticContent;
       //        NSTextAttachment *attachment = [[NSTextAttachment alloc];

        
        
//        [self.lable appendView:view1];
//        
//        [self.lable sizeToFit];
        
        
//        [self.textView insertSubview:view1 atIndex:1000];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取详细内容出错");
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"pageView.x%f",self.y);
//    self.scrollView.x = 10;
//    self.scrollView.y = 0;
//    self.scrollView.height = self.height;
//    self.scrollView.width = self.width-20;
//
//    [self.label sizeToFit];
    
    self.textView.x = 10;
    self.textView.y = 0;
    self.textView.height = self.height;
    self.textView.width = self.width - 20;
    
}

- (NSAttributedString *)attributedStringWithString:(NSString *)string
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [text setAttributes:dict range:NSMakeRange(0, text.length)];
    
    return text;
}

- (NSAttributedString *)attributedStringWithTitle:(NSString *)title
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [text setAttributes:dict range:NSMakeRange(0, text.length)];
    
    return text;
}


/**
 *  添加UIimageview到textView上
 */
- (UIImageView *)addImageView:(NSString *)imageUrl location:(NSInteger)location
{
    UIImageView *imageView= [[UIImageView alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"http://api.shigeten.net/%@",imageUrl];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //重新创建一个新的附件
        NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
        
        
        imageAttachment.bounds = CGRectMake(0, 0, self.textView.width, image.size.height * (self.textView.width / image.size.width));
        imageAttachment.image = image;
        
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        
        [attributed replaceCharactersInRange:NSMakeRange(location, 1) withAttributedString:[NSAttributedString attributedStringWithAttachment:imageAttachment]];
        self.textView.attributedText = attributed;
    }];
    [self.textView addSubview:imageView];
    
    return imageView;
}

@end
