//
//  BFCourseDetailsVC.m
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCourseDetailsVC.h"
#import "BFCourseDetailsHadApplyVC.h"
#import "BFChatViewController.h"
#import "BFQCXSlideView.h"
#import <MBProgressHUD.h>
#import "BFEditEvaluateVC.h"
#import "BFCourseDetailsTopModel.h"
#import "BFCourseDetailsTeachers.h"

#import "BFCourseDetailsTopCell.h"
#import "BFCDTeacherRoleCell.h"
#import "BFCourseDetailsTeacherCell.h"
#import "BFCourseBottomCell.h"
#import "BFWatchCourseVC.h"
#import "BFCommunityWatchVideoVC.h"
#import "UILabel+MBCategory.h"
#import "BFSlideViewBar.h"
#import "BFTopImageCell.h"
// 目录
#import "CLLThreeTreeModel.h"
#import "BFChapterModel.h"
#import "BFLittleChapterModel.h"
#import "BFCatalogueModel.h"
#import "BFCatalogueCell.h"
// 评价
#import "BFCourseEvaluateModel.h"
#import "BFCourseEvaluateReplyModel.h"
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"
#import "BFEvaluateCell.h"
#import "BFEvaluateReplyCell.h"



@interface BFCourseDetailsVC ()<UITableViewDelegate,UITableViewDataSource,BFSlideViewBarDelegate>
// 目录
{
    NSInteger currentSection;
    NSInteger currentRow;
}

// 最外层大的tableView
@property (nonatomic , strong) UITableView *bigTableView;
// 顶部slideViewBar
@property (nonatomic , strong) BFSlideViewBar *slideViewBar;
// 报名按钮
@property (nonatomic , strong) UIButton *joinBtn;

// 第一个cell的数据
@property (nonatomic , strong) BFCourseDetailsTopModel *courseDetailsTopModel;
// 授课老师
@property (nonatomic , strong) NSMutableArray *teachersArray;
// 辅导老师
@property (nonatomic , strong) BFCourseDetailsTeachers *helpTeacher;
// 视图数组
@property (nonatomic , strong) NSMutableArray *viewArray;

// 讲师展开关闭
@property (assign, nonatomic) BOOL isExpand; //是否展开
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;//展开的cell的下

// 目录
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic , strong) NSMutableArray *tempData;//用于存储数据源（部分数据）
// 目录
@property (nonatomic, strong) NSMutableArray *catalogueArray;
// 目录
@property (nonatomic, strong) NSMutableDictionary *catalogueDict;
// 评价
@property (nonatomic , strong) NSMutableArray *evaluateArray;
// 高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *cacheDict;
// 回复高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *replyscacheDict;
@end

// 最外层大tableviewcell的重用ID
static NSString *courseDetailsTopCell = @"CourseDetailsTopCell";
static NSString *CDTeacherRoleCell    = @"CDTeacherRoleCell";
static NSString *teacherCell          = @"teacherCell";
static NSString *bottomCell           = @"bottomCell";
static NSString *lineViewCell         = @"lineViewCell";
static NSString *catalogueCell        = @"catalogueCell";
static NSString *introduceCell        = @"IntroduceCell";
static NSString *evaluateCellId       = @"evaluateCellId";
static NSString *evaluateReplyCellId  = @"evaluateReplyCellId";
static NSString *topImageCellId       = @"topImageCellId";

