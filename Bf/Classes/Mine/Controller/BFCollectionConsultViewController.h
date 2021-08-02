//
//  BFCollectionConsultViewController.h
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFCollectionConsultViewController : BFBaseViewController
// 数据
@property (nonatomic , strong) NSMutableArray *modelArray;
// table
@property (nonatomic , strong) UITableView *tableView;

@end
