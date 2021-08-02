//
//  BFPreviewWorkDirectionCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/27.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPreviewWorkDirectionCell : UITableViewCell
/*期望职位*/
@property (nonatomic,strong) UILabel *degree;
/*期望职位内容*/
@property (nonatomic,strong) UILabel *degree1;
/*期望薪资*/
@property (nonatomic,strong) UILabel *work;
/*期望薪资内容*/
@property (nonatomic,strong) UILabel *work1;
/*求职区域*/
@property (nonatomic,strong) UILabel *birth;
/*求职区域内容*/
@property (nonatomic,strong) UILabel *birth1;
@end
