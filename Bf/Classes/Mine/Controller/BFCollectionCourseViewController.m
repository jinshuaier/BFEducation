//
//  BFCollectionCourseViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCollectionCourseViewController.h"
#import "BFCourseModel.h"
#import "BFClassListCell.h"
#import "BFCollectClassModel.h"
#import "BFCourseDetailsVC.h"
@interface BFCollectionCourseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end


static NSString *classListCell = @"classListCell";

@implementation BFCollectionCourseViewController{
    NSInteger lastPage;
    NSInteger curPage;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"课程收藏页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"课程收藏页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    [_tableView registerClass:[BFClassListCell class] forCellReuseIdentifier:classListCell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = GroundGraryColor;
    
//    [self networkingForCarnewsRequest];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (void)loadNewData{
    curPage = 1;
    [self networkingForCarnewsRequestWithCurPage:1];
}

- (void)loadMoreData{
    if (curPage < lastPage) {
        [self networkingForCarnewsRequestWithCurPage:++curPage];
    }else{
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFClassListCell *cell = [tableView dequeueReusableCellWithIdentifier:classListCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[BFClassListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:classListCell];
    }
    cell.courseModel = _modelArray[indexPath.row];
    cell.backgroundColor = GroundGraryColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95.0f;
}

-(void)networkingForCarnewsRequestWithCurPage:(NSInteger)cp {

    NSString *urlStr = [NSString stringWithFormat:@"%@?uId=%@&startPage=%ld",CollectCourse,GetFromUserDefaults(@"uId"),cp];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSLog(@"data数据为%@",data);
        NSDictionary *dic = data;
        lastPage = [dic[@"lastPage"] integerValue];
        curPage = [dic[@"curPage"] integerValue];
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = dic[@"date"];
            if (curPage == 1) {
                [_modelArray removeAllObjects];
                _tableView.mj_footer.hidden = NO;
                [_tableView.mj_footer endRefreshing];
            }
                for (NSDictionary *dict in arr) {
                    BFCourseModel *model = [BFCourseModel mj_objectWithKeyValues:dict];
                    [_modelArray addObject:model];
                }
                [_tableView reloadData];
        }
        if (curPage >= lastPage) {
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }
    } failureResponse:^(NSError *error) {
        NSLog(@"失败!");
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFCourseDetailsVC *vc = [BFCourseDetailsVC new];
    BFCourseModel *courseModel = _modelArray[indexPath.row];
    vc.model = courseModel;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CoursesDetailsEnterDetails" object:vc];
}

- (void)setModelArray:(NSMutableArray *)modelArray{
    _modelArray = modelArray;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
