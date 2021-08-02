//
//  BFCarTalentsUserCenterViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/9.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCarTalentsUserCenterViewController.h"
#import "BFAutherViewController.h"//企业认证
#import "BFCompanyInformationViewController.h"//企业信息
#import "BFPostJobViewController.h"//发布职位
#import "BFPersonalBasicResumeController.h"//个人简历
#import "BFSeniorResumeController.h"//完善简历
#import "BFDropInBoxController.h"//投递箱
#import "BFResumeManagementViewController.h"//简历预览
@interface BFCarTalentsUserCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
/*文字数组*/
@property (nonatomic,copy) NSArray *textArr;
/*图标数组*/
@property (nonatomic,copy) NSArray *iconArr;

/*企业信息状态*/
@property (nonatomic,copy) NSString *informationStr;
/*企业认证资料*/
@property (nonatomic,strong) NSDictionary *authDic;
/*企业信息资料*/
@property (nonatomic,strong) NSDictionary *infoDic;
/*企业主键*/
@property (nonatomic,strong) NSString *jCid;

@property (nonatomic,strong) UIButton *nameBtn;
@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,strong) UIImageView *img;
@end

@implementation BFCarTalentsUserCenterViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    if ([self.centerStyle isEqualToString:@"0"]) {
    }
    else {
        [self networkRequest];
        [self networkRequestCompanyInformation];
        [self networkRequestCompanyAuth];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBackGround];
}

