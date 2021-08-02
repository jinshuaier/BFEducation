//
//  BFRechargeDetailCell.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFRechargeDetailCell : UITableViewCell
/*账户类型*/
@property (nonatomic,strong) UILabel *accountStyle;
/*账户余额*/
@property (nonatomic,strong) UILabel *accountLeft;
/*日期*/
@property (nonatomic,strong) UILabel *accountTime;
/*单笔交易*/
@property (nonatomic,strong) UILabel *accountPer;
/*下划线*/
@property (nonatomic,strong) UIView *line;
@end
