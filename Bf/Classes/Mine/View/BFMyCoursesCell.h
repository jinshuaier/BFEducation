//
//  BFMyCoursesCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"
#import "BFMyCourseModel.h"

@interface BFMyCoursesCell : UITableViewCell
@property (nonatomic , strong) BFCourseModel *courseModel;
@property (nonatomic , strong) BFSetCourseModel *setCourseModel;
// <#描述#>
@property (nonatomic , strong) BFMyCourseModel *myCourseModel;
@end
