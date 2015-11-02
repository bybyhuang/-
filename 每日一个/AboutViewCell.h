//
//  AboutViewCell.h
//  每日一个
//
//  Created by huangbaoyu on 15/11/2.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewCell : UITableViewCell


/**
 *  初始化一个cell
 *
 *  @param tableView       tableView来取得循环队列中的cell
 *  @param reuseIdentifier 标识符
 *
 *  @return 返回cell
 */
+ (instancetype)abountViewCellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)reuseIdentifier;

- (void)aboutViewCellWithLeftImage:(NSString *)leftImage title:(NSString *)title;

@end
