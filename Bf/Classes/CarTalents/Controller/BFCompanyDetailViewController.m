//
//  BFCompanyDetailViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/9.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCompanyDetailViewController.h"
#import "BFdetailTopCell.h"//职位标签cell
#import "BFCompanyWorkDetailCell.h"//职位描述cell
#import "BFWorkLocationCell.h"//工作地点cell
#import "BFJobPostCell.h"//职位发布者cell
#import "BFCompanyListCell.h"//相似职位cell
#import "BFSureCell.h"//发布职位cell
#import "BFCarTalentsListModel.h"//模型
@interface BFCompanyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray <BFCarTalentsListModel *>*carTalentArray;
@end

@implementation BFCompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位详情";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"传入的字典为:%@",self.dic);
    [self networkRequset];
    [self setUpTableViewInterface];
}

#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[BFdetailTopCell class] forCellReuseIdentifier:@"topCell"];
    [_tableView registerClass:[BFCompanyWorkDetailCell class] forCellReuseIdentifier:@"detailCell"];
    [_tableView registerClass:[BFWorkLocationCell class] forCellReuseIdentifier:@"locationCell"];
    [_tableView registerClass:[BFJobPostCell class] forCellReuseIdentifier:@"postCell"];
    [_tableView registerClass:[BFCompanyListCell class] forCellReuseIdentifier:@"listCell"];
    [_tableView registerClass:[BFSureCell class] forCellReuseIdentifier:@"sureCell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return _carTalentArray.count;
    }else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    
    NSLog(@"传入的字典为:%@",self.dic);
    
    if (indexPath.section == 0) {
        BFdetailTopCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"topCell" forIndexPath:indexPath];
        cell.companyJob.text = [NSString stringWithFormat:@"%@",self.dic[@"jWName"]];
        
        NSString *str0 = [NSString stringWithFormat:@"%@",self.dic[@"jWYear"]];
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
        
        NSString *str1 = [NSString stringWithFormat:@"%@",self.dic[@"jWDiploma"]];
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
        
        NSString *str2 = [NSString stringWithFormat:@"%@",self.dic[@"jWMoney"]];
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
        
        NSString *str3 = [NSString stringWithFormat:@"%@",self.dic[@"jCSize"]];
        NSString *str33 = @"0";
        if ([str3 isEqualToString:@"0"]) {
            str33 = @"少于15人";
        }
        else if ([str3 isEqualToString:@"1"]) {
            str33 = @"15-50人";
        }
        else if ([str3 isEqualToString:@"2"]) {
            str33 = @"50-150人";
        }
        else if ([str3 isEqualToString:@"3"]) {
            str33 = @"150-500人";
        }
        else if ([str3 isEqualToString:@"4"]) {
            str33 = @"500-1000人";
        }
        else if ([str3 isEqualToString:@"5"]) {
            str33 = @"1000人以上";
        }
        
        NSString *str4 = [NSString stringWithFormat:@"%@",self.dic[@"jCType"]];
        NSString *str44 = @"0";
        if ([str4 isEqualToString:@"0"]) {
            str44 = @"民营";
        }
        else if ([str4 isEqualToString:@"1"]) {
            str44 = @"国有";
        }
        else if ([str4 isEqualToString:@"2"]) {
            str44 = @"外商独资/办事处";
        }
        else if ([str4 isEqualToString:@"3"]) {
            str44 = @"中外合资/合作";
        }
        else if ([str4 isEqualToString:@"4"]) {
            str44 = @"事业单位";
        }
        
        cell.companyMoney.text = str22;
        [cell.companyLocation setTitle:[NSString stringWithFormat:@" %@",self.dic[@"bRName"]] forState:UIControlStateNormal];
        [cell.companyYear setTitle:str00 forState:UIControlStateNormal];
        [cell.companyDegree setTitle:str11 forState:UIControlStateNormal];
        [cell.companyLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"jCLogo"]]]];
        cell.companyName.text = [NSString stringWithFormat:@"%@",self.dic[@"jCName"]];
        cell.companyType.text = str44;
        cell.companyPeople.text = str33;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 1) {
        BFCompanyWorkDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
        cell.detailLbl.text = [NSString stringWithFormat:@"%@",self.dic[@"jWNote"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 2) {
        BFWorkLocationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
        cell.detailLbl.text = [NSString stringWithFormat:@"%@",self.dic[@"jCAddress"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 3) {
        BFJobPostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
        cell.postPeopleName.text = [NSString stringWithFormat:@"%@",self.dic[@"iNickName"]];
        [cell.postPeopleImg sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",self.dic[@"iPhoto"]]]];
        if (self.dic[@"iIntr"] == nil) {
           cell.postPeopleJob.text = [NSString stringWithFormat:@""];
        }else {
            cell.postPeopleJob.text = [NSString stringWithFormat:@"%@",self.dic[@"iIntr"]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 4) {
        BFCompanyListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
        BFCarTalentsListModel *model = self.carTalentArray[indexPath.row];
        cell.dataModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (indexPath.section == 5) {
        BFSureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"sureCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.dic[@"inFlag"] intValue] > 0) {
            [cell.sureBtn setTitle:@"已投递" forState:UIControlStateNormal];
            [cell.sureBtn setBackgroundColor:GroundGraryColor];
            cell.sureBtn.userInteractionEnabled = NO;
        }
        else {
            [cell.sureBtn setTitle:@"发送简历" forState:UIControlStateNormal];
            [cell.sureBtn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
            [cell.sureBtn setBackgroundColor:RGBColor(0, 148, 231)];
        }
        cell.pushSureBlock = ^{
            [self clickPostResume];
        };
        voidCell = cell;
    }
    return voidCell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        return 40.0f;
    }
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 190.0f;
    }
    else if (indexPath.section == 1) {
        NSString *str = self.dic[@"jWNote"];
        CGSize size = [UILabel sizeWithString:str font:[UIFont fontWithName:BFfont size:14] size:CGSizeMake(KScreenW - 52, 2000)];
        CGFloat h = size.height + 65 + 10 + 15;
        return h;
    }
    else if (indexPath.section == 2) {
        return 110.0f;
    }
    else if (indexPath.section == 3) {
        return 140.0f;
    }
    else if (indexPath.section == 4) {
        return 135.0f;
    }
    else if (indexPath.section == 5) {
        return 70.0f;
    }
    return 44.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    if (section == 4) {
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 10)];
        spaceView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:spaceView];
        UILabel * sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 12.5, KScreenW / 2, 15)];
        sectionLabel.font = [UIFont fontWithName:BFfont size:16.0f];
        sectionLabel.textAlignment = NSTextAlignmentLeft;
        sectionLabel.textColor = RGBColor(51, 51, 51);
        sectionLabel.text = @"相似职位";
        sectionLabel.frame = CGRectMake(16, 12.5, KScreenW/2, 20);
        [headerView addSubview:sectionLabel];
    }
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        BFCarTalentsListModel *model = self.carTalentArray[indexPath.row];
        NSString *idStr = [NSString stringWithFormat:@"%d",model.jWId];
        NSString *uidStr = GetFromUserDefaults(@"uId");
        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do?jWId=%@&uId=%@",ServerURL,idStr,uidStr];
        [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
            NSDictionary *dict = data;
            NSLog(@"获取到的数据为:%@",dict);
            BFCompanyDetailViewController *detailVC = [[BFCompanyDetailViewController alloc] init];
            detailVC.dic = dict[@"data"];
            [self.navigationController pushViewController:detailVC animated:YES];
        } failureResponse:^(NSError *error) {
            NSLog(@"error - %@",error);
        }];
    }
}

