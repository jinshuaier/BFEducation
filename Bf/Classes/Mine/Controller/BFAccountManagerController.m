//
//  BFAccountManagerController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/6.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFAccountManagerController.h"
#import "BFBindingAccountController.h"//绑定/解绑页面
#import "BFFindPasswordByVerificationCodeViewController.h"//找密码页面
@interface BFAccountManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *detailArr;

/*新浪微博*/
@property (nonatomic,copy) NSString *weiboStr;
/*微信*/
@property (nonatomic,copy) NSString *wechatStr;
/*QQ*/
@property (nonatomic,copy) NSString *qqStr;
@end

@implementation BFAccountManagerController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self queryThirdBindingNetwork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    _arr = @[@"新浪微博",@"微信",@"QQ"];
    _detailArr = @[@"未绑定",@"未绑定",@"未绑定"];
    [self createTableView];
}

#pragma mark - 创建tableView

-(void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textColor = RGBColor(102, 102, 102);
    cell.textLabel.text = _arr[indexPath.row];
    cell.detailTextLabel.text = _detailArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        //新浪微博
        if ([self.weiboStr isEqualToString:@"已绑定"]) {
            //跳转到微博绑定成功页面
            BFBindingAccountController *bindAccountVC = [[BFBindingAccountController alloc] init];
            bindAccountVC.thirdTitle = @"新浪微博";
            [self.navigationController pushViewController:bindAccountVC animated:YES];
        }
        else {
            //微博三方登录
            [self clickSinaAction];
        }
    }
    else if (indexPath.row == 1) {
        //微信
        if ([self.wechatStr isEqualToString:@"已绑定"]) {
            //跳转到微信绑定成功页面
            BFBindingAccountController *bindAccountVC = [[BFBindingAccountController alloc] init];
            bindAccountVC.thirdTitle = @"微信";
            [self.navigationController pushViewController:bindAccountVC animated:YES];
        }
        else {
            //微信三方登录
            [self clickWxAction];
        }
    }
    else if (indexPath.row == 2) {
        //QQ
        if ([self.qqStr isEqualToString:@"已绑定"]) {
            //跳转到QQ绑定成功页面
            BFBindingAccountController *bindAccountVC = [[BFBindingAccountController alloc] init];
            bindAccountVC.thirdTitle = @"QQ";
            [self.navigationController pushViewController:bindAccountVC animated:YES];
        }
        else {
            //QQ三方登录
            [self clickQQAction];
        }
    }
}

#pragma mark - 查询第三方绑定状态网络请求

-(void)queryThirdBindingNetwork {
    [NetworkRequest requestWithUrl:ThirdPartBindSelectByUid parameters:nil successResponse:^(id data) {
        NSLog(@"data");
        NSDictionary *dic = data[@"data"];
        _weiboStr = [NSString stringWithFormat:@"%@",dic[@"wbFlag"]];
        _wechatStr = [NSString stringWithFormat:@"%@",dic[@"wxFlag"]];
        _qqStr = [NSString stringWithFormat:@"%@",dic[@"qqFlag"]];
        _detailArr = @[_weiboStr,_wechatStr,_qqStr];
        NSLog(@"详细信息为:%@",_detailArr);
        [self.tableView reloadData];
    } failureResponse:^(NSError *error) {
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - QQ绑定的点击事件

-(void)clickQQAction {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            NSDictionary *dic = @{@"bState":@"1",
                                  @"bKey":resp.unionId
                                  };
            [self networkForThirdLogin:dic thirdState:@"1" ThirdKey:resp.unionId nickName:resp.name userImg:resp.iconurl andiSex:resp.unionGender];
        }
    }];
}

#pragma mark - 微信绑定的点击事件

-(void)clickWxAction {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            NSDictionary *dic = @{@"bState":@"0",
                                  @"bKey":resp.unionId
                                  };
            [self networkForThirdLogin:dic thirdState:@"0" ThirdKey:resp.unionId nickName:resp.name userImg:resp.iconurl andiSex:resp.unionGender];
        }
    }];
}

#pragma mark - 微博绑定的点击事件

-(void)clickSinaAction {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"此处存在错误:%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
            NSDictionary *dic = @{@"bState":@"2",
                                  @"bKey":resp.uid
                                  };
            [self networkForThirdLogin:dic thirdState:@"2" ThirdKey:resp.uid nickName:resp.name userImg:resp.iconurl andiSex:resp.unionGender];
        }
    }];
}

#pragma mark - 第三方绑定的点击事件

-(void)networkForThirdLogin:(NSDictionary *)dic thirdState:(NSString *)thirdState ThirdKey:(NSString *)thirdKey nickName:(NSString *)nickname userImg:(NSString *)userImg andiSex:(NSString *)isex {
    [NetworkRequest sendDataWithUrl:ThirdLogin parameters:dic successResponse:^(id data) {
        NSDictionary *thirdLoginDic = data;
        if (1 == [thirdLoginDic[@"status"] intValue]) {
            [ZAlertView showSVProgressForSuccess:@"绑定成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if (2 == [thirdLoginDic[@"status"] intValue]) {
            //用户去绑定手机号
            BFFindPasswordByVerificationCodeViewController *findPasswordVC = [[BFFindPasswordByVerificationCodeViewController alloc] init];
            findPasswordVC.style = @"1";
            findPasswordVC.thirdType = thirdState;
            findPasswordVC.thirdKey = thirdKey;
            findPasswordVC.nickName = nickname;
            findPasswordVC.userImg = userImg;
            findPasswordVC.isex = isex;
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:findPasswordVC];
            navigation.modalPresentationStyle = 0;
            [self presentViewController:navigation animated:YES completion:nil];
        }
        else if (0 == [thirdLoginDic[@"status"] intValue]) {
            [ZAlertView showSVProgressForErrorStatus:@"服务器异常"];
        }
    } failure:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"绑定失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
