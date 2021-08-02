//
//  BFCourseBottomCell.h
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCourseBottomCell : UITableViewCell
//tableView 显示的数据
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , strong) NSMutableDictionary *catalogueDict;
@property (nonatomic, strong) NSMutableArray *evaluateArray;
// jsonStr
@property (nonatomic , strong) NSDictionary *jsonDic;
// 简介
@property (nonatomic , strong) NSString *descriptionStr;
@end
