//
//  BFPreviewResumeController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/27.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFPreviewResumeController.h"
#import "BFWatchResumeController.h"//预览附件简历页面
#import "BFPreviewTopCell.h"//顶部cell
#import "BFPreviewBasicInformationCell.h"//基本信息cell
#import "BFPreviewWorkDirectionCell.h"//求职意向cell
#import "BFExperienceListCell.h"//工作经历cell
#import "BFIntroduceCell.h"//自我介绍cell
@interface BFPreviewResumeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
/*backView*/
@property (nonatomic,strong) UIView *backView;
@property (nonatomic , strong) NSMutableDictionary *jobsDict;
@property (nonatomic,copy) NSString *hopeWorkStr;
@end

@implementation BFPreviewResumeController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self networkJobStyle];
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

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBackView];
    if (!_jobsDict) {
        _jobsDict = [NSMutableDictionary dictionary];
    }
}

#pragma mark - 创建背景图片
-(void)createBackView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -80, KScreenW, KScreenH + 80) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[BFPreviewTopCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[BFPreviewBasicInformationCell class] forCellReuseIdentifier:@"cell0"];//基本信息cell
    [self.tableView registerClass:[BFPreviewWorkDirectionCell class] forCellReuseIdentifier:@"cell1"];//求职意向cell
//    [self.tableView registerClass:[BFExperienceListCell class] forCellReuseIdentifier:@"cell2"];//工作经历cell
    [self.tableView registerClass:[BFIntroduceCell class] forCellReuseIdentifier:@"cell3"];//自我介绍cell
    [self.view addSubview:self.tableView];
}

-(void)clickTapAction {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = self.dic[@"jRReUrl"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1;
    }
    else if (section == 2) {
        return 1;
    }
    else if (section == 3) {
        return self.eduArr.count;
    }
    else if (section == 4) {
        return self.workArr.count;
    }
    else if (section == 5) {
        return 1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (indexPath.section == 0) {
        BFPreviewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.pushResumeBlock = ^{
            [self clickTapAction];
        };
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"jRPhoto"]]]];
        NSString *realname = [NSString stringWithFormat:@"%@",self.dic[@"jRName"]];
        NSString *sexStr = [NSString stringWithFormat:@"%@",self.dic[@"jRSex"]];
        if ([sexStr isEqualToString:@"0"]) {
            cell.nickName.text = [NSString stringWithFormat:@"%@ - 男",realname];
        }
        else if ([sexStr isEqualToString:@"1"]) {
            cell.nickName.text = [NSString stringWithFormat:@"%@ - 女",realname];
        }
        NSString *textStr = [NSString stringWithFormat:@"%@",self.dic[@"jRReUrlName"]];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        NSString *urlName = [NSString stringWithFormat:@"%@",self.dic[@"jRReUrlName"]];
        if ([urlName isEqualToString:@"(null)"] || urlName == nil) {
            cell.exResume.text = @"";
            cell.exResume.userInteractionEnabled = NO;
        }
        else {
            cell.exResume.attributedText = attribtStr;
            cell.exResume.userInteractionEnabled = YES;
        }
        voidCell = cell;
    }
    
    else if (indexPath.section == 1) {//基本信息
        BFPreviewBasicInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
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
        cell.work1.text = str00;
        cell.phone1.text = [NSString stringWithFormat:@"%@",self.dic[@"jRPhone"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 2) {
        BFPreviewWorkDirectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (self.hopeStr == nil) {
            cell.degree1.text = self.hopeWorkStr;
        }
        else {
            cell.degree1.text = self.hopeStr;
        }
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
        cell.work1.text = str22;
        cell.birth1.text = [NSString stringWithFormat:@"%@",self.dic[@"bRName"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 3) {
        BFExperienceListCell *cell = [BFExperienceListCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isShow = @"0";
        if (self.eduArr.count == 0) {
            
        }
        else {
            NSDictionary *eduDic = self.eduArr[indexPath.row];
            NSString *startTime = [NSString stringWithFormat:@"%@",eduDic[@"jLStartTimeStr"]];
            NSString *endTime = [NSString stringWithFormat:@"%@",eduDic[@"jLEndTimeStr"]];
            cell.experienceTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
            cell.company.text = [NSString stringWithFormat:@"%@",eduDic[@"jLSchool"]];
            cell.position.text = [NSString stringWithFormat:@"%@",eduDic[@"jLLearn"]];
        }
        voidCell = cell;
    }
    else if (indexPath.section == 4) {
        BFExperienceListCell *cell = [BFExperienceListCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isShow = @"0";
        if (self.workArr.count == 0) {
            
        }
        else {
            NSDictionary *workDic = self.workArr[indexPath.row];
            NSString *startTime = [NSString stringWithFormat:@"%@",workDic[@"jEStartTimeStr"]];
            NSString *endTime = [NSString stringWithFormat:@"%@",workDic[@"jEEndTimeStr"]];
            cell.experienceTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
            cell.company.text = [NSString stringWithFormat:@"%@",workDic[@"jECompany"]];
            cell.position.text = [NSString stringWithFormat:@"%@",workDic[@"jEJob"]];
            cell.experienceContent.text = [NSString stringWithFormat:@"%@",workDic[@"jEContent"]];
        }
        voidCell = cell;
    }
    else if (indexPath.section == 5) {
        BFIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.introText.text = self.dic[@"jIntroduction"];
        voidCell = cell;
    }
    return voidCell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }else
         return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 270.0f;
    }
    else if (indexPath.section == 1) {
        return 150.0f;
    }
    else if (indexPath.section == 2) {
        return 115.0f;
    }
    else if (indexPath.section == 3) {
        return 105.0f;
    }
    else if (indexPath.section == 4) {
        NSDictionary *workDic = self.workArr[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@",workDic[@"jEContent"]];
        CGSize size = [UILabel sizeWithString:str font:[UIFont fontWithName:BFfont size:14] size:CGSizeMake(KScreenW - 52, 2000)];
        CGFloat h = size.height + 105;
        return h;
    }
    else if (indexPath.section == 5) {
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
    if (section == 1) {
        sectionLabel.text = @"基本信息";
    }
    else if (section == 2) {
        sectionLabel.text = @"求职意向";
    }
    else if (section == 3) {
        sectionLabel.text = @"教育经历";
    }
    else if (section == 4) {
        sectionLabel.text = @"工作经历";
    }
    else if (section == 5) {
        sectionLabel.text = @"自我介绍";
    }
    [headerView addSubview:sectionLabel];
    
    return headerView;
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


@end
