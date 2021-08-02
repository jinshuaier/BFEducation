//
//  BFMineInformateCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/11.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMineInformateCell : UITableViewCell
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 内容
@property (nonatomic , strong) UITextField *contentTextField;
// 按钮
@property (nonatomic , strong) UIButton *tagBtn;
// 数据
@property (nonatomic , strong) NSDictionary *dict;
@end
