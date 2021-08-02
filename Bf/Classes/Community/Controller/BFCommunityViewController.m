//
//  BFCommunityViewController.m
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCommunityViewController.h"
#import "ShortVideoViewController.h"
#import "ZQNavBarSegmentView.h"
#import "WLScrollView.h"
#import "BFScrollCell.h"
#import "BFScrollViewCell.h"
#import "BFCommunityModel.h"
#import "BFCommunityImageCell.h"
#import "BFCommunityVideoCell.h"
#import <SDAutoLayout.h>
#import "BFPublishTopicController.h"//发布话题页面
#import "BFCommunityDetailsVC.h"
#import "BFCommunityTextCell.h"
#import "BFCommunityWatchVideoVC.h"
#import "BFLoginViewController.h"
#import "BFTopImageCell.h"
#import <MJRefresh.h>
#import "ZWPullMenuView.h"

// 测试新发布
#import "BFPublishViewController.h"
#import "BFSearchCommunityVC.h"

@interface BFCommunityViewController ()<ZQNavBarSegmentViewDelegate,UITableViewDelegate,UITableViewDataSource,WLScrollViewDelegate,UIScrollViewDelegate>
// 导航栏的选择器
@property (nonatomic,copy) ZQNavBarSegmentView *segment;
// 最外层ScrollView
@property (nonatomic , strong) UIScrollView *bigScrollView;
// 顶部轮播图
@property (nonatomic , strong) WLScrollView *topCollectionView;
// 社区
@property (nonatomic,copy) UITableView *communityTableView;
// 车友
@property (nonatomic,copy) UITableView *carFriendsTableView;
// 加号
@property (nonatomic,copy) UIButton *addCommumityBtn;

// 顶部轮播图数据
@property (nonatomic , strong) NSMutableArray *topScrollArray;
// 社区
@property (nonatomic , strong) NSMutableArray *communityArray;
// 车友
@property (nonatomic , strong) NSMutableArray *carFriendsArray;
// 是否在五秒内浏览了字典
@property (nonatomic , strong) NSMutableArray *showArray;
@end

NSInteger topViewHeight     = 177;// 轮播图高度

static NSString *topSCrollViewCell  = @"topSCrollViewCell";
static NSString *communityImgCell   = @"communityImgCell";
static NSString *communityVideoCell = @"communityVideoCell";
static NSString *communityTextCell  = @"communityTextCell";

@implementation BFCommunityViewController{
    NSInteger carFriendsCurPage; // 当前页
    NSInteger carFriendsLastPage;// 总共页
    NSInteger communityCurPage; // 当前页
    NSInteger communityLastPage;// 总共页
    MBProgressHUD *HUD;
    NSInteger imageCellHeight;  // 图片cell的高度
    int       sType;            // 0=所有 1=最新 2=最热
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"社区";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame =CGRectMake((KScreenW-120)/2,(KScreenH-30)/2,120, 30);
//    [btn setTitle:@"录制小视频" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn.titleLabel.font =[UIFont systemFontOfSize:18];
//    btn.titleLabel.textAlignment =NSTextAlignmentCenter;
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    imageCellHeight = PXTOPT(36) + PXTOPT(29) + PXTOPT(14) + PXTOPT(21) + PXTOPT(38) + PXTOPT(34) + PXTOPT(20) + PXTOPT(100) + PXTOPT(30) + PXTOPT(30) + PXTOPT(24) + PXTOPT(16) + PXTOPT(40) + ((KScreenW - PXTOPT(40)) / 3);
    //创建导航栏右侧两个按钮
//    [self setUpRightBarbutton];
    carFriendsCurPage = 0;
    communityCurPage = 0;
    sType = 0;
    _communityTableView.estimatedRowHeight=150.0f;
    [self prepareData];
    [self setupUI];
    [self refresh];
    [self createNavgationButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCommunity:) name:@"DeleteCommunity" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh{
    self.communityTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNewData:self.communityTableView];
    }];
    // 马上进入刷新状态
    [self.communityTableView.mj_header beginRefreshing];
    // 马上进入刷新状态
    
    self.communityTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData:self.communityTableView];
    }];
}

