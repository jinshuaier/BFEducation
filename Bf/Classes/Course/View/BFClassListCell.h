//
//  BFClassListCell.h
//  Bf
//
//  Created by 陈大鹰 on 2017/11/30.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseModel.h"
#import "BFMyCourseModel.h"
#import "BFCollectClassModel.h"
@interface BFClassListCell : UITableViewCell
@property (nonatomic , strong) BFCourseModel *courseModel;
@property (nonatomic , strong) BFMyCourseModel *myCourseModel;
@property (nonatomic , strong) BFCollectClassModel *classModel;
@end
