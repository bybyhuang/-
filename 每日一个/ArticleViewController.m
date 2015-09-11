//
//  ArticleViewController.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "ArticleViewController.h"
#import "BYNovelList.h"
#import "BYNovel.h"
#import "BYHttpTool.h"


@interface ArticleViewController ()

@property (nonatomic,strong)NSMutableArray *novelArray;
@property (nonatomic,weak)BYNovelList *novelList;

@end

@implementation ArticleViewController


/**
 *  懒加载
 */
- (NSMutableArray *)novelArray
{
    if(_novelArray == nil)
    {
        _novelArray =[NSMutableArray array];
    }
    return _novelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化NovelList
    [self setUpNovelList];
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.shigeten.net/api/Novel/GetNovelList"];

    
    [BYHttpTool GET:urlString parameters:nil success:^(id response) {
        
        for (NSDictionary *dict in response[@"result"]) {
            
            BYNovel *novel = [BYNovel novelWithDict:dict];
            [self.novelArray addObject:novel];
        }
        
        //把获取到的文章数组传给NovelList
        self.novelList.novels = self.novelArray;
        
    } failure:^(NSError *error) {
       
        NSLog(@"%@",error);
    }];
   
    
    
    
}

- (void)setUpNovelList
{
    BYNovelList *novelList = [[BYNovelList alloc] init];
    
    [self.view addSubview:novelList];
    self.novelList = novelList;
    
    self.novelList.frame = self.view.frame;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
