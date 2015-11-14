//
//  PictureViewController.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "PictureViewController.h"
#import "BYHttpTool.h"
#import "BYNovel.h"
#import "BYPictureList.h"
#import "BYDataBaseTool.h"

@interface PictureViewController ()

@property (nonatomic,weak)BYPictureList *pictureList;

@property (nonatomic,strong)NSMutableArray *pictureArray;
@end

@implementation PictureViewController


/**
 *  懒加载
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)pictureArray
{
    if(_pictureArray == nil)
    {
        _pictureArray = [[NSMutableArray alloc] init];
        
    }
    return _pictureArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化图片列表
    [self setUpPictureList];
    
    
    if([BYHttpTool currentHttpStatus])
    {
        NSArray *array = [BYDataBaseTool readMaxTenWithBYDataType:BYDataTypePicture];
        for (NSDictionary *dict in array) {
            BYNovel *novel = [BYNovel novelWithDict:dict];
            [self.pictureArray addObject:novel];
            
        }
        self.pictureList.pictureArray = self.pictureArray;
        
    }else
    {
        //http://api.shigeten.net/api/Diagram/GetDiagramList
        //http://api.shigeten.net/api/Diagram/GetDiagramContent?id=10260
        NSString *urlString = @"http://api.shigeten.net/api/Diagram/GetDiagramList";
        [BYHttpTool GET:urlString parameters:nil success:^(id response) {
            for (NSDictionary *dict in response[@"result"]) {
                BYNovel *novel = [BYNovel novelWithDict:dict];
                [self.pictureArray addObject:novel];
                
            }
            
            self.pictureList.pictureArray = self.pictureArray;
            
        } failure:^(NSError *error) {
            NSLog(@"获取出错");
        }];
    }
    
    
    
    
}

- (void)setUpPictureList
{
    BYPictureList *pictureList = [[BYPictureList alloc] init];
    [self.view addSubview:pictureList];
    self.pictureList = pictureList;
    pictureList.frame = self.view.bounds;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
