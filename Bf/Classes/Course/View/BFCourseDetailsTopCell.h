//
//  BFCourseDetailsTopCell.h
//  基本框架
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"

@interface BFCourseDetailsTopCell : UITableViewCell
// 数据
@property (nonatomic , strong) BFCourseModel *courseModel;
// 数据
@property (nonatomic , strong) BFSetCourseModel *setCourseModel;
@end