-(void)networkRequset {
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkJTIdSelectList.do?jTId=%@&jWId=%@",ServerURL,self.dic[@"jTId"],self.dic[@"jWId"]];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSLog(@"相似职位推荐为:%@",data);
        NSDictionary *dic = data;
        NSArray *arr = dic[@"data"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BFCarTalentsListModel *model = [[BFCarTalentsListModel alloc] initWithDict:obj];
            [self.carTalentArray addObject:model];
        }];
        [self.tableView reloadData];
        
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(void)clickPostResume {
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobIntentionInsert.do?uId=%@&jWId=%@",ServerURL,GetFromUserDefaults(@"uId"),self.dic[@"jWId"]];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForSuccess:@"发送简历成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (4 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"该职位被禁封"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (5 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"该职位不存在"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (6 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"用户没有简历"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (7 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"该简历已被禁封"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (8 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"您已投递过,7天之内请勿重复投递"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            NSString *err = [NSString stringWithFormat:@"%@",dic[@"msg"]];
            [ZAlertView showSVProgressForErrorStatus:err];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(NSMutableArray<BFCarTalentsListModel *> *)carTalentArray {
    if (!_carTalentArray) {
        _carTalentArray = [NSMutableArray array];
    }
    return _carTalentArray;
}
@end
