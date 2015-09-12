//
//  BYShareBar.h
//  每日一个
//
//  Created by huangbaoyu on 15/8/14.
//  Copyright (c) 2015年 huangbaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYCriticContent,BYShareBar;

//@protocol BYShareBarDelegate <NSObject>
//
//- (void)shareBarUMShare:(BYShareBar *)sharBar ClickBtn:(UIButton *)btn;
//
//@end

@interface BYShareBar : UIView

/**
 *  代理
 */

//@property (nonatomic,weak)id<BYShareBarDelegate> delegate;

@property (nonatomic,strong)BYCriticContent *criticContent;

@property (nonatomic,assign) NSInteger publishtime;

@end
