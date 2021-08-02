//
//  BFTopRechangeCell.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFTopRechangeCell : UITableViewCell
/*用户名*/
@property (nonatomic,strong) UILabel *userNameLabel;
/*用户名输入框*/
@property (nonatomic,strong) UITextField *userNameField;
/*昵称*/
@property (nonatomic,strong) UILabel *nickNameLabel;
/*昵称输入框*/
@property (nonatomic,strong) UITextField *nickNameField;
/*当前余额*/
@property (nonatomic,strong) UILabel *accountLabel;
/*当前余额输入框*/
@property (nonatomic,strong) UITextField *accountField;

@end
