//
//  BFSecMineTopicViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFSecMineTopicViewController.h"
#import "BFCommunityDetailsVC.h"
#import "BFCommunityTextCell.h"
#import "BFCommunityImageCell.h"
#import "BFCommunityVideoCell.h"
#import "BFCommunityModel.h"
#import "BFCommunityCollectionModel.h"

#import <MJRefresh.h>
#import <MBProgressHUD.h>

@interface BFSecMineTopicViewController ()<UITableViewDelegate,UITableViewDataSource>

@end


static NSString *communityImgCell   = @"communityImgCell";
static NSString *communityVideoCell = @"communityVideoCell";
static NSString *communityTextCell  = @"communityTextCell";

@implementation BFSecMineTopicViewController{
    NSInteger curPage; // 当前页
    NSInteger lastPage;// 总共页
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if (self.getConsultsType == GetConsultsType_Send) {
        self.title = @"我的帖子";
    }else if (self.getConsultsType == GetConsultsType_Collection){
        
    }
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:(UITableViewStylePlain)];
    [_tableView registerClass:[BFCommunityTextCell class] forCellReuseIdentifier:communityTextCell];
    [_tableView registerClass:[BFCommunityImageCell class] forCellReuseIdentifier:communityImgCell];
    [_tableView registerClass:[BFCommunityVideoCell class] forCellReuseIdentifier:communityVideoCell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _modelArray = [NSMutableArray array];
    curPage = 0;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    
    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    [self.tableView.mj_header beginRefreshing];
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrashCommunityDetails) name:@"RefrashCommunityDetails" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCommunity:) name:@"DeleteCommunity" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refrashCommunityDetails{
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
//    [MobClick beginLogPageView:@"我的帖子页"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"我的帖子页"];
}

