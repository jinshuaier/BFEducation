//
//  BFResumeManagementViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFResumeManagementViewController.h"
#import "BFRMPersonalInformationCell.h"
#import "BFExperienceListCell.h"
#import "BFIntroduceCell.h"
#import "BFPreviewResumeController.h"//简历预览
#import "BFPersonalBasicResumeController.h"//基础简历
#import "BFResumeAccessoryController.h"//上传附件简历
#import "BFResumeAccessorySecondViewController.h"//重新上传附件简历
#import "BFDetailExperienceController.h"
#import "BFSeniorResumeController.h"//工作/教育经历页面
#import "BFWatchResumeController.h"//建立附件预览
@interface BFResumeManagementViewController ()<UITableViewDelegate,UITableViewDataSource,menuViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
/*右侧按钮*/
@property (nonatomic,strong) UIButton *rightBtn;
/*文字数组*/
@property (nonatomic,strong) NSArray *titleArr;
/** 图片数组 */
@property (nonatomic,strong) NSArray *imgArr;
@property (nonatomic,strong) UIView *btnView1;
@property (nonatomic,strong) UIView *btnView2;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic , strong) NSMutableDictionary *jobsDict;

@property (nonatomic,copy) NSString *hopeWorkStr;
@end

@implementation BFResumeManagementViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPersonalInformation];
    [self networkJobStyle];
}

#pragma mark - 获取个人数据

-(void)getPersonalInformation {
    NSString *uid = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
    NSString *urlS = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeSelect.do?uId=%@",ServerURL,uid];
    
    [NetworkRequest requestWithUrl:urlS parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            NSDictionary *dicc = dic[@"data"];
            NSMutableArray *arrWork = dicc[@"jobExperiences"];
            NSMutableArray *arrEdu = dicc[@"jobLearns"];
            self.dic = dicc;
            self.workArr = arrWork;
            self.eduArr = arrEdu;
            [self.tableView reloadData];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(void)networkJobStyle{
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobTypeSelectList.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSArray *array = data;
        for (NSDictionary *dic in array) {
            [_jobsDict setValue:dic[@"jttitle"] forKey:dic[@"jtid"]];
        }
        NSLog(@"%@",_jobsDict);
        NSArray *arr = [_jobsDict allKeys];
        NSLog(@"用户期望职位为%@",arr);
        NSString *jobIdStr = [NSString stringWithFormat:@"%@",self.dic[@"jRJob"]];
        [_jobsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([[key stringValue] isEqualToString:jobIdStr]) {
                NSLog(@"当前的值为%@",obj);
                self.hopeWorkStr = [NSString stringWithFormat:@"%@",obj];
                [self.tableView reloadData];
            }
        }];
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简历管理";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"接收到的字典数据为:%@",self.dic);
    [self setUpTableViewInterface];

    //设置切换按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightBtn;
    [rightBtn setTitle:@"更多" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[item1];
    
    self.titleArr = @[@"预览简历",@"上传附件简历",@"删除附件简历"];
    self.imgArr = @[@"本科",@"车人才-1",@"本科"];
    
    UIView *btnView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 65)];
    btnView1.backgroundColor = [UIColor whiteColor];
    self.btnView1 = btnView1;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1 = btn1;
    btn1.frame = CGRectMake((KScreenW - 130)/2, 15, 130, 35);
    [btn1 setTitle:@"+添加工作经历" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGBColor(0, 140, 244) forState:UIControlStateNormal];
    btn1.layer.borderColor = RGBColor(0, 140, 244).CGColor;
    btn1.layer.borderWidth = 1.0f;
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    btn1.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    btn1.layer.cornerRadius = 35/2.0f;
    [btn1 addTarget:self action:@selector(clickAddWorkAction1) forControlEvents:UIControlEventTouchUpInside];
    [btnView1 addSubview:btn1];
    
    
    
    UIView *btnView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 65)];
    self.btnView2 = btnView2;
    btnView2.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2 = btn2;
    btn2.frame = CGRectMake((KScreenW - 130)/2, 15, 130, 35);
    [btn2 setTitle:@"+添加教育经历" forState:UIControlStateNormal];
    [btn2 setTitleColor:RGBColor(0, 140, 244) forState:UIControlStateNormal];
    btn2.layer.borderColor = RGBColor(0, 140, 244).CGColor;
    btn2.layer.borderWidth = 1.0f;
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    btn2.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    btn2.layer.cornerRadius = 35/2.0f;
    [btn2 addTarget:self action:@selector(clickAddEducationAction1) forControlEvents:UIControlEventTouchUpInside];
    [btnView2 addSubview:btn2];
    
    if (!_jobsDict) {
        _jobsDict = [NSMutableDictionary dictionary];
    }
    
}