#define BottomViewHeight 55
@implementation BFCourseDetailsVC{
    NSDictionary *jsonDic;
    NSInteger videoOrLive; // 0=直播/1=视频(录播)
    BOOL isCollection;
    BOOL isApply;
    NSInteger cid; // 课程系列的Id
    //    NSInteger ckey;
    NSInteger cistate;// 是系列课程还是单课 0=单课/1=系列
    MBProgressHUD *HUD;
    NSInteger collectionStatic;// 是否收藏的状态（0为已收藏，1为未收藏）
    UIButton *btn2;// 收藏按钮
    UIButton *btn3;// 分享按钮
    NSInteger gouke;//
    NSInteger cnum;// 人数
    NSString *descriptionStr;// 简介
    CGFloat _oldY;
    
    BOOL haveTeachers;
    BOOL haveIntroduce;
    BOOL haveCatalogue;
    BOOL haveEvaluate;
    
    NSArray *AList;
    NSArray *BList;
    NSArray *CList;
    
    NSMutableArray *roomIdArray;
    NSMutableArray *liveArray;
    NSString *roomId;
    NSString *liveId;
    
    NSMutableDictionary *indexPathDic;
    
    BOOL isDrag; // 是否是拖拽
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"课程详情页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"课程详情页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    haveTeachers = NO;
    haveIntroduce = NO;
    haveCatalogue = NO;
    haveEvaluate = NO;
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(0, 0, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"评论"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(commentBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn2.frame = CGRectMake(0, 0, 30, 30);
    [btn2 setImage:[UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 30, 30);
    [btn3 setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    [btn3 addTarget:self action:@selector(ShareAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3];
    
    if (_isFromOtherApp) {
        [self sxcNetwork];
    }else{
        [self prepareData];
    }
    
}



- (void)prepareData{
    if ([_model isKindOfClass:[BFCourseModel class]]) {
        BFCourseModel *m = _model;
        videoOrLive = m.ckey;
        gouke = m.gouke;
        cnum = m.cnum;
    }else {
        BFSetCourseModel *m = _model;
        videoOrLive = m.ckey;
        gouke = m.gouke;
        cnum = m.cnum;
    }
    [self getEvaluateNetWork];
    [self netWork];
    [self setupUI];
    
    self.joinBtn.enabled = NO;
    btn2.enabled = NO;
    
    _teachersArray = [NSMutableArray array];
    _evaluateArray = [NSMutableArray array];
    indexPathDic   = [NSMutableDictionary dictionary];
    if ([_model isKindOfClass:[BFCourseModel class]]) {
        cid = ((BFCourseModel *)_model).cid;
        cistate = ((BFCourseModel *)_model).cstate;
    }else if ([_model isKindOfClass:[BFSetCourseModel class]]) {
        cid = ((BFSetCourseModel *)_model).csid;
        cistate = ((BFSetCourseModel *)_model).cstate;
    }
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?ckey=%ld&ciid=%ld&uid=%@",CourseCatalogueURL,videoOrLive,cid,GetFromUserDefaults(@"uId")];
    }else{
        url = [NSString stringWithFormat:@"%@?ckey=%ld&ciid=%ld&uid=%@",CourseCatalogueURL,videoOrLive,cid,@"0"];
    }
    
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        jsonDic = data;
        NSArray *teacherArray = jsonDic[@"result"];
        for (NSDictionary *dict in teacherArray) {// 老师
            BFCourseDetailsTeachers *tea = [BFCourseDetailsTeachers initWithDict:dict];
            [_teachersArray addObject:tea];
        }
        haveTeachers = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_model isKindOfClass:[BFCourseModel class]]) {
                BFCourseModel *m = _model;
                NSString *str = GetFromUserDefaults(@"loginStatus");
                if ([str isEqualToString:@"1"]) { //用户已登录
                    m.sc = [jsonDic[@"top"][@"sc"] integerValue];
                    collectionStatic = m.sc;
                    m.gouke = [jsonDic[@"top"][@"gouke"] integerValue];
                    m.descriptionStr = [self flattenHTML:[NSString stringWithFormat:@"%@",jsonDic[@"mapssMap"][@"cidesc"]]];
                    haveIntroduce = YES;
                    descriptionStr = m.descriptionStr;
                    [btn2 setImage:m.sc ? [UIImage imageNamed:@"收藏成功"] : [UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
                    if (m.ckey) {// 视频
                        [_joinBtn setTitle:@"开始上课" forState:(UIControlStateNormal)];
                    }else{// 直播
                        [_joinBtn setTitle:m.gouke ? @"已报名" : @"开始报名" forState:(UIControlStateNormal)];
                        if (cnum == 0) {
                            [_joinBtn setTitle:@"已经报满" forState:(UIControlStateNormal)];
                        }
                    }
                    isCollection = m.sc;
                    isApply = m.gouke;
                }else{
                    m.descriptionStr = [self flattenHTML:[NSString stringWithFormat:@"%@",jsonDic[@"mapssMap"][@"cidesc"]]];
                    descriptionStr = m.descriptionStr;
                    if (m.ckey) {// 视频
                        [_joinBtn setTitle:@"开始上课" forState:(UIControlStateNormal)];
                    }else{// 直播
                        [_joinBtn setTitle:@"开始报名" forState:(UIControlStateNormal)];
                        if (cnum == 0) {
                            [_joinBtn setTitle:@"已经报满" forState:(UIControlStateNormal)];
                        }
                    }
                }
                
                
            }else if([_model isKindOfClass:[BFSetCourseModel class]]){
                BFSetCourseModel *m = _model;
                m.sc = [jsonDic[@"top"][@"sc"] integerValue];
                collectionStatic = m.sc;
                m.gouke = [jsonDic[@"top"][@"gouke"] integerValue];
                m.descriptionStr = [self flattenHTML:[NSString stringWithFormat:@"%@",jsonDic[@"mapssMap"][@"cidesc"]]];
                descriptionStr = m.descriptionStr;
                [btn2 setImage:m.sc ? [UIImage imageNamed:@"收藏成功"] : [UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
                if (m.ckey) {// 视频
                    [_joinBtn setTitle:@"开始上课" forState:(UIControlStateNormal)];
                }else{// 直播
                    [_joinBtn setTitle:m.gouke ? @"已报名" : @"开始报名" forState:(UIControlStateNormal)];
                    if (cnum == 0) {
                        [_joinBtn setTitle:@"已经报满" forState:(UIControlStateNormal)];
                    }
                }
                isCollection = m.sc;
                isApply = m.gouke;
            }
            [_bigTableView reloadData];
            self.joinBtn.enabled = YES;
            btn2.enabled = YES;
        });
    } failureResponse:^(NSError *error) {
        
    }];
}

// 得到评论
- (void)getEvaluateNetWork{
    NSString *url = [NSString stringWithFormat:@"%@?cistate=%ld&ciid=%ld",CoursesGetEvaluateURL,cistate,cid];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSArray *arr = data;
        [_evaluateArray removeAllObjects];
        for (NSDictionary *dict in arr) {// 评论
            BFCourseEvaluateModel *evaluateModel = [BFCourseEvaluateModel initWithDict:dict];
            NSLog(@"%@",evaluateModel);
            [_evaluateArray addObject:evaluateModel];
        }
        haveEvaluate = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_bigTableView reloadData];
        });
    } failureResponse:^(NSError *error) {
        
    }];
}

