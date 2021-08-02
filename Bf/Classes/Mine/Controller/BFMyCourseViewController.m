//
//  BFMyCourseViewController.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMyCourseViewController.h"
#import "BFCourseDetailsHadApplyVC.h"
#import "LiveShowViewController.h"
#import "BFMyCoursesCell.h"
#import "BFMyCourseModel.h"
#import "BFClassListCell.h"

@interface BFMyCourseViewController ()<CCPushUtilDelegate,UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic , strong) UITableView *tableView;
// 数据
@property (nonatomic , strong) NSMutableArray *courseListArray;
//
@property (nonatomic, assign) Boolean                   IsHorizontal;
// 分辨率
@property (nonatomic, assign) CGSize                    size;
// 码率
@property (nonatomic, assign) NSInteger                 bitRate;
// 帧率
@property (nonatomic, assign) NSInteger                 frameRate;
//
@property(nonatomic, strong) LiveShowViewController     *LiveShowViewController;
@end

static NSString *const myCoursesCell = @"myCoursesCell";
@implementation BFMyCourseViewController{
    NSString *roomId;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"我的课程页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"我的课程页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"我的课程";
    [self setUpTableViewInterface];
    _IsHorizontal = NO;
    _size = CGSizeMake(540, 960);
    _frameRate = 20;
    _bitRate = 100.0;
//    SaveToUserDefaults(@"stuOrTeac",@"teac");
//    if ([GetFromUserDefaults(@"stuOrTeac") isEqualToString:@"teac"]) {// 老师
//        if (!_courseListArray) {
//            _courseListArray = [NSMutableArray array];
//        }
//        BFMyCourseModel *model = [[BFMyCourseModel alloc] init];
//        model.roomId = @"39AFEDAA21913E3B9C33DC5901307461";
//        model.cEndTime = 1111;
//        model.cStartTime = 1111;
//        model.cTitle = @"第一个测试云课堂";
//        model.csKey = 0;
//
//        BFMyCourseModel *model1 = [[BFMyCourseModel alloc] init];
//        model1.roomId = @"F0B4DF82BB17AF1D9C33DC5901307461";
//        model1.cEndTime = 1111;
//        model1.cStartTime = 1111;
//        model1.cTitle = @"最新的测试直播间";
//        model1.csKey = 0;
//        [_courseListArray addObject:model];
//        [_courseListArray addObject:model1];
//    }else{// 学生
//
//    }
    [self netWork];
}

#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    [_tableView registerClass:[BFClassListCell class] forCellReuseIdentifier:myCoursesCell];
    [self.view addSubview:_tableView];
    _tableView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (_courseListArray.count > 0) {
//        return _courseListArray.count;
//    }else{
//        return 10;
//    }
    return _courseListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_courseListArray.count > 0) {
        BFClassListCell *cell = [tableView dequeueReusableCellWithIdentifier:myCoursesCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFClassListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:myCoursesCell];
        }
        cell.backgroundColor = GroundGraryColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myCourseModel = _courseListArray[indexPath.row];
        return cell;
    }else{
        BFClassListCell *cell = [tableView dequeueReusableCellWithIdentifier:myCoursesCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFClassListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:myCoursesCell];
        }
        cell.backgroundColor = GroundGraryColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 94.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    if (KIsiPhoneX) {
        headerView.frame = CGRectMake(0, 44, KScreenW, 30);
    }else {
        headerView.frame = CGRectMake(0, 0, KScreenW, 30);
    }
    
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMyCourseModel *myCourseModel = _courseListArray[indexPath.row];
//    NSNumber *isTeacher = GetFromUserDefaults(@"uStateBf");
//    if ([isTeacher integerValue] == 1) {// 老师
//        PushParameters *parameters = [[PushParameters alloc] init];
//        parameters.userId = DWACCOUNT_USERID;
//        parameters.roomId = myCourseModel.roomId;
//        parameters.viewerName = GetFromUserDefaults(@"uid");
//        parameters.token = @"1";
//        parameters.security = NO;
//        [[CCPushUtil sharedInstanceWithDelegate:self] loginWithParameters:parameters];
//        roomId = myCourseModel.roomId;
//    }else{// 学生
//        if (myCourseModel.csKey == 0 && myCourseModel.isLoseEfficacy) {// 直播课过期不可点击
//
//        }else{
//            BFCourseDetailsHadApplyVC *vc = [BFCourseDetailsHadApplyVC new];
//            vc.myCourseModel = myCourseModel;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
    if (myCourseModel.csKey == 0 && myCourseModel.isLoseEfficacy) {// 直播课过期不可点击
        
    }else{
        BFCourseDetailsHadApplyVC *vc = [BFCourseDetailsHadApplyVC new];
        vc.myCourseModel = myCourseModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (void)netWork{
    NSString *url = [NSString stringWithFormat:@"%@?uId=%@",MyCoursesURL,GetFromUserDefaults(@"uId")];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            if (!_courseListArray) {
                _courseListArray = [NSMutableArray array];
            }
            [_courseListArray removeAllObjects];
            NSArray *arr = dic[@"data"];
            for (int i = 0; i < arr.count; i++) {
                BFMyCourseModel *model = [BFMyCourseModel initWithDict:arr[i]];
                [_courseListArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

//@optional
/**
 *    @brief    请求成功
 */
-(void)requestLoginSucceedWithViewerId:(NSString *)viewerId {
    NSLog(@"登录成功 viewerId = %@",viewerId);
    [self OnStartLive];
}

-(void)OnStartLive{
    _LiveShowViewController = nil;
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    _LiveShowViewController.roomId = roomId;
    _LiveShowViewController.IsHorizontal = _IsHorizontal;
    
    float width = _size.width;
    float height = _size.height;
    if (_IsHorizontal) {
        _size.width = MAX(width, height);
        _size.height = MIN(width, height);
    } else {
        _size.width = MIN(width, height);
        _size.height = MAX(width, height);
    }
    [[CCPushUtil sharedInstanceWithDelegate:self] setVideoSize:_size BitRate:(int)_bitRate FrameRate:(int)_frameRate];
    _LiveShowViewController.modalPresentationStyle = 0;
    [self presentViewController:_LiveShowViewController animated:YES completion:nil];
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
    //    _innerView.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[@"原因：" stringByAppendingString:message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
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
