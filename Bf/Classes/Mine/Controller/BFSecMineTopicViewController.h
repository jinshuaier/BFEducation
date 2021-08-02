//
//  BFSecMineTopicViewController.h
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFBaseViewController.h"
typedef NS_ENUM(NSInteger, GetConsultsType) {// 获取社区类型
    GetConsultsType_Collection,  // 已收藏
    GetConsultsType_Send         // 发布
};

@interface BFSecMineTopicViewController : BFBaseViewController
// 数据
@property (nonatomic , strong) NSMutableArray *modelArray;
// table
@property (nonatomic , strong) UITableView *tableView;
// 获取社区的类型
@property (nonatomic , assign) GetConsultsType getConsultsType;
@end
