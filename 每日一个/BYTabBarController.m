//
//  BYTabBarController.m
//  每日一个
//
//  Created by huangbaoyu on 15/8/12.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "BYTabBarController.h"
#import "FilmViewController.h"
#import "ArticleViewController.h"
#import "PictureViewController.h"
#import "AboutViewController.h"
#import "SimpleTextViewController.h"

@interface BYTabBarController ()

@end

@implementation BYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FilmViewController *filmController = [[FilmViewController alloc] init];
    ArticleViewController *articleController = [[ArticleViewController alloc] init];
    PictureViewController *pictureController = [[PictureViewController alloc] init];
    SimpleTextViewController *aboutController = [[AboutViewController alloc] init];
    
    
//    articleController.view.backgroundColor = [UIColor whiteColor];
    
    
    [UIImage imageNamed:@"home_personal"];
    [self addController:filmController title:@"影评" image:@"home_critic" selectImage:@"home_critic_focus"];
    [self addController:articleController title:@"文章" image:@"home_novel" selectImage:@"home_novel_focus"];
    [self addController:pictureController title:@"图片" image:@"home_diagram" selectImage:@"home_diagram_focus"];
    [self addController:aboutController title:@"关于" image:@"home_personal" selectImage:@"home_personal_focus"];
    
    
    
}

- (void)addController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    
//    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
//    controller.navigationItem.title = title;
    
    controller.title = title;
    
    //设置选中的图片，且不变蓝，保持原来的样式
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    NSMutableDictionary *normalColor = [NSMutableDictionary dictionary];
    normalColor[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectColor = [NSMutableDictionary dictionary];
    selectColor[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [controller.tabBarItem setTitleTextAttributes:normalColor forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:selectColor forState:UIControlStateSelected];
    
    
    //包装一个Nav在放到tabBar上
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self addChildViewController:nav];
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