-(void)createNavgationButton {
    //设置搜索按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"search"] forState:(UIControlStateNormal)];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setFrame:CGRectMake(0, 0, 40, 30)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //设置筛选按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"筛选"] forState:(UIControlStateNormal)];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[item1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_segment) {
        //创建segment
        _segment = [[ZQNavBarSegmentView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
        _segment.titlesArray = @[@"社区",@"车友"];
        _segment.delegate = self;
        [self.navigationController.navigationBar addSubview:_segment];
    }
    _segment.hidden = YES;
//    [MobClick beginLogPageView:@"社区页"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _segment.hidden = YES;
//    [MobClick endLogPageView:@"社区页"];
}

- (void)btnClick{
    ShortVideoViewController *viewCtrl =[[ShortVideoViewController alloc]init];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)prepareData{
    if (!_topScrollArray) {
        _topScrollArray = [NSMutableArray array];
    }
    if (!_communityArray) {
        _communityArray = [NSMutableArray array];
    }
    if (!_showArray) {
        _showArray = [NSMutableArray array];
    }
    UIImage *topImg = [UIImage imageNamed:@"组3"];
    for (int i = 0; i < 5; i++) {
        [_topScrollArray addObject:topImg];
    }
}

- (void)getNewData:(UITableView *)tableView{
    if (tableView == _communityTableView) {
        communityCurPage = 1;
    }else{
        carFriendsCurPage = 1;
    }
    [self netWorkRequestWithPage:1 withTableView:tableView];
}

- (void)getMoreData:(UITableView *)tableView{
    if (tableView == _communityTableView) {
        if (communityCurPage < communityLastPage) {
            [self netWorkRequestWithPage:++communityCurPage withTableView:tableView];
            
        }else{
            [tableView.mj_footer endRefreshingWithNoMoreData];
            tableView.mj_footer.hidden = YES;
        }
    }else{
        if (carFriendsCurPage < carFriendsLastPage) {
            [self netWorkRequestWithPage:++carFriendsCurPage withTableView:tableView];
        }else{
            [tableView.mj_footer endRefreshingWithNoMoreData];
            tableView.mj_footer.hidden = YES;
        }
    }
}

- (void)netWorkRequestWithPage:(NSInteger)pageNumber withTableView:(UITableView *)tableView{
    
    
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?startPage=%ld&uId=%@&sType=%@",CommunityListURL,pageNumber,GetFromUserDefaults(@"uId"),@(sType)];
    }else{
        url = [NSString stringWithFormat:@"%@?startPage=%ld&uId=%@&sType=%@",CommunityListURL,pageNumber,@"0",@(sType)];
    }
    NSLog(@"当前页 = %@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = dic[@"data"];
            
            if (tableView == _communityTableView) {
                communityLastPage = [dic[@"lastPage"] integerValue];
                if (!_communityArray) {
                    _communityArray = [NSMutableArray array];
                }
                if (communityCurPage == 1) {
                    [_communityArray removeAllObjects];
                    _communityTableView.mj_footer.hidden = NO;
                    [_communityTableView.mj_footer endRefreshing];
                }else{
                }
                for (NSDictionary *dict in arr) {
                    BFCommunityModel *model = [BFCommunityModel initWithDict:dict];
                    [_communityArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.communityTableView.mj_footer endRefreshing];
                    [self.communityTableView.mj_header endRefreshing];
                    [_communityTableView reloadData];
                });
            }else{
                carFriendsLastPage = [dic[@"lastPage"] integerValue];
                if (!_carFriendsArray) {
                    _carFriendsArray = [NSMutableArray array];
                }
                if (carFriendsCurPage == 1) {
                    [_carFriendsArray removeAllObjects];
//                    [self.carFriendsTableView.mj_header endRefreshing];
                }else{
//                    [self.carFriendsTableView.mj_footer endRefreshing];
                }
                for (NSDictionary *dict in arr) {
                    BFCommunityModel *model = [BFCommunityModel initWithDict:dict];
                    [_carFriendsArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.carFriendsTableView.mj_footer endRefreshing];
                    [self.carFriendsTableView.mj_header endRefreshing];
                    [_carFriendsTableView reloadData];
                });
            }
            
            
        }
        
    } failureResponse:^(NSError *error) {
        [self.communityTableView.mj_header endRefreshing];
        [self.carFriendsTableView.mj_header endRefreshing];
        [self.communityTableView.mj_footer endRefreshing];
        [self.carFriendsTableView.mj_footer endRefreshing];
    }];
}

- (void)setupUI{
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    CGFloat commentHeight = rectOfStatusbar.size.height + rectOfNavigationbar.size.height;
    
    [self.view addSubview:self.bigScrollView];
    self.bigScrollView.contentSize = CGSizeMake(2 * KScreenW, KScreenH - commentHeight - 49);
    self.bigScrollView.scrollEnabled = NO;
    self.bigScrollView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, commentHeight)
