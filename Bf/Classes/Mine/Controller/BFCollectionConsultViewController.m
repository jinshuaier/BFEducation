//
//  BFCollectionConsultViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCollectionConsultViewController.h"
#import "BFCarNewsCell.h"
#import "BFCarNewsModel.h"
#import "BFCarConsultDetailsVC.h"
@interface BFCollectionConsultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <BFCarNewsModel *> *newsModelArray;
/** 下角标 */
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation BFCollectionConsultViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"资讯收藏页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"资讯收藏页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    [_tableView registerClass:[BFCarNewsCell class] forCellReuseIdentifier:@"consultCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self networkingForCarnewsRequest:@"1"];
    [self.view addSubview:_tableView];
    
    _pageIndex = 1;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)loadNewData {
    [self.newsModelArray removeAllObjects];
    [self networkingForCarnewsRequest:@"1"];
    [self.tableView.mj_header endRefreshing];
}

-(void)loadMoreData {
    _pageIndex++;
    NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
    [self networkingForCarnewsRequest:curPage];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BFCarNewsModel *model = self.newsModelArray[indexPath.row];
    BFCarNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"consultCell" forIndexPath:indexPath];
    cell.dataModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    vc.carNewModel = self.newsModelArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CarConsultEnterDetails" object:vc];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 215.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor redColor]];
    return headerView;
}

#pragma mark - 车资讯的网络请求
-(void)networkingForCarnewsRequest:(NSString *)page {
    NSString *urlStr = [NSString stringWithFormat:@"%@?uId=%@&startPage=%@",CollectConsult,GetFromUserDefaults(@"uId"),page];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSArray *modelArray = data[@"data"];
            [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BFCarNewsModel *model = [[BFCarNewsModel alloc] initWithDict:obj];
                BOOL isbool = [self.newsModelArray containsObject:obj];
                if (isbool) {
                    
                }
                else {
                    [self.newsModelArray addObject:model];
                }
            }];
            [self.tableView reloadData];
    } failureResponse:^(NSError *error) {
        
    }];
}

-(NSMutableArray<BFCarNewsModel *> *)newsModelArray {
    if (_newsModelArray == nil) {
        _newsModelArray = [NSMutableArray array];
    }
    return _newsModelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
