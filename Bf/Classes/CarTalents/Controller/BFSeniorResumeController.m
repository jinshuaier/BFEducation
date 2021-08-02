//
//  BFSeniorResumeController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/20.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFSeniorResumeController.h"
#import "BFExperienceListCell.h"
#import "BFWorkExModel.h"
#import "BFDoneCell.h"
#import "BFEducationExModel.h"
#import "BFDetailExperienceController.h"//修改或者创建工作/教育经历
#import "BFResumeManagementViewController.h"//简历管理
#import "BFCarTalentsUserCenterViewController.h"//用户工作台
@interface BFSeniorResumeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray <BFWorkExModel *>*workArr;
@property (nonatomic,strong) NSMutableArray <BFEducationExModel *>*eduArr;
@property (nonatomic,strong) NSDictionary *introDic;
@property (nonatomic,strong) UIView *btnView1;
@property (nonatomic,strong) UIView *btnView2;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@end

@implementation BFSeniorResumeController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self networkRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布简历";
    self.view.backgroundColor = [UIColor whiteColor];
    [self networkRequest];
    [self createTableView];
    NSDictionary *introDic = [[NSDictionary alloc] init];
    self.introDic = introDic;
    [self networkRequestForPersonalResume];
    
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
    [btn1 addTarget:self action:@selector(clickAddWorkAction) forControlEvents:UIControlEventTouchUpInside];
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
    [btn2 addTarget:self action:@selector(clickAddEducationAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView2 addSubview:btn2];
    
    
}

#pragma mark - 搭建tableView

-(void)createTableView {
    //最顶部的提示按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"通过"] forState:UIControlStateNormal];
    [btn setTitle:@" 基础简历上传成功" forState:UIControlStateNormal];
    [btn setTitleColor:RGBColor(0, 148, 231) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:12.0f];
    btn.frame = CGRectMake(0, KNavHeight, KScreenW, 40);
    [self.view addSubview:btn];
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavHeight +40.5, KScreenW, KScreenH - KNavHeight - 40.5) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [_tableView registerClass:[BFExperienceListCell class] forCellReuseIdentifier:@"cell0"];
//    [_tableView registerClass:[BFExperienceListCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[BFDoneCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.workArr.count + 1;
    }
    else if (section == 1) {
        return self.eduArr.count + 1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    if (indexPath.section == 0) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        BFExperienceListCell *cell = [BFExperienceListCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
        if (indexPath.row == self.workArr.count) { //添加工作
            [cell addSubview:self.btnView1];
            return voidCell;
        } else {
            BFWorkExModel *model = self.workArr[indexPath.row];
            cell.dataModel = model;
            cell.pushEditBlock = ^(){
                [ZAlertView showSVProgressForSuccess:@"工作经历编辑"];
                BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
                detailVC.exStyle = @"0";
                detailVC.exTitle = @"工作经历";
                detailVC.model00 = model;
                detailVC.edit = @"1";
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            return voidCell;
        }
    }
    if (indexPath.section == 1) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        BFExperienceListCell *cell = [BFExperienceListCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
        if (indexPath.row == self.eduArr.count) {
            [cell addSubview:self.btnView2];
            return voidCell;
        }
        else {
            BFEducationExModel *model = self.eduArr[indexPath.row];
            cell.dataModel1 = model;
            cell.pushEditBlock = ^(){
                [ZAlertView showSVProgressForSuccess:@"教育经历编辑"];
                BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
                detailVC.exStyle = @"1";
                detailVC.exTitle = @"教育经历";
                detailVC.model11 = model;
                detailVC.edit = @"1";
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            return voidCell;
        }
    }
    else if (indexPath.section == 2) {
        BFDoneCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.pushDoneBlock = ^{
            [self clickResumeManagerAction];
        };
        voidCell = cell;
    }
    return voidCell;
}

#pragma mark - 添加工作经历的点击事件

-(void)clickAddWorkAction {
    BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
    detailVC.exStyle = @"0";
    detailVC.exTitle = @"工作经历";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 添加教育经历的点击事件

-(void)clickAddEducationAction {
    BFDetailExperienceController *detailVC = [[BFDetailExperienceController alloc] init];
    detailVC.exStyle = @"1";
    detailVC.exTitle = @"教育经历";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 0.01f;
    }
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row ==self.workArr.count) {
            return 65;
        }
        else {
            BFWorkExModel *model = self.workArr[indexPath.row];
            NSString *str = [NSString stringWithFormat:@"%@",model.jEContent];
            CGSize size = [UILabel sizeWithString:str font:[UIFont fontWithName:BFfont size:14] size:CGSizeMake(KScreenW - 52, 2000)];
            CGFloat h = size.height + 105;
            return h;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row ==self.eduArr.count) {
            return 65;
        }
    }
    else if (indexPath.section == 2) {
        return 70;
    }
    
    return 105.0f;
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
        sectionLabel.text = @"工作经历";
    }
    else if (section == 1) {
        sectionLabel.text = @"教育经历";
    }
    [headerView addSubview:sectionLabel];
    
    return headerView;
}

