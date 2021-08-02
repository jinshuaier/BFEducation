//
//  BFMineHeaderCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMineHeaderCell : UITableViewCell
// 大头像
@property (nonatomic , strong) UIImageView *headerImageView;
// 小头像
@property (nonatomic , strong) UIImageView *smallHeaderImageView;
// 名字
@property (nonatomic , strong) UILabel *tagLabel;
@end