// 目录
- (void)netWork{
    NSString *url = [NSString stringWithFormat:@"%@?cSId=%ld",CourseDirectoryURL,_model.cid];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        AList = dic[@"AList"];
        BList = dic[@"BList"];
        CList = dic[@"CList"];
        if (!_catalogueArray) {
            _catalogueArray = [NSMutableArray array];
        }
        if (!_catalogueDict) {
            _catalogueDict = [NSMutableDictionary dictionary];
        }
        if (!_tempData) {
            _tempData = [NSMutableArray array];
        }
        if (!roomIdArray) {
            roomIdArray = [NSMutableArray array];
        }
//        if (!liveArray) {
//            liveArray = [NSMutableArray array];
//        }
        NSMutableArray *alist = [NSMutableArray array];
        NSMutableArray *blist = [NSMutableArray array];
        NSMutableArray *clist = [NSMutableArray array];
        for (NSDictionary *dA in AList) {// 章
            BFCatalogueModel *catalogueModel = [BFCatalogueModel mj_objectWithKeyValues:dA];
            catalogueModel.isShow = YES;
            catalogueModel.isExpand = 0;
            catalogueModel.chapterType = ChapterType_Chapter;
            catalogueModel.parentId = 0;
            catalogueModel.commonId = catalogueModel.ctype;
            [_tempData addObject:catalogueModel];
            [_catalogueArray addObject:catalogueModel];
            [alist addObject:catalogueModel];
        }
        for (NSDictionary *dB in BList) {// 节
            BFCatalogueModel *catalogueModel = [BFCatalogueModel mj_objectWithKeyValues:dB];
            catalogueModel.isShow = NO;
            catalogueModel.chapterType = ChapterType_LittleChapter;
            catalogueModel.parentId = catalogueModel.cTType;
            catalogueModel.isExpand = NO;
            [_catalogueArray addObject:catalogueModel];
            [blist addObject:catalogueModel];
        }
        for (NSDictionary *dC in CList) {// 课
            BFCatalogueModel *catalogueModel = [BFCatalogueModel mj_objectWithKeyValues:dC];
            catalogueModel.isShow = NO;
            catalogueModel.chapterType = ChapterType_Course;
            catalogueModel.parentId = catalogueModel.cMinId;
            catalogueModel.isExpand = NO;
            catalogueModel.cTId = -1;
            [_catalogueArray addObject:catalogueModel];
            [clist addObject:catalogueModel];
            
            if (catalogueModel.cKey == 2){// 视频
                if (catalogueModel.roomId) {
                    [roomIdArray addObject:catalogueModel.roomId];
                }
            }
            if (roomIdArray.count > 0) {
                roomId = roomIdArray[0];
            }
            
        }
        [_catalogueDict setValue:alist forKey:@"AList"];
        [_catalogueDict setValue:blist forKey:@"BList"];
        [_catalogueDict setValue:clist forKey:@"CList"];
        haveCatalogue = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_bigTableView reloadData];
        });
        
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark 过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    
    //  过滤html标签
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@"\n"];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    //    NSMutableString *str1 = [NSMutableString stringWithString:html];
    //    for (int i = 0; i < str1.length; i++) {
    //        unichar c = [str1 characterAtIndex:i];
    //        NSRange range = NSMakeRange(i, 1);
    //
    //        //  在这里添加要过滤的特殊符号
    //        if ( c == '\r' || c == '\n' || c == '\t' ) {
    //            [str1 deleteCharactersInRange:range];
    //            --i;
    //        }
    //    }
    //    html  = [NSString stringWithString:str1];
    return html;
}

