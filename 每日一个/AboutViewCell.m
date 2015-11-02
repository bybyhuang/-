//
//  AboutViewCell.m
//  每日一个
//
//  Created by huangbaoyu on 15/11/2.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import "AboutViewCell.h"

@interface AboutViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end


@implementation AboutViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)abountViewCellWithTableView:(UITableView *)tableView WithIdentifier:(NSString *)reuseIdentifier
{
    AboutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AboutViewCell" owner:nil options:nil] lastObject];
    }
    
    
    return cell;
    
}

- (void)aboutViewCellWithLeftImage:(NSString *)leftImage title:(NSString *)title
{
    //设置图片的显示
    self.leftImage.image = [UIImage imageNamed:leftImage];
    
    //设置文字的显示
    self.label.text = title;
    

}


@end
