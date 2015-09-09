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

@interface FilmViewController ()

@property (nonatomic,strong)NSMutableArray *critics;

@property (nonatomic,weak)BYCriticList *listView;
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
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取出错");
    }];
    

}

- (void)setUpListView
{
    NSLog(@"%f", self.navigationItem.titleView.height);
    
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