- (void)setupUI{
    _bigTableView = [[UITableView alloc] init];
    [self.view addSubview:_bigTableView];
    _bigTableView.delegate = self;
    _bigTableView.dataSource = self;
    [_bigTableView registerClass:[BFCourseDetailsTopCell class] forCellReuseIdentifier:courseDetailsTopCell];
    [_bigTableView registerClass:[BFCDTeacherRoleCell class] forCellReuseIdentifier:CDTeacherRoleCell];
    [_bigTableView registerClass:[BFCourseDetailsTeacherCell class] forCellReuseIdentifier:teacherCell];
    [_bigTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:lineViewCell];
    [_bigTableView registerClass:[BFCatalogueCell class] forCellReuseIdentifier:catalogueCell];
    [_bigTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:introduceCell];
    [_bigTableView registerClass:[BFTopImageCell class] forCellReuseIdentifier:topImageCellId];
    [_bigTableView registerClass:[BFEvaluateCell class] forCellReuseIdentifier:evaluateCellId];
    [_bigTableView registerClass:[BFEvaluateReplyCell class] forCellReuseIdentifier:evaluateReplyCellId];
    _bigTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _bigTableView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(KScreenH - BottomViewHeight);
    
    _slideViewBar = [[BFSlideViewBar alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 50)];
    [self.view addSubview:_slideViewBar];
    _slideViewBar.delegate = self;
    _slideViewBar.hidden = YES;
    _slideViewBar.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, KNavHeight)
    .heightIs(50);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UIImageView *iconImageVIew = [[UIImageView alloc] init];
    iconImageVIew.image = [UIImage imageNamed:@"咨询"];
    iconImageVIew.contentMode = UIViewContentModeScaleAspectFit;
    [bottomView addSubview:iconImageVIew];
    UILabel *chatLabel = [[UILabel alloc] init];
    chatLabel.text = @"咨询";
    chatLabel.font = [UIFont systemFontOfSize:10];
    chatLabel.textColor = RGBColor(51, 51, 51);
    chatLabel.userInteractionEnabled = YES;
    [bottomView addSubview:chatLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chatAction)];
    [chatLabel addGestureRecognizer:tap];
    UIButton *tryToPlayBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [tryToPlayBtn setTitle:@"体验直播" forState:(UIControlStateNormal)];
    [tryToPlayBtn setBackgroundColor:RGBColor(35, 184, 255)];
    [tryToPlayBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [tryToPlayBtn addTarget:self action:@selector(tryToPlayBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    tryToPlayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bottomView addSubview:tryToPlayBtn];
    tryToPlayBtn.hidden = YES;
    _joinBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_joinBtn setBackgroundColor:RGBColor(0, 126, 212)];
    [_joinBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _joinBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_joinBtn addTarget:self action:@selector(joinBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_joinBtn];
    if (videoOrLive) {// 视频
        [_joinBtn setTitle:@"开始上课" forState:(UIControlStateNormal)];
    }else{// 直播
        [_joinBtn setTitle:@"立即报名" forState:(UIControlStateNormal)];
    }
    UIFont *font = [UIFont systemFontOfSize:17];
    chatLabel.font = font;
    tryToPlayBtn.titleLabel.font = font;
    _joinBtn.titleLabel.font = font;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineView];
    
    bottomView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(BottomViewHeight);
    
    lineView.sd_layout
    .leftEqualToView(bottomView)
    .rightEqualToView(bottomView)
    .topEqualToView(bottomView)
    .heightIs(0.5f);
    
    iconImageVIew.sd_layout
    .leftSpaceToView(bottomView, PXTOPT(44))
    .topSpaceToView(bottomView, PXTOPT(38))
    .widthIs(20)
    .heightIs(20);
    
    chatLabel.sd_layout
    .leftSpaceToView(iconImageVIew, PXTOPT(14))
    .topSpaceToView(bottomView, PXTOPT(32))
    .widthIs(80)
    .heightIs(25);
    
    _joinBtn.sd_layout
    .rightEqualToView(bottomView)
    .topEqualToView(bottomView)
    .widthIs(100)
    .bottomEqualToView(bottomView);
    
    tryToPlayBtn.sd_layout
    .rightSpaceToView(_joinBtn, 0)
    .topEqualToView(bottomView)
    .widthIs(100)
    .bottomEqualToView(bottomView);
    
    
}

- (void)chatAction{// 聊天
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        BFChatViewController *chatVC = [BFChatViewController new];
        [self.navigationController pushViewController:chatVC animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)tryToPlayBtnClick{// 体验直播
    //    NSString *str = GetFromUserDefaults(@"loginStatus");
    //    if ([str isEqualToString:@"1"]) { //用户已登录
    //
    //    }
    //    else {
    //        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
    //        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
    //        [self presentViewController:navigation animated:YES completion:nil];
    //    }
    if (_model.cvideo) {
        BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
        player.playMode = NO;
        player.videoId = _model.cvideo;
        player.videos = @[_model.cvideo];
        player.indexpath = 0;
        player.dataSource = self.dataSource;
        player.canClick = NO;
        player.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:player animated:YES];
    }
}

- (void)joinBtnClick{// 立即报名
    NSString *checkStr = GetFromUserDefaults(@"checkVersion");
    if ([checkStr isEqualToString:@"1"]) {
        if (videoOrLive) {// 视频
            BFCourseDetailsHadApplyVC *vc = [BFCourseDetailsHadApplyVC new];
            vc.model = _model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{// 直播
            if (gouke == 0) {
                if (cnum != 0) {
                    [self liveApplyNetWork];
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_joinBtn setTitle:@"已经报满" forState:(UIControlStateNormal)];
                        UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"已经报满" preferredStyle:(UIAlertControllerStyleAlert)];
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_joinBtn setTitle:@"已报名" forState:(UIControlStateNormal)];
                    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"已报名，请到我的课程中查看" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }
        }
    }
    else {
        NSString *str = GetFromUserDefaults(@"loginStatus");
//        if ([str isEqualToString:@"1"]) { //用户已登录
            if (videoOrLive) {// 视频
                BFCourseDetailsHadApplyVC *vc = [BFCourseDetailsHadApplyVC new];
                vc.model = _model;
                [self.navigationController pushViewController:vc animated:YES];
            }else{// 直播
                if (gouke == 0) {
                    if (cnum != 0) {
                        [self liveApplyNetWork];
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_joinBtn setTitle:@"已经报满" forState:(UIControlStateNormal)];
                            UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"已经报满" preferredStyle:(UIAlertControllerStyleAlert)];
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            [alert addAction:action];
                            [self presentViewController:alert animated:YES completion:nil];
                        });
                    }
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_joinBtn setTitle:@"已报名" forState:(UIControlStateNormal)];
                        UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"已报名，请到我的课程中查看" preferredStyle:(UIAlertControllerStyleAlert)];
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
            }
