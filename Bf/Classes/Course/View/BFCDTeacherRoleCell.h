//
//  BFCDTeacherRoleCell.h
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseDetailsTeachers.h"

@interface BFCDTeacherRoleCell : UITableViewCell
// 老师
@property (nonatomic , strong) BFCourseDetailsTeachers *teacher;

// 老师数组
@property (nonatomic , strong) NSMutableArray *teachersArray;

// 展开
- (void)expansionCell;

// 合闭
- (void)closeCell;
@end
