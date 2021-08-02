//
//  BFCourseDetailsHadApplyVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCourseDetailsHadApplyVC.h"
#import "BFWatchCourseVC.h"
#import "MBRunTimerView.h"
// 目录
#import "BFCatalogueHeaderView.h"
#import "CLLThreeTreeModel.h"
#import "CLLThreeTreeTableViewCell.h"
#import "ChapterTableViewCell.h"
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"
#import "BFChapterModel.h"
#import "BFLittleChapterModel.h"
#import "BFCatalogueModel.h"

#import "TreeTableView.h"
#import "BFWatchLiveCourseVC.h"
#import "BFTestWatchLiveCourseVC.h"

#import "LoadingView.h"
#import "InformationShowView.h"
#import <AVFoundation/AVFoundation.h>
#import "CCSDK/CCLiveUtil.h"
#import "CCSDK/RequestDataPlayBack.h"
#import "CCSDK/RequestData.h"


@interface BFCourseDetailsHadApplyVC ()<UITableViewDelegate,UITableViewDataSource,TreeTableCellDelegate,RequestDataDelegate>
// 目录
{
    NSInteger currentSection;
    NSInteger currentRow;
    
    NSInteger cid; // 课程Id
    NSInteger cKey; //
    NSMutableArray *roomIdArray;
    NSMutableArray *liveArray;
    NSString *roomId;
    NSString *liveId;
}
// 下方table
@property (nonatomic , strong) UITableView *tableView;
// 目录
//标记section的打开状态
@property (nonatomic, strong) NSMutableArray *sectionOpen;
@property (nonatomic, strong) NSMutableDictionary *cellOpen;

// 头部背景
@property (nonatomic , strong) UIImageView *headBGImageView;
// 进度
@property (nonatomic , strong) MBRunTimerView *runTimerView;
// 课程
@property (nonatomic , strong) UILabel *courseName;
// 继续学习
@property (nonatomic , strong) UILabel *continueLabel;
// 目录
//tableView 显示的数据
@property (nonatomic, strong) NSArray *sectionArray;
// 目录
@property (nonatomic, strong) NSMutableDictionary *catalogueDict;
// <#描述#>
@property (nonatomic , strong) TreeTableView *treeTableView;

@property(nonatomic,strong)LoadingView          *loadingView;
@property(nonatomic,strong)InformationShowView  *informationView;
@property(nonatomic,strong)UILabel              *informationLabel;

@end
// 目录重用ID
static NSString *catalogueHeaderId    = @"catalogueHeaderId";
static NSString *catalogueCellId      = @"catalogueCellId";
@implementation BFCourseDetailsHadApplyVC{
    UILabel *titleLabel;
    UILabel *lineLabel;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"上课页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"上课";
//    [self prepareData];
    if (!roomIdArray) {
        roomIdArray = [NSMutableArray array];
    }
    if (!liveArray) {
        liveArray = [NSMutableArray array];
    }
    
    [self setupUI];
    [self layout];
    [self netWork];
    
    WS(ws);
    [_informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).with.offset(CCGetRealFromPt(40));
        make.top.mas_equalTo(ws.view).with.offset(CCGetRealFromPt(40));
        make.width.mas_equalTo(ws.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(CCGetRealFromPt(24));
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_treeTableView) {
        [_treeTableView relodeData];
    }
//    [MobClick beginLogPageView:@"上课页"];
}

