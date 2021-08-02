//
//  BFMyCourseTeaVC.m
//  Bf
//
//  Created by 春晓 on 2018/5/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFMyCourseTeaVC.h"
#import "BFCreateLiveCourseVC.h"
#import "SettingViewController.h"
#import "BFWatchCourseVC.h"

#import "LoadingView.h"
#import "InformationShowView.h"
#import "BFMyCourseHavePubCell.h"


@interface BFMyCourseTeaVC ()<UITableViewDataSource,UITableViewDelegate,BFBFMyCourseHavePubCellDelegate>
// 回放按钮
@property (nonatomic , strong) UIButton *playBackBtn;
// 直播按钮
@property (nonatomic , strong) UIButton *noPlayBtn;
// 底部线
@property (nonatomic , strong) UIView *btnUnderLineView;
// scroll
@property (nonatomic , strong) UIScrollView *scrollView;
// tabel
@property (nonatomic , strong) UITableView *playBackTableView;
// tabel
@property (nonatomic , strong) UITableView *noPlayTableView;
// 导航栏下边的黑线
@property (nonatomic , strong) UIImageView *lineView;
// 0=回放 1=直播
@property (nonatomic , assign) NSInteger play;

// data
// 直播
@property (nonatomic , strong) NSMutableArray *playArray;
// 回放
@property (nonatomic , strong) NSMutableArray *playBackArray;


// 推流参数
// viewerId
@property (nonatomic , strong) NSString *viewerId;
// roomName
@property (nonatomic , strong) NSString *roomName;
// roomId
@property (nonatomic , strong) NSString *roomId;
@property (nonatomic , strong) NSMutableDictionary              *nodeListDic;
// loadingView
@property (nonatomic , strong) LoadingView *loadingView;
// loadingView
@property (nonatomic , strong) InformationShowView *informationView;
@end

static NSString *noPubCell = @"noPubCell";
static NSString *havePubCell = @"havePubCell";

