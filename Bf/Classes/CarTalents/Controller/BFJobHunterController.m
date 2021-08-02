//
//  BFJobHunterController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/21.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFJobHunterController.h"
#import "BFJobHunterModel.h"
#import "BFJobHunterCell.h"
#import "BFPreviewResumeController.h"//简历预览页面
@interface BFJobHunterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray <BFJobHunterModel *>*jobArray;
@end

@implementation BFJobHunterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"求职者";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    [self networkRequest];
}

-(void)createInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, KScreenW, KScreenH - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[BFJobHunterCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jobArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    BFJobHunterModel *model = self.jobArray[indexPath.row];
    BFJobHunterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFJobHunterModel *model = self.jobArray[indexPath.row];
    NSString *uidStr = [NSString stringWithFormat:@"%d",model.uId];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeSelect.do?uId=%@",ServerURL,uidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSDictionary *dataDic = dic[@"data"];
            NSMutableArray *arr0 = dataDic[@"jobExperiences"];
            NSMutableArray *arr1 = dataDic[@"jobLearns"];
            BFPreviewResumeController *previewVC = [[BFPreviewResumeController alloc] init];
            previewVC.dic = dataDic;
            previewVC.workArr = arr0;
            previewVC.eduArr = arr1;
            [self.navigationController pushViewController:previewVC animated:YES];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(void)networkRequest {
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobIntentionSelectList.do?jWId=%d",ServerURL,self.jobId];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSArray *arr = dic[@"data"];
            [self.jobArray removeAllObjects];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BFJobHunterModel *model = [[BFJobHunterModel alloc] initWithDict:obj];
                [self.jobArray addObject:model];
            }];
            [self.tableView reloadData];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray<BFJobHunterModel *> *)jobArray {
    if (!_jobArray) {
        _jobArray = [NSMutableArray array];
    }
    return _jobArray;
}

@end
