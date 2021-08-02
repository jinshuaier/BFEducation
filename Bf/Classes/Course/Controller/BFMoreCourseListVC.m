//
//  BFMoreCourseListVC.m
//  Bf
//
//  Created by 春晓 on 2018/4/18.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFMoreCourseListVC.h"
#import "BFWatchCourseVC.h"

#import "BFCourseCollectionViewCell.h"

#import <MJRefresh.h>

@interface BFMoreCourseListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

// 课程列表
@property (nonatomic , strong) UICollectionView *collectionView;
// 课程数据
@property (nonatomic , strong) NSMutableArray *courseListArray;
@end

static NSString *collectionCell        = @"collectionCell";

@implementation BFMoreCourseListVC{
    NSInteger courseCurrentPage;
    NSInteger courseTotalPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@课程",_titleStr];
    self.view.backgroundColor = GroundGraryColor;
    _courseListArray = [NSMutableArray array];
    [self setupUI];
    // 增加数据
    [_collectionView.mj_header  beginRefreshing];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, CollectionRowMargin, 0, CollectionRowMargin);
    layout.itemSize = CGSizeMake(CollectionCellWidth, 160);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BFCourseCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    [self.view addSubview:_collectionView];
    // 下拉刷新
    _collectionView.mj_header= [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [self getNewData];
    }];
    // 上拉刷新
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
}


- (void)getNewData{
    [self getACourseListNetWorkWithCurrentPage:1 withcid:_cid];
}

- (void)getMoreData{
    if (courseCurrentPage < courseTotalPage) {
        [self getACourseListNetWorkWithCurrentPage:courseCurrentPage + 1 withcid:_cid];
    }else{
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark -collectionView-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _courseListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.courseDict = _courseListArray[indexPath.item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = GetFromUserDefaults(@"loginStatus");
//    if ([str isEqualToString:@"1"]) { //用户已登录
        NSDictionary *dic = _courseListArray[indexPath.item];
        [self watchVideoAction:dic[@"roomid"] withCid:[dic[@"csid"] integerValue]];
//    }
//    else {
//        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:navigation animated:YES completion:nil];
//    }
}

#pragma mark -根据id查询课程-
- (void)getACourseListNetWorkWithCurrentPage:(NSInteger)currentPage withcid:(NSInteger)cid{
    NSString *url = [NSString stringWithFormat:@"%@?cid=%ld&pageNo=%ld&pageSize=%d",CourseListByIdURL,cid,currentPage,20];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            NSDictionary *dict = data[@"data"];
            courseCurrentPage = [dict[@"pageNum"] integerValue];
            courseTotalPage = [dict[@"pages"] integerValue];
            
            NSArray *arr = dict[@"list"];
            if (courseCurrentPage == 1) {
                [_courseListArray removeAllObjects];
                [_courseListArray addObjectsFromArray:arr];
            }else{
                [_courseListArray addObjectsFromArray:arr];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });
        }
        [_collectionView.mj_header  endRefreshing];
        [_collectionView.mj_footer  endRefreshing];
    } failureResponse:^(NSError *error) {
        [_collectionView.mj_header  endRefreshing];
        [_collectionView.mj_footer  endRefreshing];
    }];
}

#pragma mark -观看视频-
- (void)watchVideoAction:(NSString *)roomId withCid:(NSInteger)cid {
    BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
    player.playMode = NO;
    player.videoId = roomId;
    player.cid = cid;
    player.isInstroduce = NO;
    player.canClick = YES;
    player.indexpath = 0;
    [self.navigationController pushViewController:player animated:YES];
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

