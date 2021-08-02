//
//  BFDropInBoxController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/27.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFDropInBoxController.h"
#import "BFCompanyListCell.h"
#import "BFDropInBoxModel.h"
#import "BFCompanyDetailViewController.h"//职位详情
@interface BFDropInBoxController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray <BFDropInBoxModel *>*boxArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger lastPage;
@end

@implementation BFDropInBoxController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投递箱";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    
    _pageIndex = 1;
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobIntentionSelectUId.do?uId=%ld&startPage=1",ServerURL,uid];
    [self networkRequest:urlStr];
}

-(void)createInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, KScreenW, KScreenH - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[BFCompanyListCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)loadNewData {
    _pageIndex = 1;
    NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobIntentionSelectUId.do?uId=%ld&startPage=%@",ServerURL,uid,curPage];
    [self networkRequest:urlStr];
}

-(void)loadMoreData {
    if (_pageIndex < _lastPage) {
        _pageIndex++;
        NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
        NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobIntentionSelectUId.do?uId=%ld&startPage=%@",ServerURL,uid,curPage];
        [self networkRequest:urlStr];
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.boxArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    BFDropInBoxModel *model = self.boxArray[indexPath.row];
    BFCompanyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataModel1 = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFDropInBoxModel *model = self.boxArray[indexPath.row];
    NSString *idStr = [NSString stringWithFormat:@"%d",model.jWId];
    NSString *uidStr = GetFromUserDefaults(@"uId");
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do?jWId=%@&uId=%@",ServerURL,idStr,uidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dict = data;
        NSLog(@"获取到的数据为:%@",dict);
        BFCompanyDetailViewController *detailVC = [[BFCompanyDetailViewController alloc] init];
        detailVC.dic = dict[@"data"];
        detailVC.isPost = @"1";
        [self.navigationController pushViewController:detailVC animated:YES];
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(void)networkRequest:(NSString *)urlStr {
    
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSArray *arr = dic[@"data"];
            
            _pageIndex = [dic[@"curPage"] integerValue];
            _lastPage = [dic[@"lastPage"] integerValue];
            
            if (_pageIndex == 1) {
                [self.boxArray removeAllObjects];
                self.tableView.mj_footer.hidden = YES;
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
            }
            
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BFDropInBoxModel *model = [[BFDropInBoxModel alloc] initWithDict:obj];
                [self.boxArray addObject:model];
            }];
            [self.tableView reloadData];
            
            if (_lastPage == _pageIndex) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
                
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
    } failureResponse:^(NSError *error) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(NSMutableArray<BFDropInBoxModel *> *)boxArray {
    if (!_boxArray) {
        _boxArray = [NSMutableArray array];
    }
    return _boxArray;
}

@end
