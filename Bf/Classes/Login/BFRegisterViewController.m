//
//  BFRegisterViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFRegisterViewController.h"
#import "BFRegisterByPasswordViewController.h"//设置密码
#import "BFAgreementViewController.h"//用户注册协议
#import "BFFindPasswordByVerificationCodeViewController.h"//忘记密码
@interface BFRegisterViewController ()
@property (nonatomic,strong) UITextField *phoneNumber;
@property (nonatomic,strong) UITextField *vcode;
/*验证码按钮*/
@property (nonatomic,strong) UIButton *btn;
@end

@implementation BFRegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"注册页(输入手机号)"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"注册页(输入手机号)"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
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
    logoImg.layer.cornerRadius = 30.0f;
    logoImg.clipsToBounds = YES;
    [self.view addSubview:logoImg];
    
    //+86
    UILabel *fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, logoImg.bottom + 40, 40, 30)];
    fontLabel.text = @"+86";
    fontLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    fontLabel.textColor = [UIColor blackColor];
    [self.view addSubview:fontLabel];
    
    //手机号输入框
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(fontLabel.right, logoImg.bottom + 40, KScreenW - 116 - 40, 30)];
    self.phoneNumber = phoneNumber;
    phoneNumber.placeholder = @"请输入手机号";
    phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    phoneNumber.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.view addSubview:phoneNumber];
    
    //下划线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(58, fontLabel.bottom + 5, KScreenW - 116, 0.50f)];
    line.backgroundColor =[UIColor grayColor];
    [self.view addSubview:line];
    
    //手机验证码输入框
    UITextField *vcode = [[UITextField alloc] initWithFrame:CGRectMake(58, line.bottom + 10, 100, 30)];
    self.vcode = vcode;
    vcode.placeholder = @"手机验证码";
    vcode.keyboardType = UIKeyboardTypeNumberPad;
    vcode.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.view addSubview:vcode];
    
    //发送验证码按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    btn.frame = CGRectMake(KScreenW - 58 - 100, line.bottom + 10, 100, 30);
    [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [btn setTitleColor:RGBColor(0, 126, 212) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSendVerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //下划线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(58, vcode.bottom + 5, KScreenW - 116, 0.50f)];
    line1.backgroundColor =[UIColor grayColor];
    [self.view addSubview:line1];
    
    //网络协议
    UILabel *agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, line1.bottom + 5, KScreenW - 116, 30)];
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAgreementAction)];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"注册代表你已阅读并同意《网校协议》"]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(0, 126, 212)
                          range:NSMakeRange(11,6)];
    agreementLabel.attributedText = AttributedStr;
    agreementLabel.font = [UIFont fontWithName:BFfont size:12.0f];
    [agreementLabel addGestureRecognizer:ges1];
    agreementLabel.userInteractionEnabled = YES;
    [self.view addSubview:agreementLabel];
    
    //下一步
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(58, agreementLabel.bottom + 30, KScreenW - 116, 44);
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:RGBColor(0, 126, 212)];
    sureBtn.layer.cornerRadius = 3.0f;
    [sureBtn addTarget:self action:@selector(clickPasswordeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    //三方登录提示文字
    UIView *line11 = [[UIView alloc] initWithFrame:CGRectMake(58, sureBtn.bottom + 40, KScreenW - 116, 0.50f)];
    line11.backgroundColor = RGBColor(153, 153, 153);
    [self.view addSubview:line11];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 100)/2, sureBtn.bottom + 30, 100, 20)];
    tipLabel.text = @"其他注册方式";
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
    
    //提示文字
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(58, KScreenH - 50 - 60, KScreenW - 116, 60)];
    lbl.text = @"您将收到验证身份的短信,我们不会在任何途径泄露你的手机号码和个人信息";
    lbl.textColor = RGBColor(102, 102, 102);
    lbl.numberOfLines = 0;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.view addSubview:lbl];
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
            [ZAlertView showSVProgressForSuccess:@"注册成功"];
//            [MobClick event:@"login"];
            UIViewController *present = self.presentingViewController;
            while (YES) {
                if (present.presentingViewController) {
                    present = present.presentingViewController;
                }else{
                    break;
                }
            }
            [present dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - 发送验证码的点击事件

-(void)clickSendVerAction {
    BOOL isRightPhone = [RegularExpression isMobileNumber:self.phoneNumber.text];
    if (isRightPhone) {
        NSString *phoneNumber = self.phoneNumber.text;
        NSString *state = @"1";//验证码类型中注册为1
        NSDictionary *dic = @{@"uPhone":phoneNumber,@"state":state};
        [NetworkRequest sendDataWithUrl:SENDVCODE parameters:dic successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"验证码发送成功"];
                SaveToUserDefaults(@"session", dic[@"cookie"]);
                [self starTimer:60];
                self.btn.userInteractionEnabled = NO;
            }
            else if (2 == [dic[@"status"] intValue]){
                [ZAlertView showSVProgressForErrorStatus:@"该用户已被注册"];
            }else if (0 == [dic[@"status"] intValue]){
                [ZAlertView showSVProgressForErrorStatus:@"请勿频繁操作"];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"错误");
        }];
    }
    else {
        self.btn.userInteractionEnabled = NO;
        [ZAlertView showSVProgressForErrorStatus:@"请输入正确格式的手机号"];
    }
}

#pragma mark 计时器
- (void)starTimer:(NSInteger)maxTime{
    //倒计时时间
    __block NSInteger timeOut = maxTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.btn setAttributedTitle:[self string:[NSString stringWithFormat:@"再次发送"] ChangeColorWithChangeColorString:[NSString stringWithFormat:@"再次发送"] withColor:RGBColor(0, 126, 212)] forState:UIControlStateNormal];
                self.btn.userInteractionEnabled = YES;
                [self.btn setTitleColor:MainColor forState:UIControlStateNormal];
                
            });
        } else {
            int allTime = (int)timeOut + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.btn setAttributedTitle:[self string:[NSString stringWithFormat:@"%@ 秒",timeStr] ChangeColorWithChangeColorString:[NSString stringWithFormat:@"%@ 秒",timeStr] withColor:RGBColor(0, 126, 212)] forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

-(NSAttributedString *)string:(NSString *)string ChangeColorWithChangeColorString:(NSString *)subString withColor:(UIColor *)color
{
    NSMutableAttributedString * baseString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange colorRange = NSMakeRange([[baseString string] rangeOfString:subString].location, [[baseString string] rangeOfString:subString].length);
    //需要设置的位置
    [baseString addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    //返回颜色值
    return (NSAttributedString *)baseString;
}


#pragma mark - 网校协议的点击事件

-(void)clickAgreementAction {
    BFAgreementViewController *agreementVC = [[BFAgreementViewController alloc] init];
    [self.navigationController pushViewController:agreementVC animated:YES];
}

#pragma mark - 下一步填写密码的点击事件

-(void)clickPasswordeAction {
    if ([self.phoneNumber.text isEqualToString:@""] || self.phoneNumber.text == nil || [self.vcode.text isEqualToString:@""] || self.vcode.text == nil) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入完整的注册信息"];
    }
    else {
        BFRegisterByPasswordViewController *registerVC = [[BFRegisterByPasswordViewController alloc] init];
        registerVC.phoneNum = self.phoneNumber.text;
        registerVC.yzCode = self.vcode.text;
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:registerVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
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
