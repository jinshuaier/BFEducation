//
//  BFSearchDetailViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFSearchDetailViewController.h"
#import "BFClassListCell.h"
#import "BFCourseModel.h"
#import "BFCourseDetailsVC.h"
@interface BFSearchDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *classListCell = @"CELL";

@implementation BFSearchDetailViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [MobClick beginLogPageView:@"搜索详情页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"搜索详情页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    [_tableView registerClass:[BFClassListCell class] forCellReuseIdentifier:classListCell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = GroundGraryColor;
    NSArray *arr = _data[@"listLike"];
    NSLog(@"%@",_data[@"listLike"]);
    if (0 == arr.count) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        UIImageView *nodataImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 200)/2, 200, 200, 200)];
        nodataImg.image = [UIImage imageNamed:@"nodata"];
        [backView addSubview:nodataImg];
        
        UILabel *nodataLbl = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 200)/2, nodataImg.bottom, 200, 30)];
        nodataLbl.text = @"暂时没有数据";
        nodataLbl.textColor = [UIColor grayColor];
        nodataLbl.textAlignment = NSTextAlignmentCenter;
        nodataLbl.font = [UIFont fontWithName:BFfont size:13.0f];
        [backView addSubview:nodataLbl];
    }
    else {
        for (NSDictionary *dic in arr) {
            BFCourseModel *model = [BFCourseModel mj_objectWithKeyValues:dic];
            [self.modelArray addObject:model];
        }
        [_tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFClassListCell *cell = [tableView dequeueReusableCellWithIdentifier:classListCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[BFClassListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:classListCell];
    }
    NSObject *model = self.modelArray[indexPath.row];
    if ([[model class] isKindOfClass:[BFCourseModel class]]) {
        cell.courseModel = (BFCourseModel *)model;
    }else if ([[model class] isKindOfClass:[BFCollectClassModel class]]){
        cell.classModel = (BFCollectClassModel *)model;
    }
    else {
        cell.courseModel = (BFCourseModel *)model;
    }
    cell.backgroundColor = GroundGraryColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFCourseModel *model = self.modelArray[indexPath.row];
    BFCourseDetailsVC *vc = [BFCourseDetailsVC new];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray<BFCourseModel *> *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