-(void)clickResumeManagerAction {
    
    BFCarTalentsUserCenterViewController *homeVC = [[BFCarTalentsUserCenterViewController alloc] init];
    UIViewController *target = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[homeVC class]]) { //这里判断是否为你想要跳转的页面
            target = controller;
        }
    }
    if (target) {
        [self.navigationController popToViewController:target animated:YES]; //跳转
    }
}

/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        BFWorkExModel *model = self.workArr[indexPath.row];
        NSString *url0 = [NSString stringWithFormat:@"%@bfJobController/bfJobExperienceDelete.do?jEId=%@",ServerURL,model.jEId];
        [NetworkRequest requestWithUrl:url0 parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"删除成功"];
            }
            else {
                [ZAlertView showSVProgressForSuccess:@"删除失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForSuccess:@"删除失败"];
        }];
        //删除的是工作经历
        [self.workArr removeObjectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1) {
        BFEducationExModel *model = self.eduArr[indexPath.row];
        NSString *url1 = [NSString stringWithFormat:@"%@bfJobController/bfJobLearnDelete.do?jLId=%@",ServerURL,model.jLId];
        [NetworkRequest requestWithUrl:url1 parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"删除成功"];
            }
            else {
                [ZAlertView showSVProgressForSuccess:@"删除失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForSuccess:@"删除失败"];
        }];
        //删除的是教育经历
        [self.eduArr removeObjectAtIndex:indexPath.row];
    }
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 获取教育经历/工作经历的网络请求

-(void)networkRequest {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeExperienceSelect.do?uId=%@",ServerURL,GetFromUserDefaults(@"uId")];
    
        [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                NSDictionary *dicc = dic[@"data"];
                
                NSArray *workDataArr = dicc[@"jobExperiences"];
                [self.workArr removeAllObjects];
                [workDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BFWorkExModel *model = [[BFWorkExModel alloc] initWithDict:obj];
                    [self.workArr addObject:model];
                }];
                
                NSArray *eduDataArr = dicc[@"jobLearns"];
                [self.eduArr removeAllObjects];
                [eduDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BFEducationExModel *model = [[BFEducationExModel alloc] initWithDict:obj];
                    [self.eduArr addObject:model];
                }];
                [self.tableView reloadData];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
        }];
}

-(void)networkRequestForPersonalResume {
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeSelect.do?uId=%@",ServerURL,GetFromUserDefaults(@"uId")];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            NSDictionary *dataDic = dic[@"data"];
            self.introDic = dataDic;
            
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

#pragma mark - lazyLoading

-(NSMutableArray<BFWorkExModel *> *)workArr {
    if (!_workArr) {
        _workArr = [NSMutableArray array];
    }
    return _workArr;
}

-(NSMutableArray<BFEducationExModel *> *)eduArr {
    if (!_eduArr) {
        _eduArr = [NSMutableArray array];
    }
    return _eduArr;
}

@end
