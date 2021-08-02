//
//  BFEvaluateReplyCell.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFEvaluateReplyModel.h"
#import "BFCourseEvaluateReplyModel.h"

@interface BFEvaluateReplyCell : UITableViewCell
// 社区数据
@property (nonatomic , strong) BFEvaluateReplyModel *evaluateReplyModel;
// 课程数据
@property (nonatomic , strong) BFCourseEvaluateReplyModel *courseEvaluateReplyModel;
// 回复
@property (nonatomic , strong) UILabel *replyLabel;
@end
