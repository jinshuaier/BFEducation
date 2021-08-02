
//
//  BFNewHomePageViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFNewHomePageViewController.h"
#import "ZQNavBarSegmentView.h"//segmentView
#import "BFCarNewsCell.h"//车资讯自定义cell
#import "BFCarNewsModel.h"//车资讯model
#import "BFCourseModel.h"
//轮播图
#import "SDCycleScrollView.h"
#import "CustomCollectionViewCell.h"
#import "UIImageView+WebCache.h"
//中间collectionCell
#import "BFMiddleCollectionCell.h"
//最底部轮播图
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

#import "CXSearchController.h"//搜索
#import "BFWatchCourseVC.h"//观看视频页面

#import "BFCarNewsCell.h"
#import "BFCarNewsModel.h"
#import "BFCarConsultDetailsVC.h"//资讯详情页
#import "BFCourseDetailsVC.h"
#import "BFFourClassView.h"
#import "BFCourseDetailsHadApplyVC.h"
#import "LoadingView.h"
#import "InformationShowView.h"
#import "BFTestWatchLiveCourseVC.h"
#import "BFWatchLiveCourseVC.h"
#import "LiveShowViewController.h"
#import "BFTimeTransition.h"
#import "BFNewsOneView.h"
#import "BFNewsTwoView.h"
#import "BFTipsCell.h"
#import "BFTipTopCell.h"
#import "BFCommunityModel.h"
#import "BFCommunityDetailsVC.h"
#define Width [UIScreen mainScreen].bounds.size.width
@interface BFNewHomePageViewController ()<ZQNavBarSegmentViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,RequestDataDelegate,CCPushUtilDelegate,UIScrollViewDelegate>

/*车资讯View*/
@property (nonatomic,strong) UIView *carView;
/*车资讯tableView*/
@property (nonatomic,strong) UITableView *carTableView;

@property (nonatomic, strong) NSMutableArray <BFCarNewsModel *> *newsModelArray;
/** 下角标 */
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic , strong) NSMutableArray *newsArr;
@property (nonatomic , strong) NSMutableArray *tipArr;

@end

@implementation BFNewHomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGBColor(0, 126, 212);
//    [MobClick beginLogPageView:@"车资讯"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"车资讯"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpCarInterface];
    [self networkingForCarnewsRequest:@"1"];
    _pageIndex = 1;
}

-(void)loadNewData {
    _pageIndex = 1;
    NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
    [self networkingForCarnewsRequest:curPage];
    [self.carTableView.mj_header endRefreshing];
}

-(void)loadMoreData {
    if (_pageIndex < _lastPage) {
        _pageIndex++;
        NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
        [self networkingForCarnewsRequest:curPage];
    }else{
        [self.carTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - 创建车资讯视图

-(void)setUpCarInterface {
    self.carView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, KScreenW, KScreenH - 24)];
    self.carView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.carView];
    [self setUpCarTableView];
}

#pragma mark - 创建车资讯tableView

-(void)setUpCarTableView {
    self.carTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 64) style:UITableViewStyleGrouped];
    self.carTableView.delegate = self;
    self.carTableView.dataSource = self;
    self.carTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.carTableView.backgroundColor = [UIColor whiteColor];
    _carTableView.estimatedRowHeight=150.0f;
    [self.carView addSubview:self.carTableView];
    [self.carTableView registerClass:[BFCarNewsCell class] forCellReuseIdentifier:@"carCell"];

    __weak typeof(self) weakSelf = self;
    self.carTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.carTableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _carTableView) {
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
        //设置动画时间为1秒,xy方向缩放的最终值为1
        [UIView animateWithDuration:0.5 animations:^{
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }completion:^(BOOL finish){

        }];
    }
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    BFCarNewsModel *model = self.newsModelArray[indexPath.row];
    BFCarNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCell" forIndexPath:indexPath];
    cell.dataModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger num = (indexPath.row) % 52 + 1;
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    vc.carNewModel = self.newsModelArray[indexPath.row];
    vc.num = num;
    //统计观看资讯详情点击事件的个数
//    [MobClick event:@"watchNews"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor redColor]];
    return headerView;
}

#pragma mark - 车资讯的网络请求
-(void)networkingForCarnewsRequest:(NSString *)page {
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@BfNewsController/bfNewsSelect.do?uId=%@&startPage=%@",ServerURL,GetFromUserDefaults(@"uId"),page];
    }else{
        url = [NSString stringWithFormat:@"%@BfNewsController/bfNewsSelect.do?uId=%@&startPage=%@",ServerURL,@"0",page];
    }
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            _pageIndex = [dic[@"curPage"] integerValue];
            _lastPage = [dic[@"lastPage"] integerValue];
            if (_pageIndex == 1) {
                [self.newsModelArray removeAllObjects];
                _carTableView.mj_footer.hidden = NO;
                [_carTableView.mj_footer endRefreshing];
            }
            NSArray *modelArray = data[@"data"];
            for (NSDictionary *dict in modelArray) {
                BFCarNewsModel *model = [[BFCarNewsModel alloc] initWithDict:dict];
                BOOL isbool = [self.newsModelArray containsObject:model];
                if (isbool) {

                }
                else {
                    [self.newsModelArray addObject:model];
                }
            }
            [self.carTableView reloadData];
            if (_lastPage == _pageIndex) {
                [self.carTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.carTableView.mj_footer endRefreshing];
            }
        }else{
            [self.carTableView.mj_footer endRefreshing];
        }
    } failureResponse:^(NSError *error) {
        [self.carTableView.mj_footer endRefreshing];
    }];
}

-(NSMutableArray<BFCarNewsModel *> *)newsModelArray {
    if (_newsModelArray == nil) {
        _newsModelArray = [NSMutableArray array];
    }
    return _newsModelArray;
}


-(NSMutableArray *)newsArr {
    if (_newsArr == nil) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}

@end
