//
//  AboutViewController.m
//  每日一个
//
//  Created by huangbaoyu on 15/11/2.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutViewCell.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AboutViewCell *cell = [AboutViewCell abountViewCellWithTableView:tableView WithIdentifier:@"about"];
    [UIImage imageNamed:@"setting_aboutus"];
    switch (indexPath.row) {
        case 0:
            [cell aboutViewCellWithLeftImage:@"setting_favorite" title:@"我的收藏"];
            break;
        case 1:
            [cell aboutViewCellWithLeftImage:@"setting_font" title:@"字体设置"];
            break;
        case 2:
            [cell aboutViewCellWithLeftImage:@"setting_aboutus" title:@"关于我们"];
            break;
        case 3:
            [cell aboutViewCellWithLeftImage:@"setting_feedback" title:@"意见反馈"];
            break;
        default:
            break;
    }
    
    
    return cell;
}

/**
 *  设置每一行cell的高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}




@end
