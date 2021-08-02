//
//  BFEvaluateViewController.h
//  NewTest
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EvaluateModelType) {
    EvaluateModelType_Course,     // 课程评论
    EvaluateModelType_Community   // 社区评论
};

@interface BFEvaluateViewController : UIViewController
// 评论类型
@property (nonatomic , assign) EvaluateModelType evaluateModelType;
// 评价
@property (nonatomic , strong) NSMutableArray *evaluateArray;
// 评价tableView
@property (nonatomic , strong) UITableView *tableView;
@end