-(void)didSelectRowAtIndex:(NSInteger)index title:(NSString *)title img:(NSString *)img{
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, img);
    if (index == 0) {
        //预览基础简历
        BFPreviewResumeController *previewVC = [[BFPreviewResumeController alloc] init];
        previewVC.dic = self.dic;
        previewVC.workArr = self.workArr;
        previewVC.eduArr = self.eduArr;
        previewVC.hopeStr = self.hopeWorkStr;
        [self.navigationController pushViewController:previewVC animated:YES];
    }
    else if (index == 1) {
        //上传附件简历
        if (self.dic[@"jRReUrl"] == nil) {
            //无简历附件 上传简历附件
            BFResumeAccessoryController *resumeVC = [[BFResumeAccessoryController alloc] init];
            [self.navigationController pushViewController:resumeVC animated:YES];
        }
        else {
            //重新上传简历附件
            BFResumeAccessorySecondViewController *resumeVC = [[BFResumeAccessorySecondViewController alloc] init];
            resumeVC.resumeName = [NSString stringWithFormat:@"%@",self.dic[@"jRReUrlName"]];
            resumeVC.resumeTime = [NSString stringWithFormat:@"%@",self.dic[@"jRTimeStr"]];
            [self.navigationController pushViewController:resumeVC animated:YES];
        }
    }
    else if (index == 2) {
        //删除附件简历
        NSString *uidStr = GetFromUserDefaults(@"uId");
        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeJRreUrlDelete.do?uId=%@",ServerURL,uidStr];
        [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"删除附件简历成功"];
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"删除附件简历失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"删除附件简历失败"];
        }];
    }
}

-(void)navRightClick{
    BFMenuView *menuView = [[BFMenuView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, 50, 120, 123) titleArr:self.titleArr imgArr:self.imgArr arrowOffset:104 rowHeight:40 layoutType:1 directionType:0 delegate:self];
    menuView.lineColor = LineColor;
    menuView.titleColor = [UIColor blackColor];
    menuView.arrowColor = [UIColor whiteColor];
}