@implementation BFMyCourseTeaVC{
    NSInteger currentPage;
    NSInteger totolPages;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _lineView.hidden = YES;
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [MobClick beginLogPageView:@"教师账号我的课程页"];
    [self getLiveCourseListNetWorkWithStartPage:1];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _lineView.hidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [MobClick endLogPageView:@"教师账号我的课程页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的课程";
    self.view.backgroundColor = [UIColor whiteColor];
    _play = 0;
    _playArray = [NSMutableArray array];
    _playBackArray = [NSMutableArray array];
    [self setupUI];
    
    //获取导航栏下面黑线
    _lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn setTitle:@"+ 创建课程" forState:(UIControlStateNormal)];
    rightBtn.frame = CGRectMake(0, 0, 80, 40);
    [rightBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn addTarget:self action:@selector(createCourse) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rigthItem;
    
    __weak typeof(self) weakSelf = self;
//    self.playBackTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf getLiveCourseListNetWorkWithStartPage:1];
//    }];
//    [self.playBackTableView.mj_header beginRefreshing];
    self.playBackTableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    self.noPlayTableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

//找到导航栏最下面黑线视图
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
}

- (void)setupUI{
    _playBackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_playBackBtn setTitle:@"回放" forState:(UIControlStateNormal)];
    [_playBackBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
    _playBackBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_playBackBtn addTarget:self action:@selector(changesCourseType:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_playBackBtn];

    _noPlayBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_noPlayBtn setTitle:@"直播" forState:(UIControlStateNormal)];
    [_noPlayBtn setTitleColor:RGBColor(102,102,102) forState:(UIControlStateNormal)];
    _noPlayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_noPlayBtn addTarget:self action:@selector(changesCourseType:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_noPlayBtn];

    _btnUnderLineView = [[UIView alloc] init];
    _btnUnderLineView.backgroundColor = RGBColor(51,150,252);
    if (KIsiPhoneX) {
        _btnUnderLineView.frame = CGRectMake(0, 94+24, 14, 3);
    }
    else {
        _btnUnderLineView.frame = CGRectMake(0, 94, 14, 3);
    }
    _btnUnderLineView.centerX = KScreenW / 3.0;
    _btnUnderLineView.layer.masksToBounds = YES;
    _btnUnderLineView.layer.cornerRadius = 1.5;
    [self.view addSubview:_btnUnderLineView];

    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = RGBColor(245,247,250);
    [self.view addSubview:topLineView];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 107, KScreenW, KScreenH - 107)];
    _scrollView.contentSize = CGSizeMake(KScreenW * 2, KScreenH - 107);
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];
    
    _playBackTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 107) style:(UITableViewStylePlain)];
    _playBackTableView.delegate = self;
    _playBackTableView.dataSource = self;
    [_playBackTableView registerClass:[BFMyCourseHavePubCell class] forCellReuseIdentifier:havePubCell];
    _playBackTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_playBackTableView];
    
    _noPlayTableView = [[UITableView alloc] initWithFrame:CGRectMake(KScreenW, 0, KScreenW, KScreenH - 107) style:(UITableViewStylePlain)];
    _noPlayTableView.delegate = self;
    _noPlayTableView.dataSource = self;
    [_noPlayTableView registerClass:[BFMyCourseHavePubCell class] forCellReuseIdentifier:havePubCell];
    _noPlayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_noPlayTableView];
    
    if (KIsiPhoneX) {
        _playBackBtn.sd_layout
        .widthIs(100)
        .heightIs(29)
        .centerXIs(KScreenW / 3.0)
        .topSpaceToView(self.view, 88);
        
        _noPlayBtn.sd_layout
        .widthIs(100)
        .heightIs(29)
        .centerXIs(KScreenW / 3.0 * 2.0)
        .topSpaceToView(self.view, 88);
        
        topLineView.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(self.view, 97+24)
        .heightIs(10);
        
        _scrollView.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(topLineView, 0)
        .bottomEqualToView(self.view);
    }
    else {
        _playBackBtn.sd_layout
        .widthIs(100)
        .heightIs(29)
        .centerXIs(KScreenW / 3.0)
        .topSpaceToView(self.view, 64);
        
        _noPlayBtn.sd_layout
        .widthIs(100)
        .heightIs(29)
        .centerXIs(KScreenW / 3.0 * 2.0)
        .topSpaceToView(self.view, 64);
        
        topLineView.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(self.view, 97)
        .heightIs(10);
        
        _scrollView.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(topLineView, 0)
        .bottomEqualToView(self.view);
    }
        
    

    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _playBackTableView) {
        return _playBackArray.count;
    }else{
        return _playArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView == _noPubTableView) {
//        BFMyCourseNoPubCell *cell = [tableView dequeueReusableCellWithIdentifier:noPubCell forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[BFMyCourseNoPubCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:noPubCell];
//        }
//        cell.delegate = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else{
//        BFMyCourseHavePubCell *cell = [tableView dequeueReusableCellWithIdentifier:havePubCell forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[BFMyCourseHavePubCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:havePubCell];
//        }
//        cell.delegate = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    BFMyCourseHavePubCell *cell = [tableView dequeueReusableCellWithIdentifier:havePubCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[BFMyCourseHavePubCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:havePubCell];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == _playBackTableView) {
        cell.dict = _playBackArray[indexPath.row];
    }else{
        cell.dict = _playArray[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _playBackTableView) {
        NSDictionary *dict = _playBackArray[indexPath.row];
        [self watchVideoAction:dict[@"roomid"] withCid:[dict[@"cid"] integerValue]];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == _playBackTableView) {
//        return UITableViewCellEditingStyleDelete;
//    }else{
//        NSDictionary *dic = _playArray[indexPath.row];
//        NSInteger state = [dic[@"state"] integerValue];
//        if (state == 2) {
//            return UITableViewCellEditingStyleNone;
//        }else{
//            return UITableViewCellEditingStyleDelete;
//        }
//    }
    return UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _playBackTableView) {
        return YES;
    }else{
        NSDictionary *dic = _playArray[indexPath.row];
        NSInteger state = [dic[@"state"] integerValue];
        if (state == 2) {
            return NO;
        }else{
            return YES;
        }
    }
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除这节直播课？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (tableView == _playBackTableView) {
                NSDictionary *dic = _playBackArray[indexPath.row];
                [self deleteLiveCourseNetWorkWithCId:[dic[@"cid"] integerValue] complete:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [_playBackArray removeObjectAtIndex:indexPath.row];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_playBackTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
                            [ZAlertView showSVProgressForSuccess:@"删除成功"];
                        });
                    }else{
                        [ZAlertView showSVProgressForSuccess:@"删除失败"];
                    }
                }];
                
            }else{
                NSDictionary *dic = _playArray[indexPath.row];
                [self deleteLiveCourseNetWorkWithCId:[dic[@"cid"] integerValue] complete:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [_playArray removeObjectAtIndex:indexPath.row];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_noPlayTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
                            [ZAlertView showSVProgressForSuccess:@"删除成功"];
                        });
                    }else{
                        [ZAlertView showSVProgressForSuccess:@"删除失败"];
                    }
                }];
            }
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}
//修改编辑按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//设置进入编辑状态时，Cell不会缩进
//- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}


