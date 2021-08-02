//
//  BFIntroduceViewController.h
//  NewTest
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"

@interface BFIntroduceViewController : UIViewController
// tableView
@property (nonatomic , strong) UITableView *tableView;
// Label
@property (nonatomic , strong) UILabel *introduceLabel;
// <#描述#>
@property (nonatomic , strong) BFCourseModel *courseModel;
// <#描述#>
@property (nonatomic , strong) BFSetCourseModel *setCourseModel;
// 简介
@property (nonatomic , strong) NSString *descriptionStr;
@end
