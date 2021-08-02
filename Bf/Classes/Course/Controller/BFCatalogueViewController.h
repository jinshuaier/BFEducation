//
//  BFCatalogueViewController.h
//  NewTest
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TreeTableView;
@interface BFCatalogueViewController : UIViewController
//tableView 显示的数据
@property (nonatomic, strong) NSMutableArray *dataSource;
// tableView
//@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) TreeTableView *tableView;
//
@property (nonatomic, strong) NSMutableDictionary *catalogueDict;

@end