//    .topEqualToView(self.view)
    .bottomSpaceToView(self.view,49);
    
    UIView *bigBGView = [[UIView alloc] init];
    [self.bigScrollView addSubview:bigBGView];
    bigBGView.sd_layout
    .leftEqualToView(self.bigScrollView)
    .widthIs(2 * KScreenW)
    .topEqualToView(self.bigScrollView)
    .bottomEqualToView(self.bigScrollView);
    
    [bigBGView addSubview:self.communityTableView];
    self.communityTableView.sd_layout
    .leftEqualToView(bigBGView)
    .topEqualToView(bigBGView)
    .widthIs(KScreenW)
    .bottomEqualToView(bigBGView);
    
    [bigBGView addSubview:self.carFriendsTableView];
    self.carFriendsTableView.sd_layout
    .widthIs(KScreenW)
    .topEqualToView(bigBGView)
    .rightEqualToView(bigBGView)
    .bottomEqualToView(bigBGView);
    
    [self.view addSubview:self.addCommumityBtn];
    self.addCommumityBtn.sd_layout
    .widthIs(70)
    .heightIs(70)
    .rightSpaceToView(self.view, PXTOPT(20))
    .bottomSpaceToView(self.view, 100);
}

#pragma mark -tableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _carFriendsTableView) {
        return 1 + _carFriendsArray.count;
    }else{
        return 1 + _communityArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _carFriendsTableView) {
        NSLog(@"_carFriendsTableView");
        if (indexPath.row == 0) {
//            BFScrollViewCell *cell = [[BFScrollViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topSCrollViewCell];
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            cell.scrollArray = _topScrollArray;
//            return cell;
            BFTopImageCell *cell = [_communityTableView dequeueReusableCellWithIdentifier:topSCrollViewCell forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTopImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topSCrollViewCell];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.imgView.image = [UIImage imageNamed:@"community"];
            return cell;
        }else{
            BFCommunityModel *model = _carFriendsArray[indexPath.row - 1];
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
    }else{
        NSLog(@"communityTableView");
        if (indexPath.row == 0) {
            BFTopImageCell *cell = [_communityTableView dequeueReusableCellWithIdentifier:topSCrollViewCell forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTopImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topSCrollViewCell];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.imgView.image = [UIImage imageNamed:@"community"];
            return cell;
        }else{
            BFCommunityModel *model = _communityArray[indexPath.row - 1];
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
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _carFriendsTableView) {
        if (indexPath.row == 0) {
            return topViewHeight;
        }else{
            BFCommunityModel *model = _carFriendsArray[indexPath.row - 1];
            if (model.communityModelType == BFCommunityModelType_Text) {
                return 200;
            }else if (model.communityModelType == BFCommunityModelType_Image) {
                return imageCellHeight;
            }else if (model.communityModelType == BFCommunityModelType_Video || model.communityModelType == BFCommunityModelType_VideoAndImage){
                return 335;
            }else{
                return 0;
            }
        }
    }else{
        if (indexPath.row == 0) {
            return topViewHeight;
        }else{
            BFCommunityModel *model = _communityArray[indexPath.row - 1];
            if (model.communityModelType == BFCommunityModelType_Text) {
                return 200;
            }else if (model.communityModelType == BFCommunityModelType_Image) {
                return imageCellHeight;
            }else if (model.communityModelType == BFCommunityModelType_Video || model.communityModelType == BFCommunityModelType_VideoAndImage){
                return 335;
            }else{
                return 0;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _carFriendsTableView) {
        if (indexPath.row != 0) {
            BFCommunityModel *model = _carFriendsArray[indexPath.row - 1];
//            if (![_showArray containsObject:@(model.pId)]) {
//                NSString *url = [NSString stringWithFormat:@"%@?pId=%ld",CommunityShowNumURL,model.pId];
//                [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
//                    NSDictionary *dit = data;
//                    NSInteger status = [dit[@"status"] integerValue];
//                    if (status == 1) {
//                        [_showArray addObject:@(model.pId)];
//                        [self performSelector:@selector(setSendRequest:) withObject:@(model.pId) afterDelay:5.0f];
//                    }
//                } failureResponse:^(NSError *error) {
//
//                }];
//            }
            BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row != 0) {
            BFCommunityModel *model = _communityArray[indexPath.row - 1];
//            if (![_showArray containsObject:@(model.pId)]) {
//                NSString *url = [NSString stringWithFormat:@"%@?pId=%ld",CommunityShowNumURL,model.pId];
//                [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
//                    NSDictionary *dit = data;
//                    NSInteger status = [dit[@"status"] integerValue];
//                    if (status == 1) {
//                        [_showArray addObject:@(model.pId)];
//                        [self performSelector:@selector(setSendRequest:) withObject:@(model.pId) afterDelay:5.0f];
//                    }
//                } failureResponse:^(NSError *error) {
//
//                }];
//            }
            BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)setSendRequest:(NSNumber *)number{
    [_showArray removeObject:number];
}

- (void)createTimer:(NSNumber *)pId{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSThread *thread1 = [NSThread currentThread];
//        [thread1 setName:@"线程A"];
        NSTimer *threadTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction:withNum:) userInfo:pId repeats:NO];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:threadTimer forMode:NSDefaultRunLoopMode];
        [runloop run];
    });
}