#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[BFRMPersonalInformationCell class] forCellReuseIdentifier:@"personalCell"];
//    [_tableView registerClass:[BFExperienceListCell class] forCellReuseIdentifier:@"exCell"];
//    [_tableView registerClass:[BFExperienceListCell class] forCellReuseIdentifier:@"exCell1"];
    [_tableView registerClass:[BFIntroduceCell class] forCellReuseIdentifier:@"introCell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return self.eduArr.count + 1;
    }
    else if (section == 2) {
        return self.workArr.count + 1;
    }
    else if (section == 3) {
        return 1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        BFRMPersonalInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell" forIndexPath:indexPath];
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"jRPhoto"]]]];
        cell.realName.text = [NSString stringWithFormat:@"%@",self.dic[@"jRName"]];
        //性别
        NSString *sexStr = [NSString stringWithFormat:@"%@",self.dic[@"jRSex"]];
        if ([sexStr isEqualToString:@"0"]) {
            cell.sex1.text = @"男";
        }
        else if ([sexStr isEqualToString:@"1"]) {
            cell.sex1.text = @"女";
        }
        cell.birth1.text = [NSString stringWithFormat:@"%@",self.dic[@"jRBirthdayStr"]];
        //学历
        NSString *str1 = [NSString stringWithFormat:@"%@",self.dic[@"jRDiploma"]];
        NSString *str11 = @"0";
        if ([str1 isEqualToString:@"0"]) {
            str11 = @" 不限";
        }
        else if ([str1 isEqualToString:@"1"]) {
            str11 = @" 中专以下";
        }
        else if ([str1 isEqualToString:@"2"]) {
            str11 = @" 高中";
        }
        else if ([str1 isEqualToString:@"3"]) {
            str11 = @" 大专";
        }
        else if ([str1 isEqualToString:@"4"]) {
            str11 = @" 本科";
        }
        cell.degree1.text = str11;
        //工作时间
        NSString *str0 = [NSString stringWithFormat:@"%@",self.dic[@"jRYear"]];
        NSString *str00 = @"0";
        if ([str0 isEqualToString:@"0"]) {
            str00 = @" 应届生";
        }
        else if ([str0 isEqualToString:@"1"]) {
            str00 = @" 1-3年";
        }
        else if ([str0 isEqualToString:@"2"]) {
            str00 = @" 3-5年";
        }
        else if ([str0 isEqualToString:@"3"]) {
            str00 = @" 5-10年";
        }
        else if ([str0 isEqualToString:@"4"]) {
            str00 = @" 10年以上";
        }
        cell.workYear1.text = str00;
        //期望职位
        cell.job1.text = self.hopeWorkStr;
        //期望薪资
        NSString *str2 = [NSString stringWithFormat:@"%@",self.dic[@"jRMoney"]];
        NSString *str22 = @"0";
        if ([str2 isEqualToString:@"0"]) {
            str22 = @"面议";
        }
        else if ([str2 isEqualToString:@"1"]) {
            str22 = @"3000元以下";
        }
        else if ([str2 isEqualToString:@"2"]) {
            str22 = @"3000-5000";
        }
        else if ([str2 isEqualToString:@"3"]) {
            str22 = @"5000-7000";
        }
        else if ([str2 isEqualToString:@"4"]) {
            str22 = @"7000-10000";
        }
        else if ([str2 isEqualToString:@"5"]) {
            str22 = @"10000-15000";
        }
        else if ([str2 isEqualToString:@"6"]) {
            str22 = @"15000以上";
        }
        cell.money1.text = str22;
        
        cell.location1.text = [NSString stringWithFormat:@"%@",self.dic[@"bRName"]];
        cell.phone1.text = [NSString stringWithFormat:@"%@",self.dic[@"jRPhone"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 1) {
        BFExperienceListCell *cell = [BFExperienceListCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == self.eduArr.count) {
            [cell addSubview:self.btnView2];
            voidCell = cell;
        }
        else {
            NSDictionary *eduDic = self.eduArr[indexPath.row];
            NSString *startTime = [NSString stringWithFormat:@"%@",eduDic[@"jLStartTimeStr"]];
            NSString *endTime = [NSString stringWithFormat:@"%@",eduDic[@"jLEndTimeStr"]];
            cell.experienceTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
            cell.company.text = [NSString stringWithFormat:@"%@",eduDic[@"jLSchool"]];
            cell.position.text = [NSString stringWithFormat:@"%@",eduDic[@"jLLearn"]];
            cell.pushEditBlock = ^(){
                NSDictionary *eduDic = self.eduArr[indexPath.row];
                BFEducationExModel *model = [[BFEducationExModel alloc] init];
                model.jLSchool = eduDic[@"jLSchool"];
                model.jLLearn = eduDic[@"jLLearn"];
                model.jLStartTimeStr = eduDic[@"jLStartTimeStr"];
                model.jLEndTimeStr = eduDic[@"jLEndTimeStr"];
                model.jLId = eduDic[@"jLId"];
                BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
                detailVC.exStyle = @"1";
                detailVC.exTitle = @"教育经历";
                detailVC.model11 = model;
                detailVC.edit = @"1";
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            voidCell = cell;
        }
        
    }
    else if (indexPath.section == 2) {
        BFExperienceListCell *cell = [BFExperienceListCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == self.workArr.count) {
            [cell addSubview:self.btnView1];
            voidCell = cell;
        }
        else {
            if (indexPath.row == self.workArr.count) {
                cell.isLastData = @"1";
            }
            NSDictionary *workDic = self.workArr[indexPath.row];
            NSString *startTime = [NSString stringWithFormat:@"%@",workDic[@"jEStartTimeStr"]];
            NSString *endTime = [NSString stringWithFormat:@"%@",workDic[@"jEEndTimeStr"]];
            cell.experienceTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
            cell.company.text = [NSString stringWithFormat:@"%@",workDic[@"jECompany"]];
            cell.position.text = [NSString stringWithFormat:@"%@",workDic[@"jEJob"]];
            cell.experienceContent.text = [NSString stringWithFormat:@"%@",workDic[@"jEContent"]];
            cell.pushEditBlock = ^(){
                NSDictionary *workDic = self.workArr[indexPath.row];
                BFWorkExModel *model = [[BFWorkExModel alloc] init];
                model.jECompany = workDic[@"jECompany"];
                model.jEJob = workDic[@"jEJob"];
                model.jEStartTimeStr = workDic[@"jEStartTimeStr"];
                model.jEEndTimeStr = workDic[@"jEEndTimeStr"];
                model.jEContent = workDic[@"jEContent"];
                model.jEId = workDic[@"jEId"];
                BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
                detailVC.exStyle = @"0";
                detailVC.exTitle = @"工作经历";
                detailVC.model00 = model;
                detailVC.edit = @"1";
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            voidCell = cell;
        }
    }
    else if (indexPath.section == 3) {
        BFIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.introText.text = self.dic[@"jIntroduction"];
        voidCell = cell;
    }
    return voidCell;
}

//指定行是否可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    else if (indexPath.section == 1) {
        return YES;
    }
    else if (indexPath.section == 2) {
        return YES;
    }
    else if (indexPath.section == 3) {
        return NO;
    }
    return NO;
}