- (void)setupUI{
    _headBGImageView = [[UIImageView alloc] init];
    _headBGImageView.backgroundColor = [UIColor redColor];
    _headBGImageView.image = [UIImage imageNamed:@"上课背景"];
    [self.view addSubview:_headBGImageView];
    
//    self.runTimerView = [[MBRunTimerView alloc] initWithFrame:CGRectMake(30, 30, 100, 100)];
//    self.runTimerView.gradient1 = [UIColor orangeColor];
//    self.runTimerView.gradient2 = [UIColor orangeColor];
//    [self.view addSubview:self.runTimerView];
//    self.runTimerView.center = CGPointMake(KScreenW / 2, 130);
//    [self.runTimerView setProgress:0.4 animated:YES];
    
    _courseName = [[UILabel alloc] init];
    _courseName.textAlignment = NSTextAlignmentCenter;
    if (_myCourseModel) {
        _courseName.text = _myCourseModel.cTitle;
    }else if(_model){
        if ([_model isKindOfClass:[BFCourseModel class]]) {
            BFCourseModel *m = _model;
            _courseName.text = m.ctitle;
        }else{
            BFSetCourseModel *m = _model;
            _courseName.text = m.cstitle;
        }
    }
    _courseName.textColor = [UIColor whiteColor];
    [self.view addSubview:_courseName];
    
    _continueLabel = [[UILabel alloc] init];
    _continueLabel.textColor = [UIColor whiteColor];
    _continueLabel.layer.borderColor = RGBColor(0, 66, 122).CGColor;
    _continueLabel.layer.borderWidth = 1.0f;
    _continueLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
    if (_model && _model.gouke) {
        _continueLabel.text = @"继续学习";
    }else if (_model && !_model.gouke) {
        _continueLabel.text = @"开始学习";
    }
    if (_myCourseModel) {
        _continueLabel.text = @"继续学习";
    }
    _continueLabel.textAlignment = NSTextAlignmentCenter;
    _continueLabel.userInteractionEnabled = YES;
    _continueLabel.layer.masksToBounds = YES;
    _continueLabel.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(continueBtnClick)];
    [_continueLabel addGestureRecognizer:tap];
    [self.view addSubview:_continueLabel];
    
    _treeTableView = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 150, KScreenW, KScreenH - 64 - 150) withData:_dataSource];
    _treeTableView.treeTableCellDelegate = self;
//    [self prepareCatalogueTableView];
    [self.view addSubview:_treeTableView];
    if(@available(iOS 11.0, *)) {
//        self.treeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.treeTableView.contentInset = UIEdgeInsetsMake(-30.,0,0,0);
    }else{
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 50)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"目录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
}

- (void)layout{
    _headBGImageView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.view, 64)
    .rightEqualToView(self.view)
    .heightIs(150);
    
    _courseName.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, 90)
    .heightIs(30);
    
    _continueLabel.sd_layout
    .centerXIs(KScreenW / 2)
    .topSpaceToView(_courseName, 20)
    .widthIs(100)
    .heightIs(30);
    
    titleLabel.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.headBGImageView, 0)
    .rightEqualToView(self.view)
    .heightIs(50);
    
    _treeTableView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(titleLabel, 0)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}


