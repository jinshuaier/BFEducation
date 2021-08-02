//
//  BFFindPasswordByVerificationCodeViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFFindPasswordByVerificationCodeViewController.h"
#import "BFFindPasswordByNewPasswordViewController.h"//设置新密码
@interface BFFindPasswordByVerificationCodeViewController ()
/*验证码按钮*/
@property (nonatomic,strong) UIButton *btn;
/*手机号输入框*/
@property (nonatomic,strong) UITextField *phoneNumber;
/*验证码输入框*/
@property (nonatomic,strong) UITextField *vcode;
@end

@implementation BFFindPasswordByVerificationCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"找回密码页(输入验证码)"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"找回密码页(输入验证码)"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.style isEqualToString:@"1"]) {
        self.navigationItem.title = @"绑定手机号";
    }
    else {
        self.navigationItem.title = @"验证码获取";
    }
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
    //+86
    UILabel *fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 150, 40, 30)];
    fontLabel.text = @"+86";
    fontLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    fontLabel.textColor = [UIColor blackColor];
    [self.view addSubview:fontLabel];
    
    //手机号输入框
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(fontLabel.right, 150, KScreenW - 116 - 40, 30)];
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
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [btn addTarget:self action:@selector(clickSendVertificationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //下划线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(58, vcode.bottom + 5, KScreenW - 116, 0.50f)];
    line1.backgroundColor =[UIColor grayColor];
    [self.view addSubview:line1];
    
   //下一步
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(58, line1.bottom + 50, KScreenW - 116, 44);
    [sureBtn setTitle:[self.style isEqualToString:@"2" ]? @"登录": @"下一步" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:RGBColor(0, 126, 212)];
    sureBtn.layer.cornerRadius = 3.0f;
    sureBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [sureBtn addTarget:self action:@selector(clickNextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

#pragma mark - 发送验证码的点击事件

-(void)clickSendVertificationAction {
    BOOL isRightPhone = [RegularExpression isMobileNumber:self.phoneNumber.text];
    if (isRightPhone) {
        if ([self.style isEqualToString:@"1"]) {
            NSString *phoneNumber = self.phoneNumber.text;
            NSString *state = @"3";//验证码类型中绑定手机号为3
            NSDictionary *dic = @{@"uPhone":phoneNumber,@"state":state};
            [NetworkRequest sendDataWithUrl:SENDVCODE parameters:dic successResponse:^(id data) {
                NSLog(@"正确");
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
                    [ZAlertView showSVProgressForErrorStatus:@"发送验证码失败"];
                    NSLog(@"%@",dic[@"msg"]);
                }
            } failure:^(NSError *error) {
                NSLog(@"错误");
            }];
        }
        else {
            NSString *phoneNumber = self.phoneNumber.text;
            NSString *state = [self.style isEqualToString:@"2"] ? @"5" : @"2";//验证码类型中找回密码为2
            NSDictionary *dic = @{@"uPhone":phoneNumber,@"state":state};
            [NetworkRequest sendDataWithUrl:SENDVCODE parameters:dic successResponse:^(id data) {
                NSLog(@"正确");
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


#pragma mark - 下一步的点击事件

-(void)clickNextAction {
    BOOL isRightPhone = [RegularExpression isMobileNumber:self.phoneNumber.text];
    if (isRightPhone) {
        if ([self.vcode.text isEqualToString:@""] || self.vcode.text == nil || [self.vcode.text length] != 6) {
            [ZAlertView showSVProgressForErrorStatus:@"请输入正确的验证码"];
        }
        else {
            if ([self.style isEqualToString:@"1"]) {
                NSString *sexStr = @"";
                if ([self.isex isEqualToString:@"男"]) {
                    sexStr = @"0";
                }
                else {
                    sexStr = @"1";
                }
                NSDictionary *dic = @{@"uPhone":self.phoneNumber.text,
                                      @"code":self.vcode.text,
                                      @"bState":self.thirdType,
                                      @"bKey":self.thirdKey,
                                      @"iNickName":self.nickName,
                                      @"photoUrl":self.userImg,
                                      @"iSex":sexStr,
                                      @"uSource":@"1"
                                      };
                [NetworkRequest sendDataWithUrl:ThirdLoginBindingPhone parameters:dic successResponse:^(id data) {
                    NSDictionary *thirdLoginDic = data;
                    if (1 == [thirdLoginDic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForSuccess:@"绑定成功"];
                        NSLog(@"用户的个人信息为:%@",dic);
                        NSDictionary *userInfoDic = thirdLoginDic[@"userInfo"];
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
//                        [MobClick event:@"login"];
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
                    else {
                        if ([[thirdLoginDic allKeys] containsObject:@"msg"]) {
                            [ZAlertView showSVProgressForSuccess:[NSString stringWithFormat:@"%@",thirdLoginDic[@"msg"]]];
                        }
                        
                    }
                } failure:^(NSError *error) {
                    
                }];
            } else if ([self.style isEqualToString:@"2"]){
                // 验证码登录 uSource 注册来源 0=未知1=IOS北方职教2=android北方职教3=IOS搜修车4=Android搜修车5=H5北方职教6=PC北方职教
//                uuid 手机唯一标示
                NSDictionary *dic = @{@"uPhone":self.phoneNumber.text,
                                      @"code":self.vcode.text,
                                      @"uSource":@1,
                                      @"uuid":[BFUUIDManager getDeviceID],
                                      };
                

                [NetworkRequest sendDataWithUrl:BFSMSLogin parameters:dic successResponse:^(id data) {
                    NSDictionary *thirdLoginDic = data;
                    if (1 == [thirdLoginDic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForSuccess:@"绑定成功"];
                        NSLog(@"用户的个人信息为:%@",dic);
                        NSDictionary *userInfoDic = thirdLoginDic[@"userInfo"];
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
                        SaveToUserDefaults(@"token", thirdLoginDic[@"token"]);

                        SaveToUserDefaults(@"usstate", thirdLoginDic[@"usstate"]);
                        SaveToUserDefaults(@"updateTime", thirdLoginDic[@"updateTime"]);

                        if ([[userInfoDic allKeys] containsObject:@"iIntr"]) {
                            SaveToUserDefaults(@"iIntr", userInfoDic[@"iIntr"]);
                        } else {
                            SaveToUserDefaults(@"iIntr", @"");
                        }
                        SaveToUserDefaults(@"session", thirdLoginDic[@"sessionId"]);
                        
                        SaveToUserDefaults(@"loginStatus", @"1");
                        [ZAlertView showSVProgressForSuccess:@"登录成功"];
//                        [MobClick event:@"login"];
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
                    else {
                        if ([[thirdLoginDic allKeys] containsObject:@"msg"]) {
                            [ZAlertView showSVProgressForSuccess:[NSString stringWithFormat:@"%@",thirdLoginDic[@"msg"]]];
                        }

                    }
                } failure:^(NSError *error) {
                    
                }];
                
                

            }
            else {
                BFFindPasswordByNewPasswordViewController *findVC = [[BFFindPasswordByNewPasswordViewController alloc] init];
                findVC.phoneNumer = self.phoneNumber.text;
                findVC.vCode = self.vcode.text;
                UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:findVC];
                navigation.modalPresentationStyle = 0;
                [self presentViewController:navigation animated:YES completion:nil];
            }
        }
    }
    else {
        [ZAlertView showSVProgressForErrorStatus:@"请输入手机号"];
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
