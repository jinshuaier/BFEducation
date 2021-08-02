//
//  BFSearchDetailViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFCourseModel.h"
@interface BFSearchDetailViewController : BFBaseViewController
// 数据
@property (nonatomic , strong) NSMutableArray <BFCourseModel *> *modelArray;
// table
@property (nonatomic , strong) UITableView *tableView;
/*data*/
@property (nonatomic,strong) id data;
@end