- (void)prepareCatalogueTableView{
    currentRow = -1;
    self.cellOpen = [NSMutableDictionary dictionary];
    
    //去掉tableView的横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[BFCatalogueHeaderView class] forHeaderFooterViewReuseIdentifier:catalogueHeaderId];
    
    [_tableView reloadData];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

#pragma mark -UITableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"章节数：%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFChapterModel *chapterModel = self.dataSource[section];
    if (chapterModel.isShow) {
        //数据决定显示多少行cell
        BFChapterModel *chapterModel = self.dataSource[section];
        //section决定cell的数据
        NSArray *cellArray = chapterModel.child;
        return cellArray.count;
    }else{
        //section是收起状态时候
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChapterTableViewCell *cell = [[ChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.contentView.backgroundColor=[UIColor whiteColor];
    BFChapterModel *chapterModel =self.dataSource[indexPath.section];
    //section决定cell的数据
    NSArray *cellArray = chapterModel.child;
    
    //cell当前的数据
    BFLittleChapterModel *lcModel = cellArray[indexPath.row];
    [cell configureCellWithModel:lcModel];
    //判断cell的位置选择折叠图片
    if (indexPath.row == cellArray.count - 1) {
        if (lcModel.child.count == 0) {
            cell.imageView2.image = [UIImage imageNamed:@""];
        } else {
            if (!lcModel.isShow) {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
            } else {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
            }
        }
        [cell.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    }else{
        if (lcModel.child.count == 0) {
            cell.imageView2.image = [UIImage imageNamed:@""];
        } else {
            if (!lcModel.isShow) {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
            } else {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
            }
        }
        [cell.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    cell.chapterName2.text = chapterModel.ctitle;
    
    if (lcModel.isShow == YES) {
        [cell showTableView];
    } else {
        [cell hiddenTableView];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFChapterModel *chapterModel =self.dataSource[indexPath.section];
    NSArray *cellArray = chapterModel.child;
    //cell当前的数据
    BFLittleChapterModel *lcModel = cellArray[indexPath.row];
    if (lcModel.isShow) {
        return (lcModel.child.count+1)*60;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    currentRow = indexPath.row;
    BFChapterModel *chapterModel =self.dataSource[indexPath.section];
    NSArray *cellArray = chapterModel.child;
    BFLittleChapterModel *lcModel = cellArray[indexPath.row];
    lcModel.isShow = !lcModel.isShow;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BFCatalogueHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:catalogueHeaderId];
    if (!headerView) {
        headerView = [[BFCatalogueHeaderView alloc] initWithReuseIdentifier:catalogueHeaderId];
    }
    headerView.frame = CGRectMake(0, 0, KScreenW, 60);
    BFChapterModel *chapterModel =self.dataSource[section];
    headerView.titleLabel.text = chapterModel.ctitle;
    //点击标题变换图片
    if (chapterModel.isShow) {
        //章节添加横线，选中加阴影
        //直接取出datasource的section,检查返回数据中是否有ksub
        if (chapterModel.child && chapterModel.child.count > 0) {
            headerView.imgView.image = [UIImage imageNamed:@"下拉"];
        }else{
            headerView.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
        }
    }else{
        if (chapterModel.child && chapterModel.child.count > 0) {
            headerView.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
        } else {
            headerView.imgView.image = [UIImage imageNamed:@"下拉"];
        }
    }
    [headerView.openButton addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    //添加TAG
    headerView.openButton.tag = section;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.f;
}

- (void)sectionAction:(UIButton *)button{
    currentSection = button.tag;
    //tableview收起，局部刷新
    BFChapterModel *chapterModel = self.dataSource[currentSection];
    chapterModel.isShow = !chapterModel.isShow;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:currentSection] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)setJsonDic:(NSDictionary *)jsonDic{
    self.dataSource = jsonDic[@"dataList"];
    //    self.sectionOpen = [NSMutableArray array];
    //    for (NSInteger i = 0; i < self.dataSource.count; i++) {
    //        [self.sectionOpen addObject:@0];
    //    }
    for (NSDictionary *dic1 in self.dataSource) {
        NSArray *arr2 = dic1[@"child"];
        for (NSDictionary *dic2 in arr2) {
            NSString *key = [NSString stringWithFormat:@"%@", dic2[@"cid"]];
            CLLThreeTreeModel *model = [CLLThreeTreeModel mj_objectWithKeyValues:dic2];
            model.isShow = NO;
            [self.cellOpen setValue:model forKey:key];
        }
    }
    [self.tableView reloadData];
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    //    self.sectionOpen = [NSMutableArray array];
    //    for (NSInteger i = 0; i < self.dataSource.count; i++) {
    //        [self.sectionOpen addObject:@0];
    //    }
    for (BFChapterModel *model in self.dataSource) {
        model.isShow = NO;
        NSArray *arr2 = model.child;
        if (arr2 && arr2.count > 0) {
            for (BFLittleChapterModel *lcModel in arr2) {
                NSString *key = [NSString stringWithFormat:@"%ld",lcModel.cid];
                lcModel.isShow = NO;
                [self.cellOpen setValue:lcModel forKey:key];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)continueBtnClick{
    if (cKey == 1 || cKey == 2) {
        if (_model && _model.gouke == 0) {
            [self videoWatchNetWork];
        }
        if (roomIdArray && roomIdArray.count > 0) {
            [self watchVideoAction:roomIdArray[0]];
        }else{
            NSLog(@"没有roomId");
        }
    }else{
        if (liveArray && liveArray) {
            [self liveAction:liveArray[0]];
        }else{
            NSLog(@"没有roomId");
        }
    }
}

- (void)watchVideoAction:(NSString *)roomId{
    BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
    player.playMode = NO;
    player.videoId = roomId;
    player.videos = roomIdArray;
    player.catalogueDic = _catalogueDict;;
    player.isInstroduce = NO;
    player.canClick = YES;
    player.indexpath = 0;
    [self.navigationController pushViewController:player animated:YES];
}

- (void)liveAction:(NSString *)roomId{
    PlayParameter *parameter = [[PlayParameter alloc] init];
    parameter.userId = DWACCOUNT_USERID;
    parameter.roomId = liveId;
    parameter.viewerName = @"";
    parameter.token = @"";
    parameter.security = NO;
    parameter.viewerCustomua = @"viewercustomua";
    RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
    requestData.delegate = self;
}

- (void)setModel:(id)model{
    _model = model;
    if ([model isKindOfClass:[BFCourseModel class]]) {
        cid = ((BFCourseModel *)model).cid;
        cKey = ((BFCourseModel *)model).ckey;
//        if (((BFCourseModel *)model).roomid) {
//            [roomIdArray addObject:((BFCourseModel *)model).roomid];
//            roomId = ((BFCourseModel *)model).roomid;
//        }
    }else{
        cid = ((BFSetCourseModel *)model).csid;
        cKey = ((BFSetCourseModel *)model).ckey;
    }
}

- (void)setMyCourseModel:(BFMyCourseModel *)myCourseModel{
    _myCourseModel = myCourseModel;
    cid = _myCourseModel.cId;
    cKey = _myCourseModel.csKey;
    _courseName.text = _myCourseModel.cTitle;
}

- (void)netWork{
    NSString *url = [NSString stringWithFormat:@"%@?cSId=%ld",CourseDirectoryURL,cid];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSArray *AList = dic[@"AList"];
        NSArray *BList = dic[@"BList"];
        NSArray *CList = dic[@"CList"];
        if (!_dataSource) {
            _dataSource = [NSMutableArray array];
        }
        if (!_catalogueDict) {
            _catalogueDict = [NSMutableDictionary dictionary];
        }
        NSMutableArray *alist = [NSMutableArray array];
        NSMutableArray *blist = [NSMutableArray array];
        NSMutableArray *clist = [NSMutableArray array];
        for (NSDictionary *dA in AList) {// 章
            BFCatalogueModel *catalogueModel = [BFCatalogueModel mj_objectWithKeyValues:dA];
            catalogueModel.isShow = YES;
            catalogueModel.isExpand = 0;
            catalogueModel.chapterType = ChapterType_Chapter;
            catalogueModel.parentId = 0;
            [_dataSource addObject:catalogueModel];
            [alist addObject:catalogueModel];
        }
        for (NSDictionary *dB in BList) {// 节
            BFCatalogueModel *catalogueModel = [BFCatalogueModel mj_objectWithKeyValues:dB];
            catalogueModel.isShow = NO;
            catalogueModel.chapterType = ChapterType_LittleChapter;
            catalogueModel.parentId = catalogueModel.cTType;
            catalogueModel.isExpand = NO;
            [_dataSource addObject:catalogueModel];
            [blist addObject:catalogueModel];
        }
        for (NSDictionary *dC in CList) {// 课
            BFCatalogueModel *catalogueModel = [BFCatalogueModel mj_objectWithKeyValues:dC];
            catalogueModel.isShow = NO;
            catalogueModel.chapterType = ChapterType_Course;
            catalogueModel.parentId = catalogueModel.cMinId;
            catalogueModel.isExpand = NO;
            catalogueModel.isSelect = NO;
            catalogueModel.cTId = -1;
            [_dataSource addObject:catalogueModel];
            [clist addObject:catalogueModel];
            if (catalogueModel.cKey == 0) {// 直播
                if (catalogueModel.roomId) {
                    [liveArray addObject:catalogueModel.roomId];
                }
            }else if (catalogueModel.cKey == 1){// 回放
                if (catalogueModel.roomId) {
                    [roomIdArray addObject:catalogueModel.roomId];
                }
            }else if (catalogueModel.cKey == 2){// 视频
                if (catalogueModel.roomId) {
                    [roomIdArray addObject:catalogueModel.roomId];
                }
            }
            if (roomIdArray.count > 0) {
                roomId = roomIdArray[0];
            }
            if (liveArray.count > 0) {
                liveId = liveArray[0];
            }
        }
        [_catalogueDict setValue:alist forKey:@"AList"];
        [_catalogueDict setValue:blist forKey:@"BList"];
        [_catalogueDict setValue:clist forKey:@"CList"];
        dispatch_async(dispatch_get_main_queue(), ^{
            _treeTableView.dataDict = _catalogueDict;
        });
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - TreeTableCellDelegate
-(void)cellClick:(BFCatalogueModel *)node{
    NSLog(@"%@",node);
    if (node.chapterType == ChapterType_Course) {
        if (node.cKey == 1 || node.cKey == 2) {
            if (_model && _model.gouke == 0) {
                [self videoWatchNetWork];
            }
            if (node.roomId) {
                [self watchVideoAction:node.roomId];
                roomId = node.roomId;
            }else{
                NSLog(@"没有roomId");
            }
        }else{
            if (node.roomId) {
                [self liveAction:node.roomId];
                liveId = node.roomId;
            }else{
                NSLog(@"没有roomId");
            }
        }
    }
}

// 直播报名
- (void)videoWatchNetWork{
    NSString *url = [NSString stringWithFormat:@"%@?cIid=%ld&uId=%@&buyStates=%ld&rcstate=%d",CourseBuyURL,cid,GetFromUserDefaults(@"uId"),_model.gouke,1];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            _model.gouke = 1;
        }else{
            
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - CCPushDelegate
//@optional
/**
 *    @brief    请求成功
 */
-(void)loginSucceedPlay {
    SaveToUserDefaults(WATCH_USERID,DWACCOUNT_USERID);
    SaveToUserDefaults(WATCH_ROOMID,liveId);
    SaveToUserDefaults(WATCH_USERNAME,@"");
    SaveToUserDefaults(WATCH_PASSWORD,@"");
    
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    //    PlayForMobileVC *playForMobileVC = [[PlayForMobileVC alloc] initWithLeftLabelText:_roomName isScreenLandScape:YES];
    [UIApplication sharedApplication].idleTimerDisabled=YES;
//    BFWatchLiveCourseVC *vc = [[BFWatchLiveCourseVC alloc] initWithLeftLabelText:@""];
//    [self presentViewController:vc animated:YES completion:nil];
    BFTestWatchLiveCourseVC *vc = [[BFTestWatchLiveCourseVC alloc] initWithLeftLabelText:@""];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:YES completion:nil];
//    PlayForPCVC *playForPCVC = [[PlayForPCVC alloc] initWithLeftLabelText:_roomName];
//    [self presentViewController:playForPCVC animated:YES completion:nil];
}

/**
 *    @brief    登录请求失败
 */
-(void)loginFailed:(NSError *)error reason:(NSString *)reason {
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