- (void)timerAction:(NSTimer *)timer withNum:(NSNumber *)pId{
    [_showArray removeObject:pId];
    [timer invalidate];
    timer = nil;
}


#pragma mark -UIScrollViewDelegate-
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.bigScrollView){
        _segment.currentIndex = self.bigScrollView.contentOffset.x / KScreenW;
    }
}

#pragma mark -lazy-
- (UIScrollView *)bigScrollView{
    if (!_bigScrollView) {
        _bigScrollView = [[UIScrollView alloc] init];
        _bigScrollView.showsVerticalScrollIndicator = NO;
        _bigScrollView.showsHorizontalScrollIndicator = NO;
        _bigScrollView.pagingEnabled = YES;
        _bigScrollView.delegate = self;
    }
    return _bigScrollView;
}

- (UIButton *)addCommumityBtn{
    if (!_addCommumityBtn) {
        _addCommumityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addCommumityBtn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        [_addCommumityBtn addTarget:self action:@selector(addCommunityBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addCommumityBtn;
}

- (UITableView *)communityTableView{
    if (!_communityTableView) {
        _communityTableView = [self createTableView];
    }
    return _communityTableView;
}

- (UITableView *)carFriendsTableView{
    if (!_carFriendsTableView) {
        _carFriendsTableView = [self createTableView];
    }
    return _carFriendsTableView;
}

- (UITableView *)createTableView{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[BFTopImageCell class] forCellReuseIdentifier:topSCrollViewCell];
    [tableView registerClass:[BFCommunityImageCell class] forCellReuseIdentifier:communityImgCell];
    [tableView registerClass:[BFCommunityVideoCell class] forCellReuseIdentifier:communityVideoCell];
    [tableView registerClass:[BFCommunityTextCell class] forCellReuseIdentifier:communityTextCell];
    return tableView;
}

-(void)setUpRightBarbutton {
    //设置导航栏右侧按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"mine"]    forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(0, 0, 30, 30)];
    [btn1 addTarget:self action:@selector(clickMineBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 0, 30, 30)];
    [btn2 addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}

-(void)clickSearchBtn {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要进行搜索吗?" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)clickMineBtn {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要进行个人设置吗?" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

//segment的点击事件
-(void)selectAtIdx:(NSString *)idx with:(NSString *)selectString {
    if ([idx intValue] == 0) {
        NSLog(@"点击的是精品课界面");
        self.bigScrollView.contentOffset = CGPointMake(0, 0);
    }else if ([idx intValue] == 1) {
        NSLog(@"点击的是车资讯界面");
        self.bigScrollView.contentOffset = CGPointMake(KScreenW, 0);
    }
}

- (void)addCommunityBtnClick{
    NSString *loginStatus = GetFromUserDefaults(@"loginStatus");
    if ([loginStatus isEqualToString:@"1"]) { //用户已登录
        BFPublishViewController *publishVC = [BFPublishViewController new];
        [self.segment removeFromSuperview];
        [self.navigationController pushViewController:publishVC animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

// 删除帖子
- (void)deleteCommunity:(NSNotification *)notification{
//    if (self.isViewLoaded && self.view.window) {
//
//    }
    BFCommunityModel *model = notification.object;
    if ([self.communityArray containsObject:model]) {
        NSInteger row = [self.communityArray indexOfObject:model];
        [self.communityArray removeObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row + 1 inSection:0];
        [_communityTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    }else{
        for (BFCommunityModel *tempModel in self.communityArray) {
            if (tempModel.pId == model.pId) {
                NSInteger row = [self.communityArray indexOfObject:tempModel];
                [self.communityArray removeObject:tempModel];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row + 1 inSection:0];
                [_communityTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
                break;
            }
        }
    }
    
}

#pragma mark -搜索-

- (void)leftBtnClick {
    BFSearchCommunityVC *vc = [BFSearchCommunityVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -筛选-

- (void)rightBtnClick:(UIButton *)btn {
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:btn titleArray:@[@"时间",@"热门"] imageArray:@[@"time",@"hot"]];
    menuView.zwPullMenuStyle = PullMenuLightStyle;
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        switch (menuRow) {
            case 0:
                communityCurPage = 1;
                sType = 1;
                [self netWorkRequestWithPage:1 withTableView:self.communityTableView];
                break;
            case 1:
                communityCurPage = 1;
                sType = 2;
                [self netWorkRequestWithPage:1 withTableView:self.communityTableView];
                break;
            default:
                break;
        }
    };
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