#pragma mark - 企业状态查询
-(void)networkRequest {
    NSString *str = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
    NSDictionary *dic = @{@"uId":str};
    [NetworkRequest requestWithUrl:QueryCompanyCertification parameters:dic successResponse:^(id data) {
        NSDictionary *dict = data;
        if (1 == [dict[@"status"] intValue]) {
            self.informationStr = [NSString stringWithFormat:@"%@",dict[@"perfect"]];
            self.jCid = dict[@"jCId"];
            NSLog(@"企业主键为:%@",self.jCid);
        }
        else if (2 == [dict[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"传入的参数有误"];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
    
}

#pragma mark - 获取企业认证资料
-(void)networkRequestCompanyAuth {
    NSString *str = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
    NSDictionary *dic = @{@"uId":str};
    [NetworkRequest requestWithUrl:QueryCompanyCertificationInformation parameters:dic successResponse:^(id data) {
        NSDictionary *dict = data;
        if (1 == [dict[@"status"] intValue]) {
            self.authDic = dict[@"data"];
            self.companyName = self.authDic[@"jcname"];
            [self.nameBtn setTitle:self.companyName forState:UIControlStateNormal];
        }
        else if (6 == [dict[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"未找到该企业"];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

#pragma mark - 获取企业信息资料
-(void)networkRequestCompanyInformation {
    NSString *str = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
    NSDictionary *dic = @{@"uId":str};
    [NetworkRequest requestWithUrl:QueryCompanyInformation parameters:dic successResponse:^(id data) {
        NSDictionary *dict = data;
        if (1 == [dict[@"status"] intValue]) {
            self.infoDic = dict[@"data"];
            self.logo = self.infoDic[@"jCLogo"];
            [self.img sd_setImageWithURL:[NSURL URLWithString:self.logo]];
        }
        else if (6 == [dict[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"未找到该企业"];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - 创建背景

-(void)createBackGround {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 205)];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nologin"]];
    [self.view addSubview:backView];
    //标题
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 120)/2, 20, 120, 44)];
    if (KIsiPhoneX) {
        lbl.frame = CGRectMake((KScreenW - 120)/2, 44, 120, 44);
    }
    if ([self.centerStyle isEqualToString:@"0"]) {
       lbl.text = @"个人版工作台";
    }
    else {
        lbl.text = @"企业版工作台";
    }
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont fontWithName:BFfont size:17.0f];
    lbl.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:lbl];
    
    //头像
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 53)/2, lbl.bottom + 10, 53, 53)];
    self.img = headImg;
    NSURL *url = [NSURL URLWithString:GetFromUserDefaults(@"iPhoto")];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if ([self.centerStyle isEqualToString:@"0"]) {
        headImg.image = image;
        [headImg sd_setImageWithURL:[NSURL URLWithString:GetFromUserDefaults(@"iPhoto")] placeholderImage:[UIImage imageNamed:@"123"]];
    }else {
        [headImg sd_setImageWithURL:[NSURL URLWithString:self.logo] placeholderImage:[UIImage imageNamed:@"个人版工作台"]];
    }
    headImg.layer.cornerRadius = 53.0/2;
    [headImg.layer setMasksToBounds:YES];
    [backView addSubview:headImg];
    //昵称
    UIButton *changeHeadImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nameBtn = changeHeadImgBtn;
    changeHeadImgBtn.frame = CGRectMake(0, headImg.bottom + 13, KScreenW, 15);
    if ([self.centerStyle isEqualToString:@"0"]) {
        [changeHeadImgBtn setTitle:GetFromUserDefaults(@"iNickName") forState:UIControlStateNormal];
    }else {
        [changeHeadImgBtn setTitle:self.companyName forState:UIControlStateNormal];
    }
    changeHeadImgBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [changeHeadImgBtn setTitleColor:RGBColor(220, 243, 254) forState:UIControlStateNormal];
    changeHeadImgBtn.backgroundColor = [UIColor clearColor];
    [backView addSubview:changeHeadImgBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 205, KScreenW, KScreenH - 205) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    if ([self.centerStyle isEqualToString:@"0"]) {
        self.textArr = @[@"个人简历",@"投递箱"];
        self.iconArr = @[[UIImage imageNamed:@"个人简历"],[UIImage imageNamed:@"投递箱"]];
    }
    else {
        self.textArr = @[@"企业认证",@"企业信息",@"发布职位"];
        self.iconArr = @[[UIImage imageNamed:@"认证"],[UIImage imageNamed:@"企业信息"],[UIImage imageNamed:@"发布职位"]];
    }
    
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.centerStyle isEqualToString:@"0"]) {
        return 2;
    }
    else
        return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.textArr[indexPath.row];
    cell.imageView.image = self.iconArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ([self.centerStyle isEqualToString:@"0"]) {

            
            NSString *uid = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
            NSString *urlS = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeSelect.do?uId=%@",ServerURL,uid];
            
            [NetworkRequest requestWithUrl:urlS parameters:nil successResponse:^(id data) {
                NSDictionary *dic = data;
                if (1 == [dic[@"status"] intValue]) {
                    NSDictionary *dicc = dic[@"data"];
                    NSArray *arrWork = dicc[@"jobExperiences"];
                    NSArray *arrEdu = dicc[@"jobLearns"];
                    if (arrWork.count == 0 && arrEdu.count == 0) {
                        //跳转到填写经历页面中
                        BFSeniorResumeController *seniorVC = [[BFSeniorResumeController alloc] init];
                        [self.navigationController pushViewController:seniorVC animated:YES];
                    }
                    else {
                        //跳转到简历管理页面中
                        BFResumeManagementViewController *resumeVC = [[BFResumeManagementViewController alloc] init];
                        resumeVC.dic = dicc;
                        [self.navigationController pushViewController:resumeVC animated:YES];
                    }
                }
                else if (6 == [dic[@"status"] intValue]) {
                    //跳转到基本简历页面中
                    BFPersonalBasicResumeController *resumeVC = [[BFPersonalBasicResumeController alloc] init];
                    [self.navigationController pushViewController:resumeVC animated:YES];
                }
                else if (5 == [dic[@"status"] intValue]) {
                    //跳转到基本简历页面中
                    [ZAlertView showSVProgressForErrorStatus:@"简历被封禁,请重新填写简历"];
                    BFPersonalBasicResumeController *resumeVC = [[BFPersonalBasicResumeController alloc] init];
                    [self.navigationController pushViewController:resumeVC animated:YES];
                }
            } failureResponse:^(NSError *error) {
                [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
            }];
            
        }
        else {
            BFAutherViewController *authVC = [[BFAutherViewController alloc] init];
            authVC.isAuth = @"0";
            authVC.authDic = self.authDic;
            [self.navigationController pushViewController:authVC animated:YES];
        }
    }
    else if (indexPath.row == 1) {
        if ([self.centerStyle isEqualToString:@"0"]) {
            //投递箱
            BFDropInBoxController *boxVC = [[BFDropInBoxController alloc] init];
            [self.navigationController pushViewController:boxVC animated:YES];
        }
        else {
            BFCompanyInformationViewController *companyVC = [[BFCompanyInformationViewController alloc] init];
            companyVC.informationStr = self.informationStr; //0是已完善  1是未完善
            companyVC.inDic = self.infoDic;
            companyVC.jCid = self.jCid;
            [self.navigationController pushViewController:companyVC animated:YES];
        }
    }
    else if (indexPath.row == 2) {
        if ([self.informationStr isEqualToString:@"1"]) {
            [ZAlertView showSVProgressForErrorStatus:@"请您先完善企业信息"];
        }
        else {
            BFPostJobViewController *postJobVC = [[BFPostJobViewController alloc] init];
            [self.navigationController pushViewController:postJobVC animated:YES];
        }
    }
}


#pragma mark - 返回按钮的点击事件

-(void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