#pragma mark -tableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCommunityModel *model = _modelArray[indexPath.row];
    if (model.communityModelType == BFCommunityModelType_Text) {
        BFCommunityTextCell *cell = [tableView dequeueReusableCellWithIdentifier:communityTextCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCommunityTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:communityTextCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.model = model;
        return cell;
    }else if (model.communityModelType == BFCommunityModelType_Image) {
        BFCommunityImageCell *cell = [tableView dequeueReusableCellWithIdentifier:communityImgCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCommunityImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:communityImgCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.model = model;
        return cell;
    }else if (model.communityModelType == BFCommunityModelType_Video || model.communityModelType == BFCommunityModelType_VideoAndImage){
        BFCommunityVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:communityVideoCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCommunityVideoCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:communityVideoCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.model = model;
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCommunityModel *model = _modelArray[indexPath.row];
    if (model.communityModelType == BFCommunityModelType_Text) {
        return 200;
    }else if (model.communityModelType == BFCommunityModelType_Image) {
        return 325;
    }else if (model.communityModelType == BFCommunityModelType_Video || model.communityModelType == BFCommunityModelType_VideoAndImage){
        return 335;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCommunityModel *model = _modelArray[indexPath.row];
    //    if (![_showArray containsObject:@(model.pId)]) {
    //        NSString *url = [NSString stringWithFormat:@"%@?pId=%ld",CommunityShowNumURL,model.pId];
    //        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
    //            NSDictionary *dit = data;
    //            NSInteger status = [dit[@"status"] integerValue];
    //            if (status == 1) {
    //                [_showArray addObject:@(model.pId)];
    //                [self performSelector:@selector(setSendRequest:) withObject:@(model.pId) afterDelay:5.0f];
    //            }
    //        } failureResponse:^(NSError *error) {
    //
    //        }];
    //    }
    
    BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
    vc.model = model;
    if (_getConsultsType == GetConsultsType_Send) {
        [self.navigationController pushViewController:vc animated:YES];
    }else if (_getConsultsType == GetConsultsType_Collection){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EnterDetail" object:vc];
    }
    
}


- (void)setModelArray:(NSMutableArray *)modelArray{
    _modelArray = modelArray;
    [_tableView reloadData];
}

- (void)loadNewTopic{
    //进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    curPage = 0;
    [self getDataNetWork];
}

- (void)loadMoreTopic{
    if (curPage < lastPage) {
        [self getDataNetWork];
        //进入刷新状态
        [self.tableView.mj_footer beginRefreshing];
    }else{
        //进入刷新状态
        [self.tableView.mj_footer endRefreshing];
        if (HUD) {
            [HUD removeFromSuperViewOnHide];
            HUD = nil;
        }
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.label.text = @"已经是最后一页";
        HUD.mode = MBProgressHUDModeText;
        
//        [HUD showAnimated:YES whileExecutingBlock:^{
//            sleep(2);
//
//        }
//          completionBlock:^{
//              [HUD removeFromSuperview];
//              HUD = nil;
//          }];
        
    }
}

- (void)getDataNetWork{
    if (curPage == 0 || curPage < lastPage) {
        if (_getConsultsType == GetConsultsType_Send) {
            [self getSendDataWithStarPage:++curPage];
        }else if (_getConsultsType == GetConsultsType_Collection){
            [self getCollectionDataWithStarPage:++curPage];
        }
    }
}

// 获取收藏数据
- (void)getCollectionDataWithStarPage:(NSInteger)starPage{
    NSString *url = [NSString stringWithFormat:@"%@?uId=%@&starPage=%ld",CommunityGetCollectionURL,GetFromUserDefaults(@"uId"),starPage];
    //    __block NSInteger blockCurrentPage = curPage;
    __block NSInteger blockLastPage    = lastPage;
    __block BFSecMineTopicViewController *weakSelf = self;
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            if (!_modelArray) {
                _modelArray = [NSMutableArray array];
            }
            //            blockCurrentPage = [dic[@"curPage"] integerValue];
            blockLastPage = [dic[@"lastPage"] integerValue];
            if (starPage == 1) {
                [_modelArray removeAllObjects];
                NSDictionary *dic = data;
                NSArray *arr = dic[@"data"];
                if (0 == arr.count) {
                    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
                    backView.backgroundColor = [UIColor whiteColor];
                    [self.view addSubview:backView];
                    UIImageView *nodataImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 200)/2, 120, 200, 200)];
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
                    for (NSDictionary *dict in arr) {
                        BFCommunityCollectionModel *model = [BFCommunityCollectionModel initWithDict:dict];
                        [_modelArray addObject:model];
                    }
                }
            }else{
                NSDictionary *dic = data;
                NSArray *arr = dic[@"data"];
                
                if (0 != arr.count) {
                    for (NSDictionary *dict in arr) {
                        BFCommunityCollectionModel *model = [BFCommunityCollectionModel initWithDict:dict];
                        [_modelArray addObject:model];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
        //结束头部刷新
        [weakSelf.tableView.mj_header endRefreshing];
        //结束尾部刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } failureResponse:^(NSError *error) {
        //结束头部刷新
        [weakSelf.tableView.mj_header endRefreshing];
        //结束尾部刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

// 获取发送的帖子数据
- (void)getSendDataWithStarPage:(NSInteger)starPage{
    NSString *url = [NSString stringWithFormat:@"%@?uId=%@&starPage=%ld",CommunityGetSendURL,GetFromUserDefaults(@"uId"),starPage];
    //    __block NSInteger blockCurrentPage = curPage;
    __block NSInteger blockLastPage    = lastPage;
    __block BFSecMineTopicViewController *weakSelf = self;
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            if (!_modelArray) {
                _modelArray = [NSMutableArray array];
            }
            //            blockCurrentPage = [dic[@"curPage"] integerValue];
            blockLastPage    = [dic[@"lastPage"] integerValue];
            if (starPage == 1) {
                [_modelArray removeAllObjects];
                NSDictionary *dic = data;
                NSArray *arr = dic[@"data"];
                for (NSDictionary *dict in arr) {
                    BFCommunityModel *model = [BFCommunityModel initWithDict:dict];
                    [_modelArray addObject:model];
                }
            }else{
                NSDictionary *dic = data;
                NSArray *arr = dic[@"data"];
                for (NSDictionary *dict in arr) {
                    BFCommunityModel *model = [BFCommunityModel initWithDict:dict];
                    [_modelArray addObject:model];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
        //结束头部刷新
        [weakSelf.tableView.mj_header endRefreshing];
        //结束尾部刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } failureResponse:^(NSError *error) {
        //结束头部刷新
        [weakSelf.tableView.mj_header endRefreshing];
        //结束尾部刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

// 删除帖子
- (void)deleteCommunity:(NSNotification *)notification{
    if (self.isViewLoaded && self.view.window) {
        BFCommunityModel *model = notification.object;
        NSInteger row = [self.modelArray indexOfObject:model];
        [self.modelArray removeObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    }
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
