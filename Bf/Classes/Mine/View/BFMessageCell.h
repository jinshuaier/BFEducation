//
//  BFMessageCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMessageCell : UITableViewCell
// 数据
@property (nonatomic , strong) NSDictionary *dict;
// 个数
@property (nonatomic , strong) UILabel *countLabel;
@end
