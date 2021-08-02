//
//  BFCourseDetailsVC.h
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFBaseViewController.h"
@class BFCourseModel;

@interface BFCourseDetailsVC : BFBaseViewController
// 课程id
@property (nonatomic , strong) BFCourseModel *model;
// 图片
@property (nonatomic , strong) UIImage *topImage;
// 是否是从其他应用里跳进来的
@property (nonatomic , assign) BOOL isFromOtherApp; // YES : 是;NO : 不是
@end
