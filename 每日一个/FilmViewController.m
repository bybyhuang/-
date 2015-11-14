//
//  FilmViewController.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "FilmViewController.h"
#import "AFNetworking.h"
#import "BYCritic.h"
#import "BYCriticList.h"
#import "Reachability.h"
#import "BYDataBaseTool.h"
#import "BYHttpTool.h"

@interface FilmViewController ()

@property (nonatomic,strong)NSMutableArray *critics;

@property (nonatomic,weak)BYCriticList *listView;

/**
 *  当离线的时候用这个
 */
@property (nonatomic,weak)NSArray *criticIdArray;
@end

@implementation FilmViewController

/**
 *  评论列表的懒加载
 */
- (NSMutableArray *)critics
{
    if(_critics == nil)
    {
        _critics = [NSMutableArray array];
    }
    return _critics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化listView
    [self setUpListView];
    
#warning 判断网络状态
//    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    
    
    //如果当前无网络连接
    if([BYHttpTool currentHttpStatus])
    {
        //就去数据库中取最大的10个critic
        
        NSArray *array = [BYDataBaseTool readMaxTenWithBYDataType:BYDataTypeFilm];
        for (NSDictionary *dict in array) {
            
            BYCritic *critic = [BYCritic criticWithDict:dict];
            [self.critics addObject:critic];
            
        }
        self.listView.critics = self.critics;
    }else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url = @"http://api.shigeten.net/api/Critic/GetCriticList";
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //        NSLog(@"%@",responseObject);
            //需要result数组的中所有字典，转换成模型再传到数组中
            for(NSDictionary *dict in responseObject[@"result"])
            {
                BYCritic *critic = [BYCritic criticWithDict:dict];
                [self.critics addObject:critic];
            }
            
            self.listView.critics = self.critics;
            
            //把模型存到
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取出错");
        }];
    }
    
    
    
    

}

- (void)setUpListView
{
//    NSLog(@"%f", self.navigationItem.titleView.height);
    
    BYCriticList *listView = [[BYCriticList alloc] init];
    listView.frame = self.view.bounds;
    [self.view addSubview:listView];
    self.listView = listView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