#pragma mark -已发布按钮和未发布切换-
- (void)changesCourseType:(UIButton *)btn{
    if (btn == _playBackBtn) {// 选择了回放
        if (_play == 1) {
            _play = 0;
            [_playBackBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
            [_noPlayBtn setTitleColor:RGBColor(102,102,102) forState:(UIControlStateNormal)];
            [UIView animateWithDuration:0.1 animations:^{
                _btnUnderLineView.centerX = KScreenW / 3.0;
                _scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
    }else{
        if (_play == 0) {
            _play = 1;
            [_noPlayBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
            [_playBackBtn setTitleColor:RGBColor(102,102,102) forState:(UIControlStateNormal)];
            [UIView animateWithDuration:0.1 animations:^{
                _btnUnderLineView.centerX = KScreenW / 3.0 * 2.0;
                _scrollView.contentOffset = CGPointMake(KScreenW, 0);
            }];
        }
    }
}

#pragma mark -创建直播课-

- (void)createCourse{
    BFCreateLiveCourseVC *vc = [BFCreateLiveCourseVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -BFBFMyCourseHavePubCellDelegate-

- (void)editAction:(BFMyCourseHavePubCell *)cell {
    NSInteger state = [cell.dict[@"state"] integerValue];
    if (state != 2 && state != 3) {
        BFCreateLiveCourseVC *vc = [BFCreateLiveCourseVC new];
        vc.dict = cell.dict;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)publishAction:(BFMyCourseHavePubCell *)cell {
//    BFPlaybackVC *vc = [BFPlaybackVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    _roomId = cell.dict[@"roomid"];
    if (!self.nodeListDic) {
        self.nodeListDic = [NSMutableDictionary dictionary];
    }
    _loadingView = [[LoadingView alloc] initWithLabel:@"正在登录..." centerY:NO];
    [self.view addSubview:_loadingView];
    
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_loadingView layoutIfNeeded];
    PushParameters *parameters = [[PushParameters alloc] init];
    parameters.userId = DWACCOUNT_USERID;
    parameters.roomId = cell.dict[@"roomid"];
    parameters.viewerName = GetFromUserDefaults(@"iNickName");
    parameters.token = @"1";
    parameters.security = NO;
    [[CCPushUtil sharedInstanceWithDelegate:self] loginWithParameters:parameters];
}

#pragma mark - CCPushDelegate

-(void)roomName:(NSString *)roomName {
    NSLog(@"登录成功 roomName = %@",roomName);
    _roomName = roomName;
}
//@optional
/**
 *    @brief    请求成功
 */
-(void)requestLoginSucceedWithViewerId:(NSString *)viewerId {
    NSLog(@"登录成功 viewerId = %@",viewerId);
    self.viewerId = viewerId;
    SaveToUserDefaults(LIVE_USERID,DWACCOUNT_USERID);
    SaveToUserDefaults(LIVE_ROOMID,_roomId);
    SaveToUserDefaults(LIVE_USERNAME,GetFromUserDefaults(@"iNickName"));
    SaveToUserDefaults(LIVE_PASSWORD,@"1");
    
    NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithBool:NO],SET_SCREEN_LANDSCAPE,[NSNumber numberWithBool:YES],SET_BEAUTIFUL,
                                   @"前置摄像头",SET_CAMERA_DIRECTION,
                                   @"360*640",SET_SIZE,
                                   [NSNumber numberWithInteger:450],SET_BITRATE,
                                   [NSNumber numberWithInteger:20],SET_IFRAME,
                                   [NSNumber numberWithInteger:0],SET_SERVER_INDEX,
                                   nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SettingViewController *settingViewController = [[SettingViewController alloc] initWithServerDic:self.nodeListDic viewerId:self.viewerId roomName:_roomName];
    [self.navigationController pushViewController:settingViewController animated:NO];
}

/**
 *    @brief    登录请求失败
 */
-(void)requestLoginFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [_informationView removeFromSuperview];
    _informationView = [[InformationShowView alloc] initWithLabel:message];
    [self.view addSubview:_informationView];
    [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeInformationView) userInfo:nil repeats:NO];
}

-(void)removeInformationView {
    [_informationView removeFromSuperview];
    _informationView = nil;
}

/**
 *    @brief    返回节点列表，节点测速时间，以及最优点索引(从0开始，如果无最优点，随机获取节点当作最优节点)
 */
- (void) nodeListDic:(NSMutableDictionary *)dic bestNodeIndex:(NSInteger)index {
    //    NSLog(@"first---dic = %@,index = %ld",dic,index);
    self.nodeListDic = [dic mutableCopy];
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    SaveToUserDefaults(SET_SERVER_INDEX,[NSNumber numberWithInteger:index]);
}

#pragma mark -network-

- (void)getLiveCourseListNetWorkWithStartPage:(NSInteger)startPage {
    NSString *url = [NSString stringWithFormat:@"%@?uId=%@&startPage=%@",LiveCourseListURL,GetFromUserDefaults(@"uId"),[NSString stringWithFormat:@"%ld",startPage]];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            if (startPage == 1) {
                [_playBackArray removeAllObjects];
                [_playArray removeAllObjects];
            }
            totolPages = [data[@"lastPage"] integerValue];
            currentPage++;
            NSArray *arr = data[@"data"];
            for (NSDictionary *dic in arr) {
                NSInteger state = [dic[@"state"] integerValue];
                if (state == 1 || state == 2 || state == 3) {
                    [_playArray addObject:dic];
                }else{
                    [_playBackArray addObject:dic];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_noPlayTableView reloadData];
                [_playBackTableView reloadData];
            });
        }else{
            
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

- (void)loadMoreData {
    if (currentPage < totolPages) {
        [self getLiveCourseListNetWorkWithStartPage:currentPage + 1];
    }else{
        [_noPlayTableView.mj_footer endRefreshingWithNoMoreData];
        [_playBackTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

// 删除直播调用的方法
- (void)deleteLiveCourseNetWorkWithCId:(NSInteger)cId complete:(void (^)(BOOL isSuccess))complete {
    NSString *url = [NSString stringWithFormat:@"%@?uId=%@&cId=%ld",DeleteLiveCourseURL,GetFromUserDefaults(@"uId"),(long)(long)cId];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            NSLog(@"删除成功");
            complete(YES);
        }else{
            NSLog(@"删除失败");
            complete(NO);
        }
    } failureResponse:^(NSError *error) {
        NSLog(@"删除失败");
        complete(NO);
    }];
}

// 看回放
- (void)watchVideoAction:(NSString *)roomId withCid:(NSInteger)cid{
    BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
    player.playMode = NO;
    player.videoId = roomId;
    player.videos = @[roomId];
    player.isInstroduce = NO;
    player.cid = cid;
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
