//
//  BFRegisterByPasswordViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/13.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFRegisterByPasswordViewController.h"
@interface BFRegisterByPasswordViewController ()
/*重复新密码*/
@property (nonatomic,strong) UITextField *repeatPassword;
/*新密码*/
@property (nonatomic,strong) UITextField *password;

@property (nonatomic,strong) UIButton *btn;
@end

@implementation BFRegisterByPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"注册页(设置密码)"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"注册页(设置密码)"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置账户密码";
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

#pragma mark - 返回按钮点击事件

-(void)clickBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 创建视图

-(void)setUpInterface {
    //新密码
    UITextField *newPassword = [[UITextField alloc] initWithFrame:CGRectMake(58, 150, KScreenW - 116, 30)];
    self.password = newPassword;
    newPassword.placeholder = @"新密码";
    newPassword.secureTextEntry = YES;
    newPassword.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.view addSubview:newPassword];
    //下划线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(58, newPassword.bottom, newPassword.width, 0.50f)];
    line1.backgroundColor = LineColor;
    [self.view addSubview:line1];
    //重复新密码
    UITextField *repeatPassword = [[UITextField alloc] initWithFrame:CGRectMake(58, line1.bottom + 15, KScreenW - 116, 30)];
    self.repeatPassword = repeatPassword;
    repeatPassword.placeholder = @"确认新密码";
    repeatPassword.secureTextEntry = YES;
    repeatPassword.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.view addSubview:repeatPassword];
    //下划线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(58, repeatPassword.bottom, repeatPassword.width, 0.50f)];
    line2.backgroundColor = LineColor;
    [self.view addSubview:line2];
    //按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = doneBtn;
    doneBtn.frame = CGRectMake(58, line2.bottom + 50, KScreenW - 116, 44);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:RGBColor(0, 126, 212)];
    doneBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    doneBtn.layer.cornerRadius = 3.0f;
    [doneBtn addTarget:self action:@selector(clickDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
}

#pragma mark - 完成按钮的点击事件

-(void)clickDoneAction {
    self.btn.userInteractionEnabled = NO;
    [self.btn setBackgroundColor:[UIColor grayColor]];
    [self performSelector:@selector(setBtnEnabledAct:) withObject:self.btn afterDelay:3.0f];
    if ([self.password.text isEqualToString:@""] || self.password.text == nil || [self.repeatPassword.text isEqualToString:@""] || self.repeatPassword.text == nil) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入密码"];
    }
    else if ([self.yzCode length] != 6) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入正确格式的验证码"];
    }
    else if (![self.password.text isEqualToString:self.repeatPassword.text]) {
        [ZAlertView showSVProgressForErrorStatus:@"前后两次密码输入不一致"];
    }
    else {
        //发送网络请求
        NSString *phone = self.phoneNum;
        NSString *vcode = self.yzCode;
        NSString *deviceUUID  = [BFUUIDManager getDeviceID];
        NSString *password1 = [NSString sha1:self.password.text];
        NSDictionary *dic = @{@"uPhone":phone,@"code":vcode,@"uPwd":password1,@"uSource":@"1",@"uuid":deviceUUID};
        [NetworkRequest sendDataWithUrl:REGISTER parameters:dic successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                NSDictionary *userInfo = dic[@"userInfo"];
                [ZAlertView showSVProgressForSuccess:@"注册成功"];
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
                SaveToUserDefaults(@"session", dic[@"session"]);
                SaveToUserDefaults(@"token", dic[@"token"]);
                SaveToUserDefaults(@"loginStatus", @"1");
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
            else if (0 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"其他未知错误"];
            }
            else if (2 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"验证码错误"];
            }
            else if (3 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"该用户已经存在"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)setBtnEnabledAct:(UIButton *)btn {
    [self.btn setBackgroundColor:RGBColor(0, 126, 212)];
    self.btn.userInteractionEnabled = YES;
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

