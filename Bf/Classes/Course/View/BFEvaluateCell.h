//
//  BFEvaluateCell.h
//  NewTest
//
//  Created by 春晓 on 2017/12/1.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFEvaluateModel.h"
#import "BFCourseEvaluateModel.h"

@interface BFEvaluateCell : UITableViewCell
// 社区数据
@property (nonatomic , strong) BFEvaluateModel *evaluateModel;
// 课程数据
@property (nonatomic , strong) BFCourseEvaluateModel *courseEvaluateModel;
@end