/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        NSDictionary *dic = self.workArr[indexPath.row];
//        //删除的是工作经历
//        [self.workArr removeObjectAtIndex:indexPath.row];
        NSString *url0 = [NSString stringWithFormat:@"%@bfJobController/bfJobExperienceDelete.do?jEId=%@",ServerURL,dic[@"jEId"]];
        [NetworkRequest requestWithUrl:url0 parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"删除成功"];
                // 刷新
                [self getPersonalInformation];
            }
            else {
                [ZAlertView showSVProgressForSuccess:@"删除失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForSuccess:@"删除失败"];
        }];
        
    }
    else if (indexPath.section == 1) {
        NSDictionary *dic = self.eduArr[indexPath.row];
        NSString *url1 = [NSString stringWithFormat:@"%@bfJobController/bfJobLearnDelete.do?jLId=%@",ServerURL,dic[@"jLId"]];
        [NetworkRequest requestWithUrl:url1 parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"删除成功"];
                // 刷新
                [self getPersonalInformation];
            }
            else {
                [ZAlertView showSVProgressForSuccess:@"删除失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForSuccess:@"删除失败"];
        }];
        NSLog(@"教育经历的数据为%@",self.eduArr);
        //删除的是教育经历
//        [self.eduArr removeObjectAtIndex:indexPath.row];
    }
    
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 添加工作经历的点击事件

-(void)clickAddWorkAction1 {
    BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
    detailVC.exStyle = @"0";
    detailVC.exTitle = @"工作经历";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 添加教育经历的点击事件

-(void)clickAddEducationAction1 {
    BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
    detailVC.exStyle = @"1";
    detailVC.exTitle = @"教育经历";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 390.0f;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == self.eduArr.count) {
            return 65.0f;
        }
        else {
            return 105.0f;
        }
        return 105.0f;
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == self.workArr.count) {
            return 65.0f;
        }
        else {
            NSDictionary *workDic = self.workArr[indexPath.row];
            NSString *str = [NSString stringWithFormat:@"%@",workDic[@"jEContent"]];
            CGSize size = [UILabel sizeWithString:str font:[UIFont fontWithName:BFfont size:14] size:CGSizeMake(KScreenW - 52, 2000)];
            CGFloat h = size.height + 105;
            return h;
        }
    }
    else if (indexPath.section == 3) {
        NSString *str = [NSString stringWithFormat:@"%@",self.dic[@"jIntroduction"]];
        CGSize size = [UILabel sizeWithString:str font:[UIFont fontWithName:BFfont size:14] size:CGSizeMake(KScreenW - 52, 2000)];
        CGFloat h = size.height + 65;
        return h;
    }
    return 410.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 10)];
    spaceView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:spaceView];
    UILabel * sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 12.5, KScreenW / 2, 20)];
    sectionLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    sectionLabel.textAlignment = NSTextAlignmentLeft;
    sectionLabel.textColor = RGBColor(51, 51, 51);
    
    if (section == 0) {
        sectionLabel.text = @"个人资料";
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编辑"]];
        img.frame = CGRectMake(KScreenW - 16 - 20, 12.5, 20, 20);
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEditInformation)];
        [img addGestureRecognizer:ges];
        [headerView addSubview:img];
    }
    else if (section == 1) {
        sectionLabel.text = @"教育经历";
    }
    else if (section == 2) {
        sectionLabel.text = @"工作经历";
    }
    else if (section == 3) {
        sectionLabel.text = @"自我介绍";
    }
    [headerView addSubview:sectionLabel];
    return headerView;
}

-(void)clickEditInformation {
    BFPersonalBasicResumeController *basicVC = [[BFPersonalBasicResumeController alloc] init];
    basicVC.editResume = @"1";
    basicVC.dic = self.dic;
    basicVC.hopeStr = self.hopeWorkStr;
    [self.navigationController pushViewController:basicVC animated:YES];
}

-(void)clickEditInformation1 {
    //跳转到
    BFSeniorResumeController *resumeVC = [[BFSeniorResumeController alloc] init];
    resumeVC.isFromResumeManager = @"0";
    [self.navigationController pushViewController:resumeVC animated:YES];
}

-(NSMutableArray *)workArr {
    if (!_workArr) {
        _workArr = [NSMutableArray array];
    }
    return _workArr;
}

-(NSMutableArray *)eduArr {
    if (!_eduArr) {
        _eduArr = [NSMutableArray array];
    }
    return _eduArr;
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc] init];
    }
    return _titleArr;
}

-(NSArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [[NSArray alloc] init];
    }
    return _imgArr;
}
@end
