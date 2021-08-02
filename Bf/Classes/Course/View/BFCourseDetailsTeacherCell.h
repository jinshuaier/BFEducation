//
//  BFCourseDetailsTeacherCell.h
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseDetailsTeachers.h"

#define TeacherCellHeight PXTOPT(140)
@interface BFCourseDetailsTeacherCell : UITableViewCell

// 老师
@property (nonatomic , strong) BFCourseDetailsTeachers *teacher;

@end