//        }
//        else {
//            BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//            [self presentViewController:navigation animated:YES completion:nil];
//        }
    }
}

// 直播报名
- (void)liveApplyNetWork{
    NSString *url = [NSString stringWithFormat:@"%@?cIid=%ld&uId=%@&buyStates=%ld&rcstate=%d",CourseBuyURL,cid,GetFromUserDefaults(@"uId"),gouke,1];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            if (videoOrLive) {// 视频
                
            }else{// 直播
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_joinBtn setTitle:@"已报名" forState:(UIControlStateNormal)];
                    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"已报名，请到我的课程中查看" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                });
            }
            BFCourseModel *mo = _model;
            mo.gouke = 1;
        }else{
            if (videoOrLive) {// 视频
                
            }else{// 直播
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"报名失败" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }
        }
    } failureResponse:^(NSError *error) {
        if (videoOrLive) {// 视频
            
        }else{// 直播
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"提示" message:@"报名失败" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
}

#pragma mark -UItableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5 + _evaluateArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){// 老师
        if (_teachersArray.count <= 2) {
            return _teachersArray.count;
        }else{
            if (self.isExpand == YES) {
                return _teachersArray.count;
            }
            return 1;
        }
    }else if (section == 2){// 介绍
        return 3;
    }else if (section == 3){// 目录
        return _tempData.count;
    }else if (section == 4){// 评价
        return 1;
    }else{
        BFEvaluateModel *model = _evaluateArray[section - 5];
        return model.replys.count > 0 ? 2 : 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BFTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:topImageCellId forIndexPath:indexPath];
            if (!cell){
                cell = [[BFTopImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topImageCellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imgView.image = _topImage;
            return cell;
        }else{
            BFCourseDetailsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:courseDetailsTopCell forIndexPath:indexPath];
            if (!cell){
                cell = [[BFCourseDetailsTopCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:courseDetailsTopCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.courseModel = _model;
            return cell;
        }
    }else if (indexPath.section == 1){
        if (_teachersArray.count > 2) {
            if (self.isExpand == YES) {// 如果是展开的情况
                if (indexPath.row == 0) {
                    BFCDTeacherRoleCell *cell = [tableView dequeueReusableCellWithIdentifier:CDTeacherRoleCell forIndexPath:indexPath];
                    if (!cell){
                        cell = [[BFCDTeacherRoleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CDTeacherRoleCell];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.teacher = _teachersArray[0];
                    return cell;
                }else{
                    BFCourseDetailsTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:teacherCell forIndexPath:indexPath];
                    if (!cell){
                        cell = [[BFCourseDetailsTeacherCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:teacherCell];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.teacher = _teachersArray[indexPath.row];
                    return cell;
                }
            }else{
                BFCDTeacherRoleCell *cell = [tableView dequeueReusableCellWithIdentifier:CDTeacherRoleCell forIndexPath:indexPath];
                if (!cell){
                    cell = [[BFCDTeacherRoleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CDTeacherRoleCell];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.teachersArray = _teachersArray;
                return cell;
            }
        }else{
            if (indexPath.row == 0) {
                BFCDTeacherRoleCell *cell = [tableView dequeueReusableCellWithIdentifier:CDTeacherRoleCell forIndexPath:indexPath];
                if (!cell){
                    cell = [[BFCDTeacherRoleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CDTeacherRoleCell];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.teacher = _teachersArray[0];
                return cell;
            }else if (_teachersArray.count == 2 && indexPath.row > 0 && indexPath.row <= _teachersArray.count - 1) {
                BFCourseDetailsTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:teacherCell forIndexPath:indexPath];
                if (!cell){
                    cell = [[BFCourseDetailsTeacherCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:teacherCell];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.teacher = _teachersArray[1];
                return cell;
            }else{
                return nil;
            }
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0 || indexPath.row == 2) {
            if (indexPath.row == 0) {
                [indexPathDic setValue:indexPath forKey:introduceCell];
            }else{
                [indexPathDic setValue:indexPath forKey:catalogueCell];
            }
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lineViewCell forIndexPath:indexPath];
            if (!cell){
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:lineViewCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = RGBColor(240, 240, 240);
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:introduceCell forIndexPath:indexPath];
            if (!cell){
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:introduceCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont fontWithName:BFfont size:15];
            cell.textLabel.textColor = RGBColor(153, 153, 153);
            if (descriptionStr) {
                cell.textLabel.text = descriptionStr;
                [UILabel changeSpaceForLabel:cell.textLabel withLineSpace:5 WordSpace:1];
            }else{
                cell.textLabel.text = @"暂无介绍";
            }
            //            cell.catalogueDict = _catalogueDict;
            //            cell.evaluateArray = _evaluateArray;
            //            cell.descriptionStr = descriptionStr;
            return cell;
        }
    }else if (indexPath.section == 3){
        BFCatalogueCell *cell = [tableView dequeueReusableCellWithIdentifier:catalogueCell];
        if (!cell) {
            cell = [[BFCatalogueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:catalogueCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BFCatalogueModel *node = [_tempData objectAtIndex:indexPath.row];
        cell.chapterType = node.chapterType;
        if (node.chapterType == ChapterType_Chapter ||node.chapterType ==  ChapterType_LittleChapter) {
            cell.chapterName2.text = node.cTTitle;
            if (node.isExpand) {
                if (node.chapterType == ChapterType_Chapter) {
                    cell.imgView.image = [UIImage imageNamed:@"下拉"];
                    cell.chapterName2.font = [UIFont fontWithName:BFfont size:15];
                }else if (node.chapterType == ChapterType_LittleChapter){
                    cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
                    cell.chapterName2.font = [UIFont fontWithName:BFfont size:14];
                }
            }else{
                if (node.chapterType == ChapterType_Chapter) {
                    cell.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
                    cell.chapterName2.font = [UIFont fontWithName:BFfont size:15];
                }else if (node.chapterType == ChapterType_LittleChapter){
                    cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
                    cell.chapterName2.font = [UIFont fontWithName:BFfont size:14];
                }
            }
        }else if (node.chapterType == ChapterType_Course){
            cell.littleTitleLabel.text = node.cTitle;
            cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",node.cstarttime] dateFormat:@"MM月dd号 hh:mm"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",node.cendtime] dateFormat:@"hh:mm"]];
//            if (node.isSelect) {
//                cell.titleImgView.image = [UIImage imageNamed:@"直播"];
//            }else{
//                cell.titleImgView.image = [UIImage imageNamed:@"直播拷贝"];
//            }
            cell.titleImgView.image = [UIImage imageNamed:@"直播拷贝"];
        }
        return cell;
    }else if (indexPath.section == 4){// 评价
        [indexPathDic setValue:indexPath forKey:evaluateCellId];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lineViewCell forIndexPath:indexPath];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:lineViewCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RGBColor(240, 240, 240);
        return cell;
    }else {
        if (indexPath.row == 0) {
            BFEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFEvaluateCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
            }
            cell.courseEvaluateModel = _evaluateArray[indexPath.section - 5];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            return cell;
        }else{
            BFEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
            }
            BFCourseEvaluateModel *model = _evaluateArray[indexPath.section - 5];
            cell.courseEvaluateReplyModel = model.replys[indexPath.row - 1];
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (_topImage) {
                CGSize size = _topImage.size;
                CGFloat h = KScreenW / (size.width / size.height);
                return h;
            }else{
                return 1;
            }
        }else{
            return 120;
        }
    }else if (indexPath.section == 1){
        if (_teachersArray.count > 2) {
            if (self.isExpand == YES) {// 如果是展开的情况
                if (indexPath.row == 0) {
                    return 110;
                }else{
                    return TeacherCellHeight;
                }
            }else{
                return 130;
            }
        }else{
            if (indexPath.row == 0) {
                return 130;
            }else if (_teachersArray.count == 2 && indexPath.row > 0 && indexPath.row <= _teachersArray.count - 1) {// 两个主讲时候，第二个主讲显示的高度
                return TeacherCellHeight;
            }else{
                return 0;
            }
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0 || indexPath.row == 2) {
            return PXTOPT(16);
        }else{
            if (descriptionStr) {
                if ([[_cacheDict allKeys] containsObject:@"介绍"]) {
                    return [_cacheDict[@"介绍"] floatValue];
                }else{
                    CGSize size = [UILabel sizeWithString:descriptionStr font:[UIFont fontWithName:BFfont size:15] size:CGSizeMake(KScreenW - 20, 2000)];
                    CGFloat h = size.height + 50;
                    [_cacheDict setValue:@(h) forKey:@"介绍"];
                    return h;
                }
            }else{
                return 100;
            }
        }
        
    }else if(indexPath.section == 3){
        return 60;
    }else if(indexPath.section == 4){
        return PXTOPT(16);
    }else{
        BFCourseEvaluateModel *model = _evaluateArray[indexPath.section - 5];
        if (indexPath.row == 0) {
            return [self cacheCellHeightWithContent:model.ceeval withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:model.ceid isReply:NO];
        }else{
            BFCourseEvaluateReplyModel *replyModel = model.replys[indexPath.row - 1];
            return [self cacheCellHeightWithContent:replyModel.ceeval withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:replyModel.ceid isReply:YES];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        if (_teachersArray.count > 2) {
            BFCDTeacherRoleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    NSLog(@"点击一级cell");
                    if (!self.selectedIndexPath) {
                        self.isExpand = YES;
                        self.selectedIndexPath = indexPath;
                        NSArray *arr = [self indexPathsForExpandRow:indexPath.row];
                        [tableView beginUpdates];
                        [tableView insertRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationBottom)];
                        [tableView endUpdates];
                        [cell expansionCell];
                    }else{
                        if (self.isExpand) {
                            if (self.selectedIndexPath == indexPath) {
                                self.isExpand = NO;
                                
                                NSArray *arr = [self indexPathsForExpandRow:indexPath.row];
                                [tableView beginUpdates];
                                [tableView deleteRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationBottom)];
                                [tableView endUpdates];
                                self.selectedIndexPath = nil;
                            }
                            [cell closeCell];
                        }
                    }
                }else{
                    NSLog(@"点击二级cell");
                }
            }
        }
    }else if(indexPath.section == 2){
        
    }else if(indexPath.section == 3){
        //先修改数据源
        BFCatalogueModel *parentNode = [_tempData objectAtIndex:indexPath.row];
        if (parentNode.chapterType != ChapterType_Course) {
            NSUInteger startPosition = indexPath.row + 1;
            NSUInteger endPosition = startPosition;
            BOOL expand = NO;
            for (int i=0; i<_catalogueArray.count; i++) {
                BFCatalogueModel *node = [_catalogueArray objectAtIndex:i];
                if (node.parentId == parentNode.cTId) {
                    node.isShow = !node.isShow;
                    if (node.isShow) {
                        [_tempData insertObject:node atIndex:endPosition];
                        expand = YES;
                        endPosition++;
                    }else{
                        expand = NO;
                        endPosition = [self removeAllNodesAtParentNode:parentNode];
                        break;
                    }
                    
                }
            }
            parentNode.isExpand = expand;
            [tableView reloadData];
        }else{
//            [MobClick event:@"watchVideoCourse"];
            parentNode.isSelect = YES;
            [self watchVideoAction:parentNode.roomId];
        }
    }else{
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (NSArray *)indexPathsForExpandRow:(NSInteger)row {
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 1; i <= _teachersArray.count - 1; i++) {
        NSIndexPath *idxPth = [NSIndexPath indexPathForRow:row + i inSection:1];
        [indexPaths addObject:idxPth];
    }
    return [indexPaths copy];
}

- (CGFloat)cacheCellHeightWithContent:(NSString *)content withFont:(UIFont *)font withSize:(CGSize)size withId:(NSInteger)Id isReply:(BOOL)isReply{
    NSArray *keysArray;
    if (isReply) {
        keysArray = [_replyscacheDict allKeys];
    }else{
        keysArray = [_cacheDict allKeys];
    }
    NSString *key = [NSString stringWithFormat:@"%ld",Id];
    if ([keysArray containsObject:key]) {
        if (isReply) {
            return [_replyscacheDict[key] floatValue];
        }else{
            return [_cacheDict[key] floatValue];
        }
    }else{
        CGFloat h = isReply ? [UILabel sizeWithString:content font:font size:size].height + 10 : [UILabel sizeWithString:content font:font size:size].height + 100;
        if (isReply) {
            [_replyscacheDict setValue:@(h) forKey:key];
        }else{
            [_cacheDict setValue:@(h) forKey:key];
        }
        return h;
    }
}

/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (BFCatalogueModel *)parentNode{
    NSUInteger startPosition = [_tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempData.count; i++) {
        BFCatalogueModel *node = [_tempData objectAtIndex:i];
        endPosition++;
        if (node.chapterType <= parentNode.chapterType) {
            break;
        }
        if(endPosition == _tempData.count-1){
            endPosition++;
            node.isShow = NO;
            break;
        }
        node.isShow = NO;
    }
    if (endPosition>startPosition) {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
    
    
}

// 看视频
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (isDrag) {
        NSIndexPath *introduceCellIndexPath = indexPathDic[introduceCell];
        NSIndexPath *catalogueCellIndexPath = indexPathDic[catalogueCell];
        NSIndexPath *evaluateCellIndexPath  = indexPathDic[evaluateCellId];
        
        if ([[_bigTableView indexPathsForVisibleRows] containsObject:introduceCellIndexPath]) {
            [UIView animateWithDuration:0.25 animations:^{
                _slideViewBar.hidden = NO;
            }];
            
        }
        
        if (_bigTableView.contentOffset.y < 50) {
            [UIView animateWithDuration:0.25 animations:^{
                _slideViewBar.hidden = YES;
            }];
        }
        if (introduceCellIndexPath && [[_bigTableView indexPathsForVisibleRows] containsObject:introduceCellIndexPath] && [self calculateCellRectWith:introduceCellIndexPath] < 300) {
            _slideViewBar.currentIndex = 0;
        }
        if (catalogueCellIndexPath  && [[_bigTableView indexPathsForVisibleRows] containsObject:catalogueCellIndexPath] && [self calculateCellRectWith:catalogueCellIndexPath] < 300){
            _slideViewBar.currentIndex = 1;
        }
        if (evaluateCellIndexPath  && [[_bigTableView indexPathsForVisibleRows] containsObject:evaluateCellIndexPath] && [self calculateCellRectWith:evaluateCellIndexPath] < 300){
            _slideViewBar.currentIndex = 2;
        }
    }
}

- (CGFloat)calculateCellRectWith:(NSIndexPath *)indexPath{
    CGRect rectInTableView = [_bigTableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSuperview = [_bigTableView convertRect:rectInTableView toView:[_bigTableView superview]];
    return rectInSuperview.origin.y;
}

#pragma mark - BFSlideViewBarDelegate

- (NSInteger)numberOfSlideItemsInSlideView:(BFSlideViewBar *)slideView {
    
    return 3;
}

- (NSArray *)namesOfSlideItemsInSlideView:(BFSlideViewBar *)slideView {
    return @[@"介绍",@"目录",@"评价"];
}

- (void)slideView:(BFSlideViewBar *)slideView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@" index %li", index);
    isDrag = NO;
    NSIndexPath *indexPath;
    if (index == 0) {
        indexPath = indexPathDic[introduceCell];
    }else if (index == 1){
        indexPath = indexPathDic[catalogueCell];
    }else if (index == 2){
        indexPath = indexPathDic[evaluateCellId];
    }
    [_bigTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (UIColor *)colorOfSliderInSlideView:(BFSlideViewBar *)slideView{
    return RGBColor(0, 169, 255);
}

- (UIColor *)colorOfSlideView:(BFSlideViewBar *)slideView{
    return [UIColor whiteColor];
}

- (UIColor *)colorOfSlideItemsTitle:(BFSlideViewBar *)slideView{
    return [UIColor blackColor];
}

- (void)sendEditEvaluateWithContent:(NSString *)content{
    if ([_model isKindOfClass:[BFCourseModel class]]) {
        cid = ((BFCourseModel *)_model).cid;
    }else if ([_model isKindOfClass:[BFSetCourseModel class]]) {
        cid = ((BFSetCourseModel *)_model).csid;
    }
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    [paramet setValue:@([GetFromUserDefaults(@"uId") integerValue]) forKey:@"uid"];
    [paramet setValue:@(cid) forKey:@"ciid"];
    [paramet setValue:content forKey:@"ceeval"];
    [paramet setValue:@(cistate) forKey:@"cistate"];
    [NetworkRequest sendDataWithUrl:CourseEvaluateURL parameters:paramet successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            if (!_evaluateArray) {
                _evaluateArray = [NSMutableArray array];
            }
            [_evaluateArray removeAllObjects];
            NSArray *evaluateArray = dic[@"eavlList"];
            for (NSDictionary *dict in evaluateArray) {// 评论
                BFCourseEvaluateModel *evaluateModel = [BFCourseEvaluateModel initWithDict:dict];
                
                NSLog(@"%@",evaluateModel);
                
                [_evaluateArray addObject:evaluateModel];
            }
            if (_evaluateArray) {
                [_bigTableView reloadData];
            }
            [self showHUD:@"评论成功"];
        }else{
            [self showHUD:@"评论失败"];
        }
    } failure:^(NSError *error) {
        [self showHUD:@"评论失败"];
    }];
}

//分享
-(void)ShareAction {
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (UMSocialPlatformType_QQ == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到QQ好友
        }
        else if (UMSocialPlatformType_Qzone == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到QQ空间
        }
        else if (UMSocialPlatformType_Sina == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到新浪微博
        }
        else if (UMSocialPlatformType_WechatSession == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到微信好友
        }
        else if (UMSocialPlatformType_WechatTimeLine == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到微信朋友圈
        }
        else if (UMSocialPlatformType_WechatFavorite == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到微信收藏
        }
    }];
}

-(void)detailShareWithPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"[北方职教]%@",_model.ctitle] descr:_model.descriptionStr thumImage:_topImage];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"https://www.beifangzj.com/bfweb/curriculumDetail-h5.html?csId=%ld&cskey=1",_model.cid];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            [ZAlertView showSVProgressForSuccess:@"分享成功"];
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

