//
//  BFPreviewBasicInformationCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/27.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPreviewBasicInformationCell : UITableViewCell
/*最高学历*/
@property (nonatomic,strong) UILabel *degree;
/*最高学历内容*/
@property (nonatomic,strong) UILabel *degree1;
/*工作经验*/
@property (nonatomic,strong) UILabel *work;
/*工作经验内容*/
@property (nonatomic,strong) UILabel *work1;
/*出生年份*/
@property (nonatomic,strong) UILabel *birth;
/*出生年份内容*/
@property (nonatomic,strong) UILabel *birth1;
/*联系电话*/
@property (nonatomic,strong) UILabel *phone;
/*联系电话内容*/
@property (nonatomic,strong) UILabel *phone1;
@end
