//
//  BFLoginViewController.m
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFLoginViewController.h"
#import "BFFindPasswordByVerificationCodeViewController.h"//忘记密码
#import "BFRegisterViewController.h"//注册页面

@interface BFLoginViewController ()
@property (nonatomic,strong) UITextField *phoneNumber;
@property (nonatomic,strong) UITextField *password;
@end

@implementation BFLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"登录页"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"登录页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpInterface];
    //设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //让按钮往左移动15个单位
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    backButton.size = CGSizeMake(40, 30);
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
-(void)clickBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 登录页面

-(void)setUpInterface {
    //logo
    UIImageView *logoImg = [UIImageView new];
    if (KIsiPhoneX) {
        logoImg.frame = CGRectMake((KScreenW - 59)/2, 126, 59, 59);
    }
    else {
        logoImg.frame = CGRectMake((KScreenW - 59)/2, 86, 59, 59);
    }
    logoImg.image = [UIImage imageNamed:@"logo-2"];
    logoImg.layer.cornerRadius = 59.0/2;
    logoImg.clipsToBounds = YES;
    [self.view addSubview:logoImg];
    
    //手机号输入框
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(58, logoImg.bottom + 71, KScreenW - 116, 44)];
    self.phoneNumber = phoneNumber;
    phoneNumber.placeholder = @" 请输入手机号";
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(phoneNumber.frame.origin.x,phoneNumber.frame.origin.y,14.0, phoneNumber.frame.size.height)];
    phoneNumber.leftView = blankView;
    phoneNumber.leftViewMode =UITextFieldViewModeAlways;
    phoneNumber.font = [UIFont fontWithName:BFfont size:14.0f];
    phoneNumber.layer.borderWidth = 0.50f;
    phoneNumber.layer.borderColor = RGBColor(0, 126, 212).CGColor;
    phoneNumber.layer.cornerRadius = 3.0f;
    self.phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneNumber];
    
    //密码输入框
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(58, phoneNumber.bottom + 14, KScreenW - 116, 44)];
    self.password = password;
    password.secureTextEntry = YES;
    password.placeholder = @" 请输入密码";
    UIView *blankView1 = [[UIView alloc] initWithFrame:CGRectMake(password.frame.origin.x,password.frame.origin.y,14.0, password.frame.size.height)];
    password.leftView = blankView1;
    password.leftViewMode =UITextFieldViewModeAlways;
    password.font = [UIFont fontWithName:BFfont size:14.0f];
    password.layer.borderWidth = 0.50f;
    password.layer.borderColor = RGBColor(0, 126, 212).CGColor;
    password.layer.cornerRadius = 3.0f;
    password.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:password];
    
    //验证码登录
    UILabel *verificaLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(password.frame), password.bottom + 12, 100, 20)];
    verificaLabel.text = @"验证码登录";
    verificaLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    verificaLabel.textColor = RGBColor(0, 126, 212);
    verificaLabel.textAlignment = NSTextAlignmentLeft;
    UITapGestureRecognizer *verificaGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickverifica)];
    [verificaLabel addGestureRecognizer:verificaGes];
    verificaLabel.userInteractionEnabled = YES;
    [self.view addSubview:verificaLabel];
    
    //忘记密码
    UILabel *forgetLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 58 - 100, password.bottom + 12, 100, 20)];
    forgetLabel.text = @"忘记密码? ";
    forgetLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    forgetLabel.textColor = RGBColor(0, 126, 212);
    forgetLabel.textAlignment = NSTextAlignmentRight;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickForgetPassword)];
    [forgetLabel addGestureRecognizer:ges];
    forgetLabel.userInteractionEnabled = YES;
    [self.view addSubview:forgetLabel];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(58, forgetLabel.bottom + 40, KScreenW - 116, 44);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:RGBColor(0, 126, 212)];
    loginBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    loginBtn.layer.cornerRadius = 3.0f;
    [loginBtn addTarget:self action:@selector(clickLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //三方登录提示文字
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(58, loginBtn.bottom + 40, KScreenW - 116, 0.50f)];
    line.backgroundColor = RGBColor(153, 153, 153);
    [self.view addSubview:line];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 100)/2, loginBtn.bottom + 30, 100, 20)];
    tipLabel.text = @"其他登录方式";
    tipLabel.textColor = RGBColor(153, 153, 153);
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];

    //QQ登录
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = CGRectMake((KScreenW - 40)/2 - 40 - 30, tipLabel.bottom + 10, 40, 40);
    [qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(clickQQAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];

    //微信登录
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.frame = CGRectMake((KScreenW - 40)/2, tipLabel.bottom + 10, 40, 40);
    [wxBtn setImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(clickWxAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    
    //微博登录
    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sinaBtn.frame = CGRectMake(KScreenW/2 + 20 + 30, tipLabel.bottom + 10, 40, 40);
    [sinaBtn setImage:[UIImage imageNamed:@"新浪微博"] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(clickSinaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    //创建新账号
    UIButton *registerBtn = [[UIButton alloc] init];
    if (iPhone5_5s_5c_5SE) {
        registerBtn.frame = CGRectMake((KScreenW - 100)/2, sinaBtn.bottom + 5, 100, 20);
    }
    else {
        registerBtn.frame = CGRectMake((KScreenW - 100)/2, KScreenH - 100, 100, 30);
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"创建新账号"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:RGBColor(0, 126, 212) range:strRange];
    [registerBtn setAttributedTitle:str forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    registerBtn.layer.cornerRadius = 3.0f;
    [registerBtn addTarget:self action:@selector(clickRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
}

#pragma mark - 忘记密码的点击事件

-(void)clickForgetPassword {
    //忘记密码的点击事件
    BFFindPasswordByVerificationCodeViewController *findPasswordVC = [[BFFindPasswordByVerificationCodeViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:findPasswordVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}
#pragma mark - 验证码的点击事件

- (void)clickverifica {
    BFFindPasswordByVerificationCodeViewController *findPasswordVC = [[BFFindPasswordByVerificationCodeViewController alloc] init];
    findPasswordVC.style = @"2";
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:findPasswordVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 登录的点击事件

-(void)clickLoginAction {
    BOOL isRightPhoneNumber = [RegularExpression isMobileNumber:self.phoneNumber.text];
    if (isRightPhoneNumber) {
        if ([self.password.text isEqualToString:@""] || self.password.text == nil) {
            [ZAlertView showSVProgressForErrorStatus:@"请输入密码"];
        }
        else {
            NSString *phoneStr = self.phoneNumber.text;
            NSString *password = [NSString sha1:self.password.text];
            NSDictionary *dic = @{@"uPhone":phoneStr,@"uPwd":password};
            [NetworkRequest sendDataWithUrl:LOGINURL parameters:dic successResponse:^(id data) {
                NSLog(@"正确!%@",data);
                if ([data isKindOfClass:[NSString class]]) {
                    NSLog(@"字符串");
                }
                else if ([data isKindOfClass:[NSDictionary class]]){
                    NSLog(@"json/字典");
                    NSDictionary *dic = data;
                    NSLog(@"获取到的数据为:%@",dic);
                    if (1 == [dic[@"status"] intValue]) {
                        NSDictionary *userInfo = dic[@"userInfo"];
                        SaveToUserDefaults(@"aBlocked", userInfo[@"aBlocked"]);
                        SaveToUserDefaults(@"bTime", userInfo[@"bTime"]);
                        SaveToUserDefaults(@"iId", userInfo[@"iId"]);
                        SaveToUserDefaults(@"iNickName", userInfo[@"iNickName"]);
                        SaveToUserDefaults(@"iPhoto", userInfo[@"iPhoto"]);
                        SaveToUserDefaults(@"iState", userInfo[@"iState"]);
                        SaveToUserDefaults(@"uCredit", userInfo[@"uCredit"]);
                        SaveToUserDefaults(@"uId", userInfo[@"uId"]);
                        SaveToUserDefaults(@"uPhone", userInfo[@"uPhone"]);
                        SaveToUserDefaults(@"uState", userInfo[@"uState"]);
                        SaveToUserDefaults(@"uStateBf", userInfo[@"uStateBf"]);
                        SaveToUserDefaults(@"uStateSenior", userInfo[@"uStateSenior"]);
                        SaveToUserDefaults(@"uStateVip", userInfo[@"uStateVip"]);
                        SaveToUserDefaults(@"uTime", userInfo[@"uTime"]);
                        SaveToUserDefaults(@"iIntr", userInfo[@"iIntr"]);
                        SaveToUserDefaults(@"token", dic[@"token"]);
                        SaveToUserDefaults(@"session", dic[@"sessionId"]);
                        SaveToUserDefaults(@"loginStatus", @"1");
                        NSLog(@"%@",userInfo);
                        [ZAlertView showSVProgressForSuccess:@"登录成功"];
//                        [MobClick event:@"login"];
                        [self dismissViewControllerAnimated:YES completion:nil];
                        
                    }
                    else if (0 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForErrorStatus:@"密码错误"];
                    }
                    else if (2 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForErrorStatus:@"账号不存在"];
                    }
                    else if (3 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForErrorStatus:@"账号不可用"];
                    }
                }
            } failure:^(NSError *error) {
                NSLog(@"错误!");
            }];
        }
    }
    else {
        [ZAlertView showSVProgressForErrorStatus:@"请输入正确的手机号"];
    }
}

#pragma mark - QQ登录的点击事件

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

#pragma mark - 微信登录的点击事件

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

#pragma mark - 微博登录的点击事件

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

#pragma mark - 第三方登录的点击事件

-(void)networkForThirdLogin:(NSDictionary *)dic thirdState:(NSString *)thirdState ThirdKey:(NSString *)thirdKey nickName:(NSString *)nickname userImg:(NSString *)userImg andiSex:(NSString *)isex {
    [NetworkRequest sendDataWithUrl:ThirdLogin parameters:dic successResponse:^(id data) {
        NSDictionary *thirdLoginDic = data;
        if (1 == [thirdLoginDic[@"status"] intValue]) {
            NSDictionary *userInfoDic = thirdLoginDic[@"userInfo"];
            NSLog(@"用户的个人信息为:%@",userInfoDic);
            SaveToUserDefaults(@"aBlocked", userInfoDic[@"aBlocked"]);
            SaveToUserDefaults(@"bTime", userInfoDic[@"bTime"]);
            SaveToUserDefaults(@"iId", userInfoDic[@"iId"]);
            SaveToUserDefaults(@"iNickName", userInfoDic[@"iNickName"]);
            SaveToUserDefaults(@"iPhoto", userInfoDic[@"iPhoto"]);
            SaveToUserDefaults(@"iState", userInfoDic[@"iState"]);
            SaveToUserDefaults(@"uCredit", userInfoDic[@"uCredit"]);
            SaveToUserDefaults(@"uId", userInfoDic[@"uId"]);
            SaveToUserDefaults(@"uPhone", userInfoDic[@"uPhone"]);
            SaveToUserDefaults(@"uState", userInfoDic[@"uState"]);
            SaveToUserDefaults(@"uStateBf", userInfoDic[@"uStateBf"]);
            SaveToUserDefaults(@"uStateSenior", userInfoDic[@"uStateSenior"]);
            SaveToUserDefaults(@"uStateVip", userInfoDic[@"uStateVip"]);
            SaveToUserDefaults(@"uTime", userInfoDic[@"uTime"]);
            SaveToUserDefaults(@"iIntr", userInfoDic[@"iIntr"]);
            SaveToUserDefaults(@"token", thirdLoginDic[@"token"]);
            SaveToUserDefaults(@"session", thirdLoginDic[@"sessionId"]);
            SaveToUserDefaults(@"loginStatus", @"1");
            [ZAlertView showSVProgressForSuccess:@"登录成功"];
//            [MobClick event:@"login"];
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
        
    }];
}

#pragma mark - 注册的点击事件

-(void)clickRegisterAction {
    BFRegisterViewController *registerVC = [[BFRegisterViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:registerVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