// 评论
- (void)commentBtnAction{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        [self evaluateAction];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

// 评论
- (void)evaluateAction{
    if ([GetFromUserDefaults(@"loginStatus") isEqualToString:@"1"]) {
        if (gouke == 1) {
            BFEditEvaluateVC *vc = [BFEditEvaluateVC new];
            vc.modalPresentationStyle = 0;
            [self presentViewController:vc animated:YES completion:nil];
            __weak BFCourseDetailsVC *weakSelf = self;
            vc.editBlock = ^(NSString *content) {
                [weakSelf sendEditEvaluateWithContent:content];
            };
        }else{
            if (videoOrLive == 0) {// 直播
                [self showHUD:@"您还没有报名"];
            }else{
                [self showHUD:@"您还没有观看"];
            }
        }
    }else{
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

// 收藏
- (void)collectionAction:(UIButton *)btn{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        NSString *url = [NSString stringWithFormat:@"%@?uId=%@&cIid=%ld&collectedState=%ld&cistate=%ld",CourseCollectionURL,GetFromUserDefaults(@"uId"),cid,collectionStatic,cistate];
        NSLog(@"collectionStatic = %ld",collectionStatic);
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            NSInteger state = [dic[@"state"] integerValue];
            if (state == 1) {
                if (collectionStatic == 1) {
                    collectionStatic = 0;
                }else{
                    collectionStatic = 1;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setImage:collectionStatic > 0 ? [UIImage imageNamed:@"收藏成功"] : [UIImage imageNamed:@"收藏"]  forState:(UIControlStateNormal)];
                });
            }
        } failureResponse:^(NSError *error) {
            
        }];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"拖拽");
    isDrag = YES;
}

- (void)setModel:(BFCourseModel *)model{
    _model = model;
    if (_model.coverImg) {
        NSLog(@"model.coverImg为:%@",_model.coverImg);
        _topImage = _model.coverImg;
    }else if (_model.cscover) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_model.cscover]];
            self.topImage = [UIImage imageWithData:data];
        });
    }
}

- (void)setTopImage:(UIImage *)topImage{
    _topImage = topImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_bigTableView reloadData];
    });
}

#pragma mark -搜修车配合接口-
- (void)sxcNetwork{
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?cSId=%ld",SXCCourse,_model.cid];
    }
    else {
        url = [NSString stringWithFormat:@"%@?cSId=%ld",SXCCourse,_model.cid];
    }
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dict = data;
        NSInteger status = [dict[@"status"] integerValue];
        if (status == 1) {
            [_model fillWithDict:dict[@"data"]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_model.cscover]];
                self.topImage = [UIImage imageWithData:data];
            });
            [self prepareData];
        }else{
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_bigTableView reloadData];
        });
    } failureResponse:^(NSError *error) {
        
    }];
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
