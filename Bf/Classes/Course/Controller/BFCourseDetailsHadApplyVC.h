//
//  BFCourseDetailsHadApplyVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFMyCourseModel.h"
@class BFCourseModel;

@interface BFCourseDetailsHadApplyVC : BFBaseViewController
// 课程id
@property (nonatomic , strong) BFCourseModel *model;
//
@property (nonatomic , strong) BFMyCourseModel *myCourseModel;
// 数据
@property (nonatomic , strong) NSMutableArray *dataSource;
@end
